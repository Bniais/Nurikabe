class Partie

    attr_accessor :grille, :mode, :tabCoup , :enPause , :completion, :nbAideUtilise, :chrono, :sauvegardes


    # Methode qui creer une grille
    def creer(grille, mode)

    end

    # Methode qui retourne la grille
    def getGrille()
        #return grille
    end

    # Methode qui donne le mode de jeu
    def getMode()
        # return mode
    end

    # Methode qui retourne le tableau des coups
    def getTabCoups()
        # tabCoups[]
    end

    # Methode qui retourne un boolean pour savoir si la partie est en pause
    def estEnPause?()
        #boolean
    end

    # Methode qui retourne en arrière (le coup)
    def retourArriere()
        #void
    end

    # Methode qui revient en avant(le coup)
    def retourAvant()
        #void
    end

    # Methode qui met en pause la partie
    def mettrePause()
        #void
    end

    #Methode qui reprend la partie
    def reprendrePartie()
      #void
    end

    # Methode qui ajout un coup
    def ajouterCoup(coup)
        #void
    end

    # Methode qui supprime un coup
    def supprimerCoup()
        #void
    end

    #remet a 0 une grille
    def raz()
      #void
    end


    #methode pour termier la partie
    def termierPartie()
      #void
    end

    # Methode qui ajoute un malus
    def retourArriere(int)
        #void
    end

    #affiche la portee des cases
    def afficherPortee(case)
      #void
    end


    #affiche le nombre de blocs
    def afficheeNbBloc(case)
      #void
    end

    #affiche les mur de 2 bloc par 2 bloc(en carré)
    def afficherMur2x2()
      #void
    end

    #Verifie l'erreur
    def verifierErreur()
      #return int
    end

    #donne la position de l'erreur au joueur
    def donnerErreur()
      #return case
    end

    #revient a la dernière bonne position de jeu
    def revenirPositionBonne()
      #return void
    end

    #donne un indice sur le meilleur coup a jouer
    def donneIndice()
      #return void
    end



end
