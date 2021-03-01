# Classe qui gere les grilles
class Grille
    attr_reader :numero
    attr_reader :tabCases
    attr_reader :difficulte
    # attr_reader :grille


    private_class_method :new

    # Methode qui permet de creer une grille
    def Grille.creer(numero, tabCases)
        new(numero, tabCases)
    end

    # Methode privee pour l'initialisation
    def initialize(numero, tabCases)
        @numero, @tabCases = numero, tabCases
    end

    # Methode qui renvoie une case donnee en focntion de ses coordonnees
    def getCase(x,y)
        #
    end

    # Methode qui permet d'initialiser une grille
    def initialiser()
        #
    end

    # Methode qui remet a zero la grille
    def raz()
        #
    end

    # Methode qui permet de savoir si la grille est terminee ou non
    def grilleTerminee?()
        # return un booleen
    end

    # Methode qui permet d'afficher la grille
    def afficher()
        #
    end

    # Methode qui permet de mettre a jour l'etat d'une case donnee
    def mettreAJour(case,couleur)
        #
    end

    # Methode qui ajoute une nouvelle grille
    def ajouterGrille(chemin)
        #
    end

    # Methode qui envoie la grille suivante
    def grilleSuivante()
        #
    end

    # Methode....................
    def Grille.charger()
        #
    end

    # Methode...................
    def Grille.ajouterGrille(chemin)
        #
    end
end