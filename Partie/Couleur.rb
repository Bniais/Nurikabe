##
# Classe qui représente le type d'une case
class Couleur
    ##
    # Constante pour les cases noires
    NOIR = -2

    ##
    # Constante pour les cases grises/neutres
    GRIS = -3

    ##
    # Constante pour les cases blanches
    BLANC = -1

    ##
    # Constante pour les iles d'indice 1
    ILE_1 = 1

    ##
    # Constante pour les iles d'indice 2
    ILE_2 = 2

    ##
    # Constante pour les iles d'indice 3
    ILE_3 = 3

    ##
    # Constante pour les iles d'indice 4
    ILE_4 = 4

    ##
    # Constante pour les iles d'indice 5
    ILE_5 = 5

    ##
    # Constante pour les iles d'indice 6
    ILE_6 = 6

    ##
    # Constante pour les iles d'indice 7
    ILE_7 = 7

    ##
    # Constante pour les iles d'indice 8
    ILE_8 = 8

    ##
    # Constante pour les iles d'indice 9
    ILE_9 = 9

    ##
    # Constante pour les iles d'indice 10
    ILE_10 = 10

    ##
    # Constante pour les iles d'indice 11
    ILE_11 = 11

    ##
    # Constante pour les iles d'indice 12
    ILE_12 = 12

    ##
    # Constante pour les iles d'indice 13
    ILE_13 = 13

    ##
    # Constante pour les iles d'indice 14
    ILE_14 = 14

    ##
    # Constante pour les iles d'indice 15
    ILE_15 = 15

    ##
    #Permet de savoir si une case est une ile, renvoi un booléen
    def self.EstIle?(couleur)
        return couleur >= ILE_1
    end
end