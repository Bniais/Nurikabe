require_relative 'Grille.rb'
require_relative 'Chrono.rb'
require_relative 'Mode.rb'
require_relative 'Coup.rb'
require_relative 'Indice/Indice.rb'
require 'digest'
class Partie
  #TODO definir constantes

  attr_reader :grilleBase, :grilleEnCours, :mode, :tabCoup, :chrono

  private_class_method :new

  def initialize(grille, parametres, sauvegardes) #Créer une nouvelle partie

    @grilleBase = grille
    @parametres = parametres
    @sauvegardes = sauvegardes #TODO Charger la partie si une sauvegarde correspond à la partie

    @tabCoup = Array.new(0);

    @nbAideUtilise = 0
    @indiceCoup = 0
    if(mode == Mode::SURVIE)
      @chrono = ChronoDecompte.creer()
    else
      @chrono = Chrono.creer()
    end
    @chrono.demarrer()

    @grilleEnCours = Marshal.load( Marshal.dump(grille) ) #verif que ça marche
    #@grilleEnCours.raz() #recommence à 0, ne pas faire en cas de sauvegarde trouvée
  end

  # Methode qui creer une grille
  def Partie.creer(grille, parametres, sauvegardes)
    new(grille, parametres, sauvegardes)
  end

  # Methode qui retourne en arrière (le coup)
  def retourArriere()#TOTEST
    if(@indiceCoup > 0) #vérification normalement inutile puisque le bouton devrait être disable
      coupPrecedent = tabCoup.at(@indiceCoup-1)
      coupPrecedent.case.setCouleur(coupPrecedent.couleurBase)
      
      @indiceCoup -= 1 #On passe au coup précédent    

      if(@indiceCoup > 0)
        return true
      else
         return false #Pour dire aux fonctions appelantes qu'on ne pourra plus aller en arrière
        #désactiver le bouton
      end
    end

    return false #Pour dire aux fonctions appelantes qu'on ne pourra plus aller en arrière
  end

  # Methode qui revient en avant(le coup)
  def retourAvant()#TOTEST
    if(@indiceCoup < tabCoup.size) #vérification normalement inutile puisque le bouton devrait être disable
      #On annule en passant au coup suivant
      coupSuivant = tabCoup.at(@indiceCoup)
      coupSuivant.case.setCouleur(coupSuivant.couleur)
      

      @indiceCoup += 1 #On passe au coup suivant

      if(@indiceCoup < tabCoup.size)
        #désactiver le bouton
        return true #Pour dire aux fonctions appelantes qu'on ne pourra plus aller en avant
      else
        return false
      end
    end

    return false #Pour dire aux fonctions appelantes qu'on ne pourra plus aller en avant
  end

  # Methode qui met en pause la partie
  def mettrePause()#TOTEST
    @chrono.mettreEnPause()
  end

  #Methode qui reprend la partie
  def reprendrePartie()#TOTEST
    @chrono.demarrer()
  end

  # Methode qui ajoute un coup
  def ajouterCoup(coup)#TOTEST
    if(coup.couleur != coup.case.couleur && coup.couleur < Couleur::ILE_1) 
      coup.case.couleur = coup.couleur

      tabCoup.pop(tabCoup.size - @indiceCoup) #supprimer les coups annulés
      tabCoup.push(coup)
      @indiceCoup += 1
      return true
    end
    return false
  end


  #remet a 0 une grille
  def raz()#TOTEST
    grilleEnCours.raz()
  end

  #methode pour termier la partie
  def terminerPartie()#TODO
    #supprimer sauvegarde si elle existe
    #sauvegarder score si besoin
    #sauvegarder Recompenses si besoin
  end

  # Methode qui ajoute un malus
  def ajouterMalus(n)#TOTEST
    @chrono.ajouterMalus(n)
  end

  #affiche la portee des cases
  def afficherPortee(case_)#TODO
    #Dit à l'interface d'afficher
  end

  #affiche le nombre de blocs
  def afficherNbBloc(case_)#TOTEST
    #Dit à l'interface d'afficher
    return nbCaseIle(case_)
  end

  #affiche les mur de 2 bloc par 2 bloc(en carré)
  def afficherMur2x2()#TODO
    #Dit à l'interface d'afficher
  end

  #Verifie l'erreur
  def verifierErreur()#TOTEST
    return grilleEnCours.nbDifference(grilleBase)
  end

  #donne la position de l'erreur au joueur
  def donnerErreur()#TOTEST
    return grilleEnCours.firstDifference(grilleBase)
  end

  #revient a la dernière bonne position de jeu
  def revenirPositionBonne() #TOTEST
    while retourArriere() == true && verifierErreur() != 0
      #Retour en arrière tant que c'est encore possible et que la grille est fausse
    end
  end

  #donne un indice sur un coup a jouer
  def donneIndice()
    #Verifier différents cas où une technique peut être appliquée, optimiser en parcourant la grille qu'une fois ?
  
    result = nil

    #1. Island of 1
    result = indiceIle1()

    if(result != nil)
      return result
    end

    #2. Clues separated by one square
    result = indiceIleAdjacente()

    if(result != nil)
      return result
    end

    #3. Diagonally adjacent clues
    result = indiceIleAdjacenteDiagonal()

    if(result != nil)
      return result
    end

    #4. Avoiding wall area of 2x2
    result = indiceEviter2x2()

    if(result != nil)
      return result
    end

    #5. Surrounding a completed island
    result = indiceIleComplete()

    if(result != nil)
      return result
    end

    #6. Surrounded square
    result = indiceCaseIsolee()

    if(result != nil)
      return result
    end

    #7. Wall expansion
    result = indiceExpensionMur()

    if(result != nil)
      return result
    end

    #9. Island expansion from a clue
    result = indiceExpensionIle()

    if(result != nil)
      return result
    end

    #13. Unreachable square
    result = indiceInatteignable()

     if(result != nil)
      return result
    end

    #8. Wall continuity
    result = indiceContinuiteMur()

    if(result != nil)
      return result
    end

    #10. Island expandable only in two directions
    result = indiceExpension2Dir()

    if(result != nil)
      return result
    end

    #11. Hidden island expansion
    result = indiceExpensionCachee()

    if(result != nil)
      return result
    end

    #12. Island continuity
    result = indiceContinuiteIle()

    return result


  end

  def indiceIle1()
    for i in 0..grilleEnCours.tabCases.size-1
      for j in 0..grilleEnCours.tabCases.size-1
        if grilleEnCours.tabCases[i][j].couleur == Couleur::ILE_1
          #On regarde les cases autours
          if i+1 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS #On ne corrige pas les erreurs donc on ne traite pas les cases blanches
            return [Indice::INDICE_ILE_1, grilleEnCours.tabCases[i+1][j]]
          elsif j+1 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS
            return [Indice::INDICE_ILE_1, grilleEnCours.tabCases[i][j+1]]
          elsif j-1 >= 0 && grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS
            return [Indice::INDICE_ILE_1, grilleEnCours.tabCases[i][j-1]]
          elsif i-1 >= 0 && grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS
            return [Indice::INDICE_ILE_1, grilleEnCours.tabCases[i-1][j]]
          end
        end
      end
    end
    

    return nil #On n'a pas trouvé
  end

  def indiceIleAdjacente() #faire indice ile presque finie adjacente ?
    for i in 0..grilleEnCours.tabCases.size-1
      for j in 0..grilleEnCours.tabCases.size-1
        if grilleEnCours.tabCases[i][j].estIle?()
          #On regarde si les cases à 2 distances sont des iles et que la case au milieu n'est pas noire
          if i+2 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS && grilleEnCours.tabCases[i+2][j].estIle?()
            return [Indice::INDICE_ILE_ADJACENTE, grilleEnCours.tabCases[i+1][j]]
          elsif j+2 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS && grilleEnCours.tabCases[i][j+2].estIle?()
            return [Indice::INDICE_ILE_ADJACENTE, grilleEnCours.tabCases[i][j+1]]
          elsif j-2 >= 0 && grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS && grilleEnCours.tabCases[i][j-2].estIle?()
            return [Indice::INDICE_ILE_ADJACENTE, grilleEnCours.tabCases[i][j-1]]
          elsif i-2 >= 0 && grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS && grilleEnCours.tabCases[i-2][j].estIle?()
            return [Indice::INDICE_ILE_ADJACENTE, grilleEnCours.tabCases[i-1][j]]
          end
        end
      end
    end

    return nil #On n'a pas trouvé
  end

  def indiceIleAdjacenteDiagonal()
    for i in 0..grilleEnCours.tabCases.size-1
      for j in 0..grilleEnCours.tabCases.size-1

        if grilleEnCours.tabCases[i][j].estIle?()
          #On regarde si les cases à 2 distances sont des iles et que la case au milieu n'est pas noire
          if i+1 < grilleEnCours.tabCases.size && j+1 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i+1][j+1].estIle?()
            if grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS
              return [Indice::INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i+1][j]]
            elsif grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS
              return [Indice::INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i][j+1]]
            end
          end

          if i+1 < grilleEnCours.tabCases.size && j-1 >= 0 && grilleEnCours.tabCases[i+1][j-1].estIle?()
            if grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS
              return [Indice::INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i+1][j]]
            elsif grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS
              return [Indice::INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i][j-1]]
            end
          end

          if i-1 >= 0 && j+1 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i-1][j+1].estIle?()
            if grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS
              return [Indice::INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i-1][j]]
            elsif grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS
              return [Indice::INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i][j+1]]
            end
          end

          if i-1 >= 0 && j-1 >= 0 && grilleEnCours.tabCases[i-1][j-1].estIle?()
            if grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS
              return [Indice::INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i-1][j]]
            elsif grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS
              return [Indice::INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i][j-1]]
            end
          end
        end
      end
    end

    return nil
  end

  def indiceIleComplete()
    for i in 0..grilleEnCours.tabCases.size-1
      for j in 0..grilleEnCours.tabCases.size-1
        if grilleEnCours.tabCases[i][j].estIle?()
          #On regarde si l'île est complète
          vu = Array.new(grilleEnCours.tabCases.size) {Array.new(grilleEnCours.tabCases.size,false)} #sauvegarder quelles cases on a parcouru
          
          if nbCaseIle(grilleEnCours.tabCases[i][j], vu) == grilleEnCours.tabCases[i][j].couleur
            #Parcours des cases de l'île :
            for x in 0..vu.size-1
              for y in 0..vu.size-1
                if(vu[x][y]) 
                  #On regarde si une case frontalière à l'île est grise
                  if x+1 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[x+1][y].couleur == Couleur::GRIS #On ne corrige pas les erreurs donc on ne traite pas les cases blanches
                    return [Indice::INDICE_ILE_COMPLETE, grilleEnCours.tabCases[x+1][y]]
                  elsif y+1 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[x][y+1].couleur == Couleur::GRIS
                    return [Indice::INDICE_ILE_COMPLETE, grilleEnCours.tabCases[x][y+1]]
                  elsif y-1 >= 0 && grilleEnCours.tabCases[x][y-1].couleur == Couleur::GRIS
                    return [Indice::INDICE_ILE_COMPLETE, grilleEnCours.tabCases[x][y-1]]
                  elsif x-1 >= 0 && grilleEnCours.tabCases[x-1][y].couleur == Couleur::GRIS
                    return [Indice::INDICE_ILE_COMPLETE, grilleEnCours.tabCases[x-1][y]]
                  end
                  
                end
              end
            end
          end
        end
      end
    end
    return nil
  end

  def nbCaseIle(case_, vu) #vu doit être 
    #Compte le nombre de cases blanches appartenant à l'île
    i = case_.positionX
    j = case_.positionY
  
    return parcoursIle(vu, j, i)
  end

  def parcoursIle(vu, i, j)
    
    if( i < 0 || j < 0 || i >= grilleEnCours.tabCases.size || j >= grilleEnCours.tabCases.size || vu[i][j] )
      return 0
    else   
      if(grilleEnCours.tabCases[i][j].couleur == Couleur::BLANC || grilleEnCours.tabCases[i][j].estIle?)
        vu[i][j] = true
        return 1 + parcoursIle(vu, i+1, j) + parcoursIle(vu, i, j+1) + parcoursIle(vu, i-1, j) + parcoursIle(vu, i, j-1)
      else
        return 0
      end
    end
  end

  def indiceCaseIsolee()
    for i in 0..grilleEnCours.tabCases.size-1
      for j in 0..grilleEnCours.tabCases.size-1
        if grilleEnCours.tabCases[i][j].couleur == Couleur::GRIS
          #Parcours en profondeur en cherchant une ile, si pas trouver, on a indice
          found = false
          leeTab = Array.new(grilleEnCours.tabCases.size) {Array.new(grilleEnCours.tabCases.size,-1)}
          leeTab[i][j] = 0
          lastChanges = Array.new(0)
          nextChanges = Array.new(0)
          lastChanges.push(grilleEnCours.tabCases[i][j])
          
          while(!lastChanges.empty? && !found)
            lastChanges.each{|c| 
              if(found)
                break
              end
              #On regarde les cases autour
              x = c.positionY
              y = c.positionX
              
              casesEnvironnantes = Array.new(0)
              if( x+1 < grilleEnCours.tabCases.size)
                casesEnvironnantes.push(grilleEnCours.tabCases[x+1][y])
              end
              if( y+1 < grilleEnCours.tabCases.size)
                casesEnvironnantes.push(grilleEnCours.tabCases[x][y+1])
              end
              if( x-1 >=0)
                casesEnvironnantes.push(grilleEnCours.tabCases[x-1][y])
              end
              if( y-1 >=0)
                casesEnvironnantes.push(grilleEnCours.tabCases[x][y-1])
              end

              casesEnvironnantes.each{ |cc|
                if(leeTab[cc.positionY][cc.positionX] == -1)
                  if(cc.estIle?)
                    found = true
                    break
                  elsif(cc.couleur != Couleur::NOIR)
                    leeTab[cc.positionY][cc.positionX] = 0
                    nextChanges.push(grilleEnCours.tabCases[cc.positionY][cc.positionX])
                  end
                end
              }
            }

            lastChanges = Array.new(nextChanges)
            nextChanges = Array.new(0)
          end

          if(!found)
            return [Indice::INDICE_CASE_ISOLEE, grilleEnCours.tabCases[i][j]]
          end
        end
      end
    end
    return nil
  end


  def indiceExpensionMur()
    #On compte le nombre de cases adjacentes gris adjacentes à un bloc noir, si une seule et il existe des cases noires non-reliée, indice
    vuBloc = Array.new(grilleEnCours.tabCases.size) {Array.new(grilleEnCours.tabCases.size,false)} #sauvegarder quelles cases on a parcouru
    for i in 0..grilleEnCours.tabCases.size-1
      for j in 0..grilleEnCours.tabCases.size-1

        if(!vuBloc[i][j] && grilleEnCours.tabCases[i][j].couleur == Couleur::NOIR)
          vu = Array.new(grilleEnCours.tabCases.size) {Array.new(grilleEnCours.tabCases.size,false)} #sauvegarder quelles cases on a parcouru
          lastChanges = Array.new(0)
          nextChanges = Array.new(0)
          lastChanges.push(grilleEnCours.tabCases[i][j])
          while(!lastChanges.empty?)

            lastChanges.each{|c| 
              
              x = c.positionY
              y = c.positionX
              vuBloc[x][y] = true
              vu[x][y] = true

              if( x+1 < grilleEnCours.tabCases.size && !vu[x+1][y] && grilleEnCours.tabCases[x+1][y].couleur == Couleur::NOIR)            
                nextChanges.push(grilleEnCours.tabCases[x+1][y] )
              end
              
              if( y+1 < grilleEnCours.tabCases.size && !vu[x][y+1] && grilleEnCours.tabCases[x][y+1].couleur == Couleur::NOIR)
                nextChanges.push(grilleEnCours.tabCases[x][y+1])
              end

              if( x-1 >=0 && !vu[x-1][y] && grilleEnCours.tabCases[x-1][y].couleur == Couleur::NOIR)
                nextChanges.push(grilleEnCours.tabCases[x-1][y])
              end

              if( y-1 >=0 && !vu[x][y-1] && grilleEnCours.tabCases[x][y-1].couleur == Couleur::NOIR)
                nextChanges.push(grilleEnCours.tabCases[x][y-1])
              end

            }

            lastChanges = Array.new(nextChanges)
            nextChanges = Array.new(0)
          end

          #compter les voisins gris
          caseGrise = nil
          autreBloc = false
          plusieursVoisins = false
          for s in 0..grilleEnCours.tabCases.size-1
            for t in 0..grilleEnCours.tabCases.size-1
              if(vu[s][t])
                casesEnvironnantes = Array.new(0)
                if( s+1 < grilleEnCours.tabCases.size)
                  casesEnvironnantes.push(grilleEnCours.tabCases[s+1][t])
                end
                if( t+1 < grilleEnCours.tabCases.size)
                  casesEnvironnantes.push(grilleEnCours.tabCases[s][t+1])
                end
                if( s-1 >=0)
                  casesEnvironnantes.push(grilleEnCours.tabCases[s-1][t])
                end
                if( t-1 >=0)
                  casesEnvironnantes.push(grilleEnCours.tabCases[s][t-1])
                end

                casesEnvironnantes.each{|c|
                  #regarder voisins
                  if(c.couleur == Couleur::GRIS && caseGrise == nil )
                    caseGrise = c
                  elsif(c.couleur == Couleur::GRIS && c != caseGrise)
                    plusieursVoisins = true
                    s=vu.size+1
                    t=vu.size+1
                    break
                  end
                }
                
              elsif(autreBloc == false && grilleEnCours.tabCases[s][t].couleur == Couleur::NOIR)
                autreBloc = true
              end
            end
          end

          if(caseGrise != nil && autreBloc == true && plusieursVoisins == false)
            return [Indice::INDICE_EXPENSION_MUR, caseGrise]
          end

        end
      end
    end

    return nil
  end

  def indiceContinuiteMur()
    return nil
  end

  def indiceExpensionIle()
    return nil
  end

  def indiceExpension2Dir()
    return nil
  end

  def indiceContinuiteIle()
    return nil
  end

  def verifPresque2x2(i,j)
    #On regarde si parmis le carré 2x2 de coin supérieur droit (i,j), on a 3 noirs et 1 gris
    nbNoir = 0
    caseGrise = nil
    for x in i..i+1
      for y in j..j+1
        if grilleEnCours.tabCases[x][y].couleur == Couleur::NOIR
            nbNoir+=1;
        elsif caseGrise == nil && grilleEnCours.tabCases[x][y].couleur == Couleur::GRIS
          caseGrise = grilleEnCours.tabCases[x][y];
        else
          return nil
        end
      end
    end

    if(nbNoir == 3 && caseGrise != nil)
      return caseGrise
    else
      return nil
    end
  end

  def indiceEviter2x2()
    for i in 0..grilleEnCours.tabCases.size-2 # -2 car inutil de regarder la dernière ligne et collone car pas de voisins droits et bas
      for j in 0..grilleEnCours.tabCases.size-2
        result = verifPresque2x2(i,j)
        if(result != nil)
          return [Indice::INDICE_EVITER_2x2, result]
        end
      end
    end

    return nil
  end

  def indiceInatteignable()
    #Parcours en largeur pour trouver le chemin le plus court de chaque case vers chaque île, ou sinon simplifier en ignorant les murs et îles mais donne moins d'indice (ou faire les deux pour mêler performance et accuracy)
    for i in 0..grilleEnCours.tabCases.size-1
      for j in 0..grilleEnCours.tabCases.size-1
        if grilleEnCours.tabCases[i][j].couleur == Couleur::GRIS
          #Parcours en profondeur en cherchant une ile, si pas trouver, on a indice
          found = false
          leeTab = Array.new(grilleEnCours.tabCases.size) {Array.new(grilleEnCours.tabCases.size,-1)}
          leeTab[i][j] = 0
          lastChanges = Array.new(0)
          nextChanges = Array.new(0)
          lastChanges.push(grilleEnCours.tabCases[i][j])
          
          depth = 1
          while(!lastChanges.empty? && !found)
            lastChanges.each{|c| 
              if(found)
                break
              end
              #On regarde les cases autour
              x = c.positionY #pourquoi inverser ? idk mais sinon ça bug
              y = c.positionX
              
              casesEnvironnantes = Array.new(0)
              if( x+1 < grilleEnCours.tabCases.size)
                casesEnvironnantes.push(grilleEnCours.tabCases[x+1][y])
              end
              if( y+1 < grilleEnCours.tabCases.size)
                casesEnvironnantes.push(grilleEnCours.tabCases[x][y+1])
              end
              if( x-1 >=0)
                casesEnvironnantes.push(grilleEnCours.tabCases[x-1][y])
              end
              if( y-1 >=0)
                casesEnvironnantes.push(grilleEnCours.tabCases[x][y-1])
              end

              casesEnvironnantes.each{ |cc|

                if(leeTab[cc.positionX][cc.positionY] == -1)
                  
                  if(cc.estIle?)
                    leeTab[cc.positionX][cc.positionY] = -2
                    if(cc.couleur > depth)                     
                      found = true
                      break
                    
                    end
                  elsif(cc.couleur != Couleur::NOIR)
                    leeTab[cc.positionX][cc.positionY] = depth
                    nextChanges.push(grilleEnCours.tabCases[cc.positionX][cc.positionY])
                  end
                end
              }
            }
            lastChanges = Array.new(nextChanges)
            nextChanges = Array.new(0)
            depth+=1
          end
          if(!found)
            return [Indice::INDICE_ILE_INATTEIGNABLE, grilleEnCours.tabCases[i][j]]
          end
        end
      end
    end  
    return nil
  end
end

p = Partie.creer(Grille.creer(4, 
[
[Case.creer(Couleur::NOIR, 0, 0) ,Case.creer(Couleur::NOIR, 1, 0),Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::GRIS, 3, 0)],
[Case.creer(Couleur::NOIR, 0, 1) ,Case.creer(Couleur::BLANC, 1, 1),Case.creer(Couleur::BLANC, 2, 1),Case.creer(Couleur::GRIS, 3, 1)],
[Case.creer(Couleur::NOIR, 0, 2) ,Case.creer(Couleur::BLANC, 1, 2),Case.creer(Couleur::GRIS, 2, 2),Case.creer(Couleur::GRIS, 3, 2)],
[Case.creer(Couleur::BLANC, 0, 3) ,Case.creer(Couleur::GRIS, 1, 3),Case.creer(Couleur::GRIS, 2, 3),Case.creer(Couleur::NOIR, 3, 3)]
]), nil, nil)

p.grilleEnCours.afficher
puts [Indice::MESSAGES[p.indiceExpensionMur()[0]], p.indiceExpensionMur()[1].positionX, p.indiceExpensionMur()[1].positionY] #fait une erreur si pas d'indice trouvé

#handler.changeStatut
#Testé : INDICE_ILE_1, INDICE_EVITER_2x2, INDICE_ILE_INATTEIGNABLE, INDICE_CASE_ISOLEE,INDICE_ILE_COMPLETE
#Moyennement testé : 
#Pas testé : INDICE_ADJACENT, INDICE_ADJACENT_DIAG