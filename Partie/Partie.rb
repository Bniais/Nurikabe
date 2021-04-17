require_relative 'Grille.rb'
require_relative 'Chrono.rb'
require_relative 'Mode.rb'
require_relative 'Coup.rb'
require 'digest'


##
# Classe qui gère le fonctionnement des parties
class Partie

  ##
  # @grilleBase => grille de départ
  # @grilleEnCours => grille en cours
  # @tabCoup => tableau qui stocke tous les coups de la partie
  # @chrono => chrono de la partie
  # @indiceCoupRaz => indice de remise a zero
  # @grilleRaz => grille de remise a zero
  attr_reader :grilleBase, :grilleEnCours, :chrono

  private_class_method :new

  ##
  #Constructeur de Grille
  def initialize(grille) #Créer une nouvelle partie
    @grilleBase = grille
    @grilleRaz = nil
    @tabCoup = Array.new(0);
    @tabCoupRaz = nil

    @nbAideUtilise = 0
    @indiceCoup = 0
    @indiceCoupRaz = nil
    @chrono = Chrono.creer()
    @chrono.demarrer()

    @grilleEnCours = Marshal.load( Marshal.dump(grille) ) #verif que ça marche
    @grilleEnCours.raz() #recommence à 0, ne pas faire en cas de sauvegarde trouvée
  end

  ##
  #Retourne le mode de la partie
  def getMode()
    return Mode::LIBRE
  end

  ##
  #Retourne le nombre de grille réalisées
  def getNbGrilleFinis
      return 0
  end

  ##
  # Methode qui creer une grille et prends en compte les sauvegardes
  def Partie.creer(grille)
    new(grille)
  end

  ##
  # Methode qui permet de savoir si le retour en arriere est possible
  def peutRetourArriere?()
    return @indiceCoup > 0 || @grilleRaz != nil
  end

  ##
  # Methode qui permet de savoir si le joueur peut utiliser le retour en arriere
  def peutRetourArriereReelAhky?()
    return @indiceCoupRaz != nil && @indiceCoupRaz > 0;
  end

  ##
  # Methode qui retourne en arrière (le coup)
  def retourArriere()#TOTEST
    if(@grilleRaz != nil)
      @grilleEnCours = Marshal.load(Marshal.dump(@grilleRaz))
      @tabCoup = Marshal.load(Marshal.dump(@tabCoupRaz))
      @indiceCoup = Marshal.load(Marshal.dump(@indiceCoupRaz))

      @grilleRaz = nil
      return nil
    else
      if(@indiceCoup > 0) #vérification normalement inutile puisque le bouton devrait être disable
        coupPrecedent = @tabCoup.at(@indiceCoup-1)
        @grilleEnCours.tabCases[coupPrecedent.case.positionY][coupPrecedent.case.positionX].couleur = coupPrecedent.couleurBase

        @indiceCoup -= 1 #On passe au coup précédent
        return [peutRetourArriere?, coupPrecedent.case]
      end
      return nil#Pour dire aux fonctions appelantes qu'on ne pourra plus aller en arrière
    end
  end

  ##
  #Permet de savoir si le joueur peut effectuer un retour avant
  #Renvoie un booléen
  def peutRetourAvant?()
    return @indiceCoup < @tabCoup.size
  end

  ##
  # Methode qui revient en avant(le coup)
  def retourAvant()#TOTEST
    if(@indiceCoup < @tabCoup.size) #vérification normalement inutile puisque le bouton devrait être disable
      #On annule en passant au coup suivant
      coupSuivant = @tabCoup.at(@indiceCoup)
      @grilleEnCours.tabCases[coupSuivant.case.positionY][coupSuivant.case.positionX].couleur = coupSuivant.couleur
      @grilleRaz = nil

      @indiceCoup += 1 #On passe au coup suivant
    end

    return [peutRetourAvant?, coupSuivant.case] #Pour dire aux fonctions appelantes si on peut encore aller en avant
  end

  ##
  # Methode qui met en pause la partie
  def mettrePause()#TOTEST
    @chrono.mettreEnPause()
  end

  #Methode qui reprend la partie
  def reprendrePartie()#TOTEST
    @chrono.demarrer()
  end

  ##
  #Tire la prochaine grille
  def grilleSuivante()
    @grilleRaz = nil
    return nil #pas de prochaine
  end

  ##
  # Methode qui retourne le nombre de recompenses
  def getNbRecompense
    return 0
  end

  ##
  # Methode qui ajoute un coup
  def ajouterCoup(coup)#TOTEST
    if(coup.couleur != coup.case.couleur && coup.couleur < Couleur::ILE_1)
      coup.case.couleur = coup.couleur
      @grilleRaz = nil
      @tabCoup.pop(@tabCoup.size - @indiceCoup) #supprimer les coups annulés
      @tabCoup.push(coup)
      @indiceCoup += 1
      return true
    end
    return false
  end


  ##
  #Remet a 0 une grille
  def raz()#TOTEST
    @grilleRaz = Marshal.load(Marshal.dump(@grilleEnCours))
    @indiceCoupRaz = Marshal.load(Marshal.dump(@indiceCoup))
    @tabCoupRaz = Marshal.load(Marshal.dump(@tabCoup))

    @grilleEnCours.raz()
    @indiceCoup = 0
    @tabCoup = Array.new(0);
  end


  ##
  # Methode qui permet de savoir si la grille est terminee
  def partieTerminee?()
    return @grilleEnCours.nbDifferenceBrut(@grilleBase) == 0
  end

  ##
  # Methode qui ajoute un malus
  def ajouterMalus(n)#TOTEST
    @chrono.ajouterMalus(n)
  end

  ##
  #Affiche le nombre de blocs
  def afficherNbBloc(case_)#TOTEST
    vu = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)}
    return [nbCaseIle(case_, vu), vu]
  end

  ##
  # Methode qui permet d'afficher la portee d'une ile
  def porteeIle(i, j)
    vu = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)}
    depth = 0
    lastChanges = Array.new(0)
    nextChanges = Array.new(0)
    lastChanges.push(@grilleEnCours.tabCases[i][j])
    while(!lastChanges.empty? && depth < @grilleEnCours.tabCases[i][j].couleur)

      lastChanges.each{|c|

        x = c.positionY
        y = c.positionX

        vu[x][y] = true

        if( x+1 < @grilleEnCours.tabCases.size && !vu[x+1][y])
          nextChanges.push(@grilleEnCours.tabCases[x+1][y] )
        end

        if( y+1 < @grilleEnCours.tabCases.size && !vu[x][y+1])
          nextChanges.push(@grilleEnCours.tabCases[x][y+1])
        end

        if( x-1 >=0 && !vu[x-1][y] )
          nextChanges.push(@grilleEnCours.tabCases[x-1][y])
        end

        if( y-1 >=0 && !vu[x][y-1])
          nextChanges.push(@grilleEnCours.tabCases[x][y-1])
        end

      }

      lastChanges = Array.new(nextChanges)
      nextChanges = Array.new(0)
      depth+=1
    end

    return vu
  end

  ##
  #Verifie l'erreur
  def verifierErreur(fromUser)#TOTEST
    return @grilleEnCours.nbDifference(@grilleBase)
  end

  ##
  #Donne la position de l'erreur au joueur
  def donnerErreur()#TOTEST
    return @grilleEnCours.firstDifference(@grilleBase)
  end

  ##
  #Revient a la dernière bonne position de jeu
  def revenirPositionBonne() #TOTEST
    while verifierErreur(false) != 0 && retourArriere()[0] == true
      #Retour en arrière tant que c'est encore possible et que la grille est fausse
    end
    @tabCoup = Array.new(0)
    @indiceCoup = 0
  end

  ##
  #Donne un indice sur un coup a jouer
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
    result = indiceCaseIsolee() #DOESNT ALWAYS FIND

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
    result = indiceInatteignable()#DOESNT ALWAYS FIND

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

    #12. Island continuity
    result = indiceContinuiteIle()

    return result


  end

  ##
  # Methode qui permet d'afficher l'aide pour une ile d'indice 1 (cases noires autour)
  private
  def indiceIle1()
    for i in 0..@grilleEnCours.tabCases.size-1
      for j in 0..@grilleEnCours.tabCases.size-1
        if @grilleEnCours.tabCases[i][j].couleur == Couleur::ILE_1
          #On regarde les cases autours
          if i+1 < @grilleEnCours.tabCases.size && @grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS #On ne corrige pas les erreurs donc on ne traite pas les cases blanches
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_1"), grilleEnCours.tabCases[i+1][j]]
          elsif j+1 < @grilleEnCours.tabCases.size && @grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_1"), @grilleEnCours.tabCases[i][j+1]]
          elsif j-1 >= 0 && @grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_1"), @grilleEnCours.tabCases[i][j-1]]
          elsif i-1 >= 0 && @grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_1"), @grilleEnCours.tabCases[i-1][j]]
          end
        end
      end
    end


    return nil #On n'a pas trouvé
  end

  ##
  # Methode qui permet d'afficher l'aide pour une ile adjacente (2 iles separees par une case noire)
  private
  def indiceIleAdjacente() #faire indice ile presque finie adjacente ?
    for i in 0..@grilleEnCours.tabCases.size-1
      for j in 0..@grilleEnCours.tabCases.size-1
        if @grilleEnCours.tabCases[i][j].estIle?()
          #On regarde si les cases à 2 distances sont des iles et que la case au milieu n'est pas noire
          if i+2 < @grilleEnCours.tabCases.size && @grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS && @grilleEnCours.tabCases[i+2][j].estIle?()
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE"), @grilleEnCours.tabCases[i+1][j]]
          elsif j+2 < @grilleEnCours.tabCases.size && @grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS && @grilleEnCours.tabCases[i][j+2].estIle?()
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE"), @grilleEnCours.tabCases[i][j+1]]
          elsif j-2 >= 0 && @grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS && @grilleEnCours.tabCases[i][j-2].estIle?()
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE"), @grilleEnCours.tabCases[i][j-1]]
          elsif i-2 >= 0 && @grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS && @grilleEnCours.tabCases[i-2][j].estIle?()
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE"), @grilleEnCours.tabCases[i-1][j]]
          end
        end
      end
    end

    return nil #On n'a pas trouvé
  end

  ##
  # Methode qui permet d'afficher l'aide pour une ile adjacente en diagonale (2 iles en diagonale separees par une case noire)
  private
  def indiceIleAdjacenteDiagonal() #TOTEST
    for i in 0..@grilleEnCours.tabCases.size-1
      for j in 0..@grilleEnCours.tabCases.size-1

        if @grilleEnCours.tabCases[i][j].estIle?()
          #On regarde si les cases à 2 distances sont des iles et que la case au milieu n'est pas noire
          if i+1 < @grilleEnCours.tabCases.size && j+1 < @grilleEnCours.tabCases.size && @grilleEnCours.tabCases[i+1][j+1].estIle?()
            if @grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS
              return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE_DIAG"), @grilleEnCours.tabCases[i+1][j]]
            elsif @grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS
              return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE_DIAG"), @grilleEnCours.tabCases[i][j+1]]
            end
          end

          if i+1 < @grilleEnCours.tabCases.size && j-1 >= 0 && @grilleEnCours.tabCases[i+1][j-1].estIle?()
            if @grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS
              return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE_DIAG"), @grilleEnCours.tabCases[i+1][j]]
            elsif @grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS
              return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE_DIAG"), @grilleEnCours.tabCases[i][j-1]]
            end
          end

          if i-1 >= 0 && j+1 < @grilleEnCours.tabCases.size && @grilleEnCours.tabCases[i-1][j+1].estIle?()
            if @grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS
              return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE_DIAG"), @grilleEnCours.tabCases[i-1][j]]
            elsif @grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS
              return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE_DIAG"), @grilleEnCours.tabCases[i][j+1]]
            end
          end

          if i-1 >= 0 && j-1 >= 0 && @grilleEnCours.tabCases[i-1][j-1].estIle?()
            if @grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS
              return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE_DIAG"), @grilleEnCours.tabCases[i-1][j]]
            elsif @grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS
              return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_ADJACENTE_DIAG"), @grilleEnCours.tabCases[i][j-1]]
            end
          end
        end
      end
    end

    return nil
  end

  ##
  # Methode qui permet d'afficher l'aide pour une ile complete (ile complete => case adjacente doit etre noire)
  private 
  def indiceIleComplete()
    for i in 0..@grilleEnCours.tabCases.size-1
      for j in 0..@grilleEnCours.tabCases.size-1
        if @grilleEnCours.tabCases[i][j].estIle?()
          #On regarde si l'île est complète
          vu = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)} #sauvegarder quelles cases on a parcouru

          if nbCaseIle(@grilleEnCours.tabCases[i][j], vu) == @grilleEnCours.tabCases[i][j].couleur
            #Parcours des cases de l'île :
            for x in 0..vu.size-1
              for y in 0..vu.size-1
                if(vu[x][y])
                  #On regarde si une case frontalière à l'île est grise
                  if x+1 < @grilleEnCours.tabCases.size && @grilleEnCours.tabCases[x+1][y].couleur == Couleur::GRIS #On ne corrige pas les erreurs donc on ne traite pas les cases blanches
                    return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_COMPLETE"), @grilleEnCours.tabCases[x+1][y]]
                  elsif y+1 < @grilleEnCours.tabCases.size && @grilleEnCours.tabCases[x][y+1].couleur == Couleur::GRIS
                    return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_COMPLETE"), @grilleEnCours.tabCases[x][y+1]]
                  elsif y-1 >= 0 && @grilleEnCours.tabCases[x][y-1].couleur == Couleur::GRIS
                    return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_COMPLETE"), @grilleEnCours.tabCases[x][y-1]]
                  elsif x-1 >= 0 && @grilleEnCours.tabCases[x-1][y].couleur == Couleur::GRIS
                    return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_COMPLETE"), @grilleEnCours.tabCases[x-1][y]]
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

  ##
  #Compte le nombre de cases blanches appartenant à l'île
  public
  def nbCaseIle(case_, vu) #vu doit être

    i = case_.positionX
    j = case_.positionY

    return parcoursIle(vu, j, i)
  end

  ##
  # A COMPLETER
  private
  def parcoursIle(vu, i, j)

    if( i < 0 || j < 0 || i >= @grilleEnCours.tabCases.size || j >= @grilleEnCours.tabCases.size || vu[i][j] )
      return 0
    else
      if(@grilleEnCours.tabCases[i][j].couleur == Couleur::BLANC || @grilleEnCours.tabCases[i][j].estIle?)
        vu[i][j] = true
        return 1 + parcoursIle(vu, i+1, j) + parcoursIle(vu, i, j+1) + parcoursIle(vu, i-1, j) + parcoursIle(vu, i, j-1)
      else
        return 0
      end
    end
  end

  ##
  # Methode qui permet d'afficher l'aide pour une ile isolee (ile qui n'a pas de chemin possible == entouree par des murs)
  def indiceCaseIsolee()
    for i in 0..@grilleEnCours.tabCases.size-1
      for j in 0..@grilleEnCours.tabCases.size-1
        if @grilleEnCours.tabCases[i][j].couleur == Couleur::GRIS
          #Parcours en profondeur en cherchant une ile, si pas trouver, on a indice
          found = false
          leeTab = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,-1)}
          leeTab[i][j] = 0
          lastChanges = Array.new(0)
          nextChanges = Array.new(0)
          lastChanges.push(@grilleEnCours.tabCases[i][j])

          while(!lastChanges.empty? && !found)
            lastChanges.each{|c|
              if(found)
                break
              end
              #On regarde les cases autour
              x = c.positionY
              y = c.positionX

              casesEnvironnantes = Array.new(0)
              if( x+1 < @grilleEnCours.tabCases.size)
                casesEnvironnantes.push(@grilleEnCours.tabCases[x+1][y])
              end
              if( y+1 < @grilleEnCours.tabCases.size)
                casesEnvironnantes.push(@grilleEnCours.tabCases[x][y+1])
              end
              if( x-1 >=0)
                casesEnvironnantes.push(@grilleEnCours.tabCases[x-1][y])
              end
              if( y-1 >=0)
                casesEnvironnantes.push(@grilleEnCours.tabCases[x][y-1])
              end

              casesEnvironnantes.each{ |cc|
                if(leeTab[cc.positionY][cc.positionX] == -1)
                  if(cc.estIle?)
                    found = true
                    break
                  elsif(cc.couleur != Couleur::NOIR)
                    leeTab[cc.positionY][cc.positionX] = 0
                    nextChanges.push(@grilleEnCours.tabCases[cc.positionY][cc.positionX])
                  end
                end
              }
            }

            lastChanges = Array.new(nextChanges)
            nextChanges = Array.new(0)
          end

          if(!found)
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("CASE_ISOLEE"), @grilleEnCours.tabCases[i][j]]
          end
        end
      end
    end
    return nil
  end

  ##
  #On compte le nombre de cases adjacentes gris adjacentes à un bloc noir, si une seule et il existe des cases noires non-reliée, indice
  private
  def indiceExpensionMur()
    vuBloc = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)} #sauvegarder quelles cases on a parcouru
    for i in 0..@grilleEnCours.tabCases.size-1
      for j in 0..@grilleEnCours.tabCases.size-1

        if(!vuBloc[i][j] && @grilleEnCours.tabCases[i][j].couleur == Couleur::NOIR)
          vu = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)} #sauvegarder quelles cases on a parcouru
          lastChanges = Array.new(0)
          nextChanges = Array.new(0)
          lastChanges.push(@grilleEnCours.tabCases[i][j])
          while(!lastChanges.empty?)

            lastChanges.each{|c|

              x = c.positionY
              y = c.positionX
              vuBloc[x][y] = true
              vu[x][y] = true

              if( x+1 < @grilleEnCours.tabCases.size && !vu[x+1][y] && @grilleEnCours.tabCases[x+1][y].couleur == Couleur::NOIR)
                nextChanges.push(@grilleEnCours.tabCases[x+1][y] )
              end

              if( y+1 < @grilleEnCours.tabCases.size && !vu[x][y+1] && @grilleEnCours.tabCases[x][y+1].couleur == Couleur::NOIR)
                nextChanges.push(@grilleEnCours.tabCases[x][y+1])
              end

              if( x-1 >=0 && !vu[x-1][y] && @grilleEnCours.tabCases[x-1][y].couleur == Couleur::NOIR)
                nextChanges.push(@grilleEnCours.tabCases[x-1][y])
              end

              if( y-1 >=0 && !vu[x][y-1] && @grilleEnCours.tabCases[x][y-1].couleur == Couleur::NOIR)
                nextChanges.push(@grilleEnCours.tabCases[x][y-1])
              end

            }

            lastChanges = Array.new(nextChanges)
            nextChanges = Array.new(0)
          end

          #compter les voisins gris
          caseGrise = nil
          autreBloc = false
          plusieursVoisins = false
          for s in 0..@grilleEnCours.tabCases.size-1
            for t in 0..@grilleEnCours.tabCases.size-1
              if(vu[s][t])
                casesEnvironnantes = Array.new(0)
                if( s+1 < @grilleEnCours.tabCases.size)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s+1][t])
                end
                if( t+1 < @grilleEnCours.tabCases.size)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s][t+1])
                end
                if( s-1 >=0)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s-1][t])
                end
                if( t-1 >=0)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s][t-1])
                end

                casesEnvironnantes.each{|c|
                  #regarder voisins
                  if(c.couleur == Couleur::GRIS && caseGrise == nil )
                    caseGrise = c
                  elsif(c.couleur == Couleur::GRIS && c != caseGrise)
                    plusieursVoisins = true
                    break
                  end
                }

              elsif(autreBloc == false && @grilleEnCours.tabCases[s][t].couleur == Couleur::NOIR)
                autreBloc = true
              end
            end
          end

          if(caseGrise != nil && autreBloc == true && plusieursVoisins == false)
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("EXPENSION_MUR"), caseGrise]
          end

        end
      end
    end

    return nil
  end

  ##
  #On compte le nombre de cases grises adjacentes à un bloc d'ile, si une seule, indice
  private 
  def indiceExpensionIle()
    vuBloc = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)} #sauvegarder quelles cases on a parcouru
    for i in 0..@grilleEnCours.tabCases.size-1
      for j in 0..@grilleEnCours.tabCases.size-1

        if(!vuBloc[i][j] && @grilleEnCours.tabCases[i][j].estIle? && nbCaseIle(@grilleEnCours.tabCases[i][j], Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)}) != @grilleEnCours.tabCases[i][j].couleur)
          vu = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)} #sauvegarder quelles cases on a parcouru
          lastChanges = Array.new(0)
          nextChanges = Array.new(0)
          lastChanges.push(@grilleEnCours.tabCases[i][j])
          while(!lastChanges.empty?)

            lastChanges.each{|c| #FAIT CRASH

              x = c.positionY
              y = c.positionX
              vuBloc[x][y] = true
              vu[x][y] = true

              if( x+1 < @grilleEnCours.tabCases.size && !vu[x+1][y] && @grilleEnCours.tabCases[x+1][y].couleur == Couleur::BLANC)
                nextChanges.push(@grilleEnCours.tabCases[x+1][y] )
              end

              if( y+1 < @grilleEnCours.tabCases.size && !vu[x][y+1] && @grilleEnCours.tabCases[x][y+1].couleur == Couleur::BLANC)
                nextChanges.push(@grilleEnCours.tabCases[x][y+1])
              end

              if( x-1 >=0 && !vu[x-1][y] && @grilleEnCours.tabCases[x-1][y].couleur == Couleur::BLANC)
                nextChanges.push(@grilleEnCours.tabCases[x-1][y])
              end

              if( y-1 >=0 && !vu[x][y-1] && @grilleEnCours.tabCases[x][y-1].couleur == Couleur::BLANC)
                nextChanges.push(@grilleEnCours.tabCases[x][y-1])
              end

            }

            lastChanges = Array.new(nextChanges)
            nextChanges = Array.new(0) #FAIT CRASH
          end

          #compter les voisins gris
          caseGrise = nil
          plusieursVoisins = false
          nbIle = 0
          for s in 0..@grilleEnCours.tabCases.size-1
            for t in 0..@grilleEnCours.tabCases.size-1
              if(vu[s][t])
                nbIle += 1
                casesEnvironnantes = Array.new(0)
                if( s+1 < @grilleEnCours.tabCases.size)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s+1][t])
                end
                if( t+1 < @grilleEnCours.tabCases.size)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s][t+1])
                end
                if( s-1 >=0)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s-1][t])
                end
                if( t-1 >=0)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s][t-1])
                end

                casesEnvironnantes.each{|c|
                  #regarder voisins
                  if(c.couleur == Couleur::GRIS && caseGrise == nil )
                    caseGrise = c
                  elsif(c.couleur == Couleur::GRIS && c != caseGrise)
                    plusieursVoisins = true
                    break
                  end
                }
              end
            end
          end

          if(nbIle < @grilleEnCours.tabCases[i][j].couleur && caseGrise != nil && plusieursVoisins == false)
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("EXPENSION_ILE"), caseGrise]
          end

        end
      end
    end

    return nil
  end

  ##
  #On compte le nombre de cases grises adjacentes à un bloc d'ile, si deux adjacents diagonalement on renvoie un indice
  private 
  def indiceExpension2Dir()
    vuBloc = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)} #sauvegarder quelles cases on a parcouru
    for i in 0..@grilleEnCours.tabCases.size-1
      for j in 0..@grilleEnCours.tabCases.size-1

        if(!vuBloc[i][j] && @grilleEnCours.tabCases[i][j].estIle?&& nbCaseIle(@grilleEnCours.tabCases[i][j], Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)}) != @grilleEnCours.tabCases[i][j].couleur)
          vu = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,false)} #sauvegarder quelles cases on a parcouru
          lastChanges = Array.new(0)
          nextChanges = Array.new(0)
          lastChanges.push(@grilleEnCours.tabCases[i][j])
          while(!lastChanges.empty?)

            lastChanges.each{|c|

              x = c.positionY
              y = c.positionX
              vuBloc[x][y] = true
              vu[x][y] = true

              if( x+1 < @grilleEnCours.tabCases.size && !vu[x+1][y] && @grilleEnCours.tabCases[x+1][y].couleur == Couleur::BLANC)
                nextChanges.push(@grilleEnCours.tabCases[x+1][y] )
              end

              if( y+1 < @grilleEnCours.tabCases.size && !vu[x][y+1] && @grilleEnCours.tabCases[x][y+1].couleur == Couleur::BLANC)
                nextChanges.push(@grilleEnCours.tabCases[x][y+1])
              end

              if( x-1 >=0 && !vu[x-1][y] && @grilleEnCours.tabCases[x-1][y].couleur == Couleur::BLANC)
                nextChanges.push(@grilleEnCours.tabCases[x-1][y])
              end

              if( y-1 >=0 && !vu[x][y-1] && @grilleEnCours.tabCases[x][y-1].couleur == Couleur::BLANC)
                nextChanges.push(@grilleEnCours.tabCases[x][y-1])
              end

            }

            lastChanges = Array.new(nextChanges)
            nextChanges = Array.new(0)
          end

          #compter les voisins gris
          caseGrise = nil
          caseGrise2 = nil
          plusieursVoisins = false
          nbIle = 0
          for s in 0..@grilleEnCours.tabCases.size-1
            for t in 0..@grilleEnCours.tabCases.size-1
              if(vu[s][t])
                nbIle += 1
                casesEnvironnantes = Array.new(0)
                if( s+1 < @grilleEnCours.tabCases.size)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s+1][t])
                end
                if( t+1 < @grilleEnCours.tabCases.size)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s][t+1])
                end
                if( s-1 >=0)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s-1][t])
                end
                if( t-1 >=0)
                  casesEnvironnantes.push(@grilleEnCours.tabCases[s][t-1])
                end

                casesEnvironnantes.each{|c|
                  #regarder voisins
                  if(c.couleur == Couleur::GRIS)
                    if(caseGrise == nil )
                      caseGrise = c
                    elsif(caseGrise2 == nil && c != caseGrise)
                      caseGrise2 = c
                    elsif(c != caseGrise && c != caseGrise2)
                      plusieursVoisins = true
                      break
                    end
                  end


                }
              else
              end

            end
          end
          if(nbIle == @grilleEnCours.tabCases[i][j].couleur-1 && caseGrise != nil  && caseGrise2 != nil && plusieursVoisins == false)
            #verif elles sont diag
            if (caseGrise.positionX - caseGrise2.positionX).abs == 1 && (caseGrise.positionY - caseGrise2.positionY).abs == 1
              #verif la case adjacentes est blanche
              if @grilleEnCours.tabCases[caseGrise.positionY][caseGrise2.positionX].couleur == Couleur::GRIS
                return [Sauvegardes.getInstance.getSauvegardeLangue.gt("EXPENSION_2D"), @grilleEnCours.tabCases[caseGrise.positionY][caseGrise2.positionX]]
              elsif @grilleEnCours.tabCases[caseGrise2.positionY][caseGrise.positionX].couleur == Couleur::GRIS
                return [Sauvegardes.getInstance.getSauvegardeLangue.gt("EXPENSION_2D"), @grilleEnCours.tabCases[caseGrise2.positionY][caseGrise.positionX]]
              end
            end
          end
        end
      end
    end

    return nil
  end

  ##
  #Chercher tous les chemins possibles liant une case blanche non-reliée aux iles accessibles, et si une case en commun parmis tous ces chemins, on peut la colorier
  private
  def indiceContinuiteIle()#WONTDO
    return nil
  end

  ##
  #Chercher tous les chemins possibles liant une case noire non-reliée à un autre mur, et si une case en commun parmis tous ces chemins, on peut la colorier
  private
  def indiceContinuiteMur() #WONTDO
    return nil
  end

  ##
  #On regarde si parmis le carré 2x2 de coin supérieur droit (i,j), on a 3 noirs et 1 gris
  private
  def verifPresque2x2(i,j)
    nbNoir = 0
    caseGrise = nil
    for x in i..i+1
      for y in j..j+1
        if @grilleEnCours.tabCases[x][y].couleur == Couleur::NOIR
            nbNoir+=1;
        elsif caseGrise == nil && @grilleEnCours.tabCases[x][y].couleur == Couleur::GRIS
          caseGrise = @grilleEnCours.tabCases[x][y];
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

  ##
  # Methode qui permet d'afficher l'aide pour un mur 2x2
  private
  def indiceEviter2x2()
    for i in 0..@grilleEnCours.tabCases.size-2 # -2 car inutil de regarder la dernière ligne et collone car pas de voisins droits et bas
      for j in 0..@grilleEnCours.tabCases.size-2
        result = verifPresque2x2(i,j)
        if(result != nil)
          return [Sauvegardes.getInstance.getSauvegardeLangue.gt("EVITER_2x2"), result]
        end
      end
    end

    return nil
  end

  ##
  # Methode qui permet d'afficher l'aide pour une case inatteignable (case isolee qui prend en compte la portee des iles)
  private
  def indiceInatteignable() #TOFIX
    #Parcours en largeur pour trouver le chemin le plus court de chaque case vers chaque île, ou sinon simplifier en ignorant les murs et îles mais donne moins d'indice (ou faire les deux pour mêler performance et accuracy)
    for i in 0..@grilleEnCours.tabCases.size-1
      for j in 0..@grilleEnCours.tabCases.size-1

        if @grilleEnCours.tabCases[j][i].couleur == Couleur::GRIS
          #Parcours en profondeur en cherchant une ile, si pas trouver, on a indice
          found = false
          leeTab = Array.new(@grilleEnCours.tabCases.size) {Array.new(@grilleEnCours.tabCases.size,-1)}
          leeTab[i][j] = 0
          lastChanges = Array.new(0)
          nextChanges = Array.new(0)
          lastChanges.push(@grilleEnCours.tabCases[i][j])

          depth = 1
          while(!lastChanges.empty? && !found)
            lastChanges.each{|c|
              if(found)
                break
              end
              #On regarde les cases autour
              x = c.positionX #pourquoi inverser ? idk mais sinon ça bug
              y = c.positionY

              casesEnvironnantes = Array.new(0)
              if( x+1 < @grilleEnCours.tabCases.size)
                casesEnvironnantes.push(@grilleEnCours.tabCases[x+1][y])
              end
              if( y+1 < @grilleEnCours.tabCases.size)
                casesEnvironnantes.push(@grilleEnCours.tabCases[x][y+1])
              end
              if( x-1 >=0)
                casesEnvironnantes.push(@grilleEnCours.tabCases[x-1][y])
              end
              if( y-1 >=0)
                casesEnvironnantes.push(@grilleEnCours.tabCases[x][y-1])
              end

              casesEnvironnantes.each{ |cc|
                if(leeTab[cc.positionX][cc.positionY] == -1)

                  if(cc.estIle?)
                    leeTab[cc.positionX][cc.positionY] = -2
                    if(cc.couleur > depth)
                      found = true
                      break
                    end
                  end
                  if(cc.couleur != Couleur::NOIR)
                    leeTab[cc.positionX][cc.positionY] = depth
                    nextChanges.push(@grilleEnCours.tabCases[cc.positionX][cc.positionY])
                  end
                end
              }
            }
            lastChanges = Array.new(nextChanges)
            nextChanges = Array.new(0)
            depth+=1
          end
          if(!found)
            return [Sauvegardes.getInstance.getSauvegardeLangue.gt("ILE_INATTEIGNABLE"), @grilleEnCours.tabCases[j][i]]
          end
        end
      end
    end
    return nil
  end
end