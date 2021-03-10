class Partie

    attr_accessor :grilleBase, :grilleEnCours, :mode, :tabCoup , :enPause , :completion, :nbAideUtilise, :chrono, :sauvegardes

    private_class_method :new

    def initialize(grille, mode)
      @indiceCoup = -1
      @grilleBase = grille
      @mode = mode
      @grilleEnCours = Marshal.load( Marshal.dump(grille) ) #verif que ça marche
      @grilleEnCours.raz()
    end

    # Methode qui creer une grille
    def creer(grille, mode)
      new()
    end

    # Methode qui retourne la grille
    def getGrilleBase()
      return grilleBase
    end

    # Methode qui donne le mode de jeu
    def getMode()
      return mode
    end

    # Methode qui retourne le tableau des coups
    def getTabCoups()
      return tabCoup
    end

    # Methode qui retourne un boolean pour savoir si la partie est en pause
    def estEnPause?()
        return enPause
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
        
    end

    #Methode qui reprend la partie
    def reprendrePartie()
      #void
    end

    # Methode qui ajoute un coup
    def ajouterCoup(coup)
      if(coup.couleur != coup.case.couleur)
        coup.case.couleur = coup.couleur

        tabCoup.pop(tabCoup.size - indiceCoup - 1) #supprimer les coups annulés
        tabCoup.push(coup)
        indiceCoup += 1
      end
    end

    # Methode qui supprime un coup
    def supprimerCoup(indice)
        #void
    end

    #remet a 0 une grille
    def raz()
      grilleEnCours.raz
      return null
    end

    #methode pour termier la partie
    def termierPartie()
      #void
    end

    # Methode qui ajoute un malus
    def ajouterMalus(int)
      #appel interface
    end

    #affiche la portee des cases
    def afficherPortee(case_)
      #appel interface
    end


    #affiche le nombre de blocs
    def afficheeNbBloc(case_)
      #appel interface
    end

    #affiche les mur de 2 bloc par 2 bloc(en carré)
    def afficherMur2x2()
      #appel interface
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
      while retourArriere == true
      end
    end

    #donne un indice sur le meilleur coup a jouer
    def donneIndice()
      #return void
    end

end
