# load "Affichage/FenetreAPropos.rb"
# load "Affichage/FenetreMenu.rb"
# load "Affichage/FenetreParametre.rb"
# load "Affichage/FenetrePartie.rb"


# Classe principale
class MainApplication
    # sauveagrdes contient l'ensemble des sauvegardes (recompenses, parties, scores et parametres)
    attr_reader :sauvegardes
    # mode actuellement selectionne
    attr_reader :mode
    # liste des fenetres de l'application
    attr_reader :listeFenetre

    # Methode qui permet d'initialiser le jeu
    def initialiser()
        # @listeFenetre = []
        # @listeFenetre << FenetreMenu.creer("Nurikabe") # << = push()
        # @listeFenetre << FenetreAPropos.creer("Nurikabe")
        # @listeFenetre << FenetreParametre.creer("Nurikabe")
        # @listeFenetre << FenetrePartie.creer("Nurikabe")
    end

    # Methode qui permet de lancer une partie avec :
    # * un mode donne
    # * un difficulte donnee
    # * une sauvegarde de partie
    def lancerPartie(mode,difficulte,sauvegarde)
        #
    end

    # Methode qui permet de quitter le jeu
    def quitter()
        #
    end
end