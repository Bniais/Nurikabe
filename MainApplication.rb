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
        #
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