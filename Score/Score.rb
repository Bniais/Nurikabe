class Score

    attr_accessor :score, :malus, :nbAideUtilisee

    def creer(score, malus)
      @score = score
      @malus = malus
    end

    #donne la valeur
    def getValeur()
      return @score
    end


    #donne le nbombre d'aide utilisee
    def getAideUtilisee()
      #return int
    end


    #donne le nombre de malus 
    def getMalus()
      return @malus
    end

end
