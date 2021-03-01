load "Fenetre.rb"

# Classe qui gere la fenetre pendant la partie
class FenetrePartie < Fenetre
    # grille de la partie actuelle
    attr_accessor :grille
    # ensembles des sons (effets sonores) de la partie
    attr_accessor :son
    # parametres personnalises par l'utilisateur
    attr_accessor :parametre


    # Methode qui permet de creer une nouvelle partie
    def creer()
        #
    end

    # Methode qui permet d'initialiser la grille de la fenetre
    def initialiser(grille)
        #
    end

    # Methode qui permet de mettre a jour le chrono
    def rafraichirTemps()
        #
    end

    # Methode qui permet de mettre a jour l'affichage d'une case donnee
    def changerEtatCase(case)
        #
    end

    # Methode ..................
    def listenerBoutonCase()
        #
    end

    # Methode pour revenir en arriere (coup precedent)
    def listenerBoutonPrecedent()
        #
    end

    # Methode pour revenir au coup suivant (apres un retour en arriere, un coup suivant est sauvegarde)
    def listenerBoutonSuivant()
        #
    end

    # Methode qui permet de remettre a zero la grille
    def listenerBoutonRemiseAZero()
        #
    end

    # Methode qui permet de mettre en pause la partie
    def listenerBoutonPause()
        #
    end

    # Methode qui permet de quitter la partie
    def listenerQuitterPartie()
        #
    end

    # Methode qui permet de fermer la fenetre de jeu
    def listenerQuitter()
        #
    end
end