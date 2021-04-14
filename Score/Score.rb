class Score

    attr_accessor :score, :malus, :nbAideUtilisee

    ## 
    # Methode qui permet de cree un score
    def creer(score, malus)
      @score = score
      @malus = malus
    end

    ##
    # score donne la valeur
    def getValeur()
      return @score
    end

    ##
    # donne le nombre de malus 
    def getMalus()
      return @malus
    end

end
