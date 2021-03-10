# Classe qui gere les grilles
class Grille
    # numero de la grille
    attr_reader :numero
    # tableau des cases de la grille
    attr_reader :tabCases
    # niveau de difficulte
    attr_reader :difficulte

    attr_reader :grille


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
        # return Case
        return tabCases[x][y]
    end

    # Methode qui permet d'initialiser une grille
    def initialiser()
        #
        int i,j;

        for i in 0..tabCases.size
            for j in 0..tabCases.size
                if tabCases[i][j].getCouleur < 0         # -1 = couleur blanche
                    mettreAJour( tabCases[i][j],-1)      # -2 = couleur grise 
                end                                      # -3 = couleur noir
            end
        end                                                                        
    end

    # Methode qui remet a zero la grille
    def raz()
        #
        int i,j;

        for i in 0..tabCases.size
            for j in 0..tabCases.size
                if tabCases[i][j].getCouleur == -2 || tabCases[i][j].getCouleur == -3   # -1 = couleur blanche
                    mettreAJour( tabCases[i][j],-1)                                     # -2 = couleur grise 
                end                                                                     # -3 = couleur noir
            end
        end                                                                        
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
    def mettreAJour(uneCase,uneCouleur)
        #
        setCouleur(uneCase,uneCouleur)

    end

    # Methode qui ajoute une nouvelle grille
    def ajouterGrille(unChemin)
        #return boolean

        
        

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

    def nbDifference(grille)
        #return int
    end

    def firstDifference(grille)
        #return case
    end
end