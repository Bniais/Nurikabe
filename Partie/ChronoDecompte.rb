class ChronoDecompte < Chrono
    CHRONO_BASE_DECOMPTE = 5*60 #5mins

    ##
    # Crée un chronometre avec un decompte de 5 minutes
    def ChronoDecompte.creer()
      new()
    end

    ##
    # Constructeur de ChronoDecompte
    def initialize()
      super()
      @time = CHRONO_BASE_DECOMPTE
    end

    ##
    # A COMPLETER
    def top()
      if(!@pause)
        ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        @time -= (ending - @starting)
        @starting = ending
        if(@time < 0)
          @time = 0
        end
      end
      return estNul?()
    end
    ##
    #Ajoute un malus au chrono
    def ajouterMalus(n)
      @time -= n
      if(@time < 0)
        @time = 0
      end
    end
    ##
    #Retourne le temps sous forme de String
    def getTemps()
      top()
      return format("%02d", (@time.ceil/60).to_s) + ":" + format("%02d", (@time.ceil%60).to_s)
    end
end
