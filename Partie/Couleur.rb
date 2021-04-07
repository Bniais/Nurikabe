class Couleur
    NOIR = -2
    GRIS = -3
    BLANC = -1
    ILE_1 = 1
    ILE_2 = 2
    ILE_3 = 3
    ILE_4 = 4
    ILE_5 = 5
    ILE_6 = 6
    ILE_7 = 7
    ILE_8 = 8
    ILE_9 = 9
    ILE_10 = 10
    ILE_11 = 11
    ILE_12 = 12
    ILE_13 = 13
    ILE_14 = 14
    ILE_15 = 15
    ##
    #Permet de savoir si une case est une ile
    #Renvoi un booléen 
    def self.EstIle?(couleur)
        return couleur >= ILE_1
    end
end