load 'Grille.rb'
load 'Chrono.rb'
load 'Mode.rb'

class Partie
    #TODO definir constantes

    attr_reader :grilleBase, :grilleEnCours, :mode, :tabCoup, :enPause

    private_class_method :new

    def initialize(grille, mode, parametres, sauvegardes) #Créer une nouvelle partie

      @grilleBase = grille
      @mode = mode
      @parametres = parametres
      @sauvegardes = sauvegardes #TODO Charger la partie si une sauvegarde correspond à la partie

      @tabCoup = Array.new(0);
      @enPause = false

      @nbAideUtilise = 0
      @indiceCoup = -1
      if(mode == Mode::SURVIE)
        @chrono = ChronoDecompte.creer()
      else
        @chrono = Chrono.creer()
      end
      @chrono.demarrer()

      @grilleEnCours = Marshal.load( Marshal.dump(grille) ) #verif que ça marche
      @grilleEnCours.raz()
    end

    # Methode qui creer une grille
    def Partie.creer(grille, mode, parametres, sauvegardes)
      new(grille, mode, parametres, sauvegardes)
    end

    # Methode qui retourne en arrière (le coup)
    def retourArriere()
      if(indiceCoup > 0) #vérification normalement inutile puisque le bouton devrait être disable
        coupPrecedent = tabCoup.at(indiceCoup-1)
        coupPrecedent.case.setCouleur(coupPrecedent.baseCouleur)
        
        indiceCoup -= 1 #On passe au coup précédent    

        if(indiceCoup <= 0)
          #désactiver le bouton
          return false #Pour dire aux fonctions appelantes qu'on ne pourra plus aller en arrière
        else
          return true
        end
      end

      return false #Pour dire aux fonctions appelantes qu'on ne pourra plus aller en arrière
    end

    # Methode qui revient en avant(le coup)
    def retourAvant()
      if(indiceCoup+1 < tabCoup.size) #vérification normalement inutile puisque le bouton devrait être disable

        #On annule en passant au coup suivant
        coupSuivant = tabCoup.at(indiceCoup+1)
        coupSuivant.case.setCouleur(coupSuivant.couleur)
        
        indiceCoup += 1 #On passe au coup suivant

        if(indiceCoup+1 < tabCoup.size)
          #désactiver le bouton
          return false #Pour dire aux fonctions appelantes qu'on ne pourra plus aller en avant
        else
          return true
        end
      end

      return false #Pour dire aux fonctions appelantes qu'on ne pourra plus aller en avant
    end

    # Methode qui met en pause la partie
    def mettrePause()
       @chrono.mettreEnPause()
    end

    #Methode qui reprend la partie
    def reprendrePartie()
      @chrono.demarrer()
    end

    # Methode qui ajoute un coup
    def ajouterCoup(coup)
      if(coup.couleur != coup.case.couleur) 
        coup.case.couleur = coup.couleur

        tabCoup.pop(tabCoup.size - indiceCoup - 1) #supprimer les coups annulés
        tabCoup.push(coup)
        indiceCoup += 1
        return true
      end
      return false
    end


    #remet a 0 une grille
    def raz()
      grilleEnCours.raz()
      return nil
    end

    #methode pour termier la partie
    def terminerPartie()
      #supprimer sauvegarde si elle existe
      #sauvegarder score si besoin
      #sauvegarder Recompenses si besoin
    end

    # Methode qui ajoute un malus
    def ajouterMalus(n)
      @chrono.ajouterMalus(n)
    end

    #affiche la portee des cases
    def afficherPortee(case_)
      #Dit à l'interface d'afficher
    end

    #affiche le nombre de blocs
    def afficherNbBloc(case_)
      #Dit à l'interface d'afficher
      return nbCaseIle(case_)
    end

    #affiche les mur de 2 bloc par 2 bloc(en carré)
    def afficherMur2x2()
      #Dit à l'interface d'afficher
    end

    #Verifie l'erreur
    def verifierErreur()
      return grilleEnCours.nbDifference(grilleBase)
    end

    #donne la position de l'erreur au joueur
    def donnerErreur()
      return grilleEnCours.firstDifference(grilleBase)
    end

    #revient a la dernière bonne position de jeu
    def revenirPositionBonne()
      while retourArriere() == true
        #Retour en arrière tant que c'est encore possible
      end
    end

    #donne un indice sur un coup a jouer
    def donneIndice()
      #Verifier différents cas où une technique peut être appliquée, optimiser en parcourant la grille qu'une fois ?
    
      result = nil

      #1. Island of 1
      result = indiceIle1(i, j)

      if(result != nil)
        return result
      end

      #2. Clues separated by one square
      result = indiceIleAdjacente(i, j)

      if(result != nil)
        return result
      end

      #3. Diagonally adjacent clues
      result = indiceIleAdjacenteDiagonal(i, j)

      if(result != nil)
        return result
      end

      #4. Surrounding a completed island
      result = indiceIleComplete(i, j)

      if(result != nil)
        return result
      end

      #5. Surrounded square
      result = indiceCaseIsolee(i, j)

      if(result != nil)
        return result
      end

      #6. Wall expansion
      result = indiceExpensionMur(i, j)

      if(result != nil)
        return result
      end

      #7. Wall continuity
      result = indiceContinuiteMur(i, j)

      if(result != nil)
        return result
      end

      #8. Island expansion from a clue
      result = indiceExpensionImpasse(i, j)

      if(result != nil)
        return result
      end

      #9. Island expandable only in two directions
      result = indiceExpension2Dir(i, j)

      if(result != nil)
        return result
      end

      #10. Hidden island expansion
      result = indiceExpensionCachee(i, j)

      if(result != nil)
        return result
      end

      #11. Island continuity
      result = indiceContinuiteIle(i, j)

      if(result != nil)
        return result
      end

      #12. Avoiding wall area of 2x2
      result = indiceEviter2x2(i, j)

      if(result != nil)
        return result
      end

      #13. Unreachable square
      result = indiceInatteignable(i, j)

      return result
    end

    def indiceIle1(i, j)
      for i in 0..grilleEnCours.tabCases.size-1
        for j in 0..grilleEnCours.tabCases.size-1
          if grilleEnCours.tabCases[i][j].couleur == ILE_1
            #On regarde les cases autours
            if i+1 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS #On ne corrige pas les erreurs donc on ne traite pas les cases blanches
              return [INDICE_ILE_1, grilleEnCours.tabCases[i+1][j]]
            elsif j+1 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS
              return [INDICE_ILE_1, grilleEnCours.tabCases[i][j+1]]
            elsif j-1 >= 0 && grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS
              return [INDICE_ILE_1, grilleEnCours.tabCases[i][j-1]]
            elsif i-1 >= 0 && grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS
              return [INDICE_ILE_1, grilleEnCours.tabCases[i-1][j]]
            end
          end
        end
      end
      

      return nil #On n'a pas trouvé
    end

    def indiceIleAdjacente(i, j)

      for i in 0..grilleEnCours.tabCases.size-1
        for j in 0..grilleEnCours.tabCases.size-1
          if grilleEnCours.tabCases[i][j].estIle?()
            #On regarde si les cases à 2 distances sont des iles et que la case au milieu n'est pas noire
            if i+2 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS && tabCases[i+2][j].estIle?()
              return [INDICE_ILE_ADJACENTE, grilleEnCours.tabCases[i+1][j]]
            elsif j+2 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS && tabCases[i][j+2].estIle?()
              return [INDICE_ILE_ADJACENTE, grilleEnCours.tabCases[i][j+1]]
            elsif j-2 >= 0 && grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS && tabCases[i][j-2].estIle?()
              return [INDICE_ILE_ADJACENTE, grilleEnCours.tabCases[i][j-1]]
            elsif i-2 >= 0 && grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS && tabCases[i-2][j].estIle?()
              return [INDICE_ILE_ADJACENTE, grilleEnCours.tabCases[i-1][j]]
            end
          end
        end
      end

      return nil #On n'a pas trouvé
    end

    def indiceIleAdjacenteDiagonal(i, j)
      for i in 0..grilleEnCours.tabCases.size-1
        for j in 0..grilleEnCours.tabCases.size-1

          if grilleEnCours.tabCases[i][j].estIle?()
            #On regarde si les cases à 2 distances sont des iles et que la case au milieu n'est pas noire
            if i+1 < grilleEnCours.tabCases.size && j+1 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i+1][j+1].estIle?()
              if grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS
                return [INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i+1][j]]
              elsif grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS
                return [INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i][j+1]]
              end
            end

            if i+1 < grilleEnCours.tabCases.size && j-1 >= 0 && grilleEnCours.tabCases[i+1][j-1].estIle?()
              if grilleEnCours.tabCases[i+1][j].couleur == Couleur::GRIS
                return [INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i+1][j]]
              elsif grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS
                return [INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i][j-1]]
              end
            end

            if i-1 >= 0 && j+1 < grilleEnCours.tabCases.size && grilleEnCours.tabCases[i-1][j+1].estIle?()
              if grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS
                return [INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i-1][j]]
              elsif grilleEnCours.tabCases[i][j+1].couleur == Couleur::GRIS
                return [INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i][j+1]]
              end
            end

            if i-1 >= 0 && j-1 >= 0 && grilleEnCours.tabCases[i-1][j-1].estIle?()
              if grilleEnCours.tabCases[i-1][j].couleur == Couleur::GRIS
                return [INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i-1][j]]
              elsif grilleEnCours.tabCases[i][j-1].couleur == Couleur::GRIS
                return [INDICE_ILE_ADJACENTE_DIAG, grilleEnCours.tabCases[i][j-1]]
              end
            end
          end
        end
      end

      return nil
    end

    def indiceIleComplete(i, j)
      if grilleEnCours.tabCases[i][j].estIle?()
        #On regarde si l'île est complète
        if nbCaseIle(grilleEnCours.tabCases[i][j]) == grilleEnCours.tabCases[i][j].couleur
          #On regarde si une case frontalière à l'île est grise
          #Parcours des cases de l'île :
          #TODO
        end
      end
      return nil
    end

    def nbCaseIle(case_)
      #Compte le nombre de cases blanches appartenant à l'île
    end

    def indiceCaseIsolee(i, j)
      #Parcours en profondeur en cherchant une ile, si pas trouver, on a indice
      return nil
    end

    def indiceExpensionMur(i, j)
      #On compte le nombre de cases adjacentes grises, si une seule et il existe des cases noires non-reliée, indice
      return nil
    end

    def indiceContinuiteMur(i, j)
      return nil
    end

    def indiceExpensionImpasse(i, j)
      return nil
    end

    def indiceExpension2Dir(i, j)
      return nil
    end

    def indiceExpensionCachee(i, j)
      return nil
    end

    def indiceContinuiteIle(i, j)
      return nil
    end

    def indiceEviter2x2(i, j)
      for i in 0..grilleEnCours.tabCases.size-2 # -2 car inutil de regarder la dernière ligne et collone car pas de voisins droits et bas
        for j in 0..grilleEnCours.tabCases.size-2
          #On regarde si parmis le carré 2x2 de coin supérieur droit (i,j), on a 3 noirs et 1 gris
          nbNoir = 0
          nbGris = 0
          

        end
      end

      return nil
    end

    def indiceInatteignable(i, j)
      return nil
    end
end
print Couleur::GRIS
p = Partie.creer(Grille.creer(2, [[Case.creer(1, 0, 0),Case.creer(0, 1, 0)],[Case.creer(-1, 0, 1), Case.creer(2, 1, 1)]]), 2, nil, nil)
