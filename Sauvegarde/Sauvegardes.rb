# Classe qui contient l'ensemble des sauvegardes
class Sauvegardes
    # tableau des sauvegardes de parties
    attr_accessor :sauvegardePartie
    # tableau des sauvegardes des scores
    attr_accessor :sauvegardeScore
    # tableau des sauvegardes de recompenses
    attr_accessor :sauvegardeRecompense
    # tableau de sauvegarde des parametres
    attr_accessor :sauvegardeParametre


    # Methode qui charge toutes les sauvegardes
    def charger()
        # return un booleen
    end

    # Methode qui retourne la sauvegarde d'une partie pour un mode et une grille donnes
    def getSauvegardePartie(mode,grille)
        #
    end

    # Methode qui supprime la sauvegarde d'une partie donnee
    def deleteSauvegardePartie(mode,grille)
        # return un booleen
    end

    # Methode qui retourne la sauvegarde des parametres
    def getSauvegardeParametre()
        #
    end

    # Methode qui retourne la sauvegarde du score pour un mode et une grille donnes
    def getSauvegardeScore(mode,grille)
        #
    end

    # Methode qui retourne la sauvegarde des recompenses
    def getSauvegardeRecompense()
        #
    end
end