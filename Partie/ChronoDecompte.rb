##
# Classe qui représente le décompte du chrono
class ChronoDecompte < Chrono
    ##
    # Constante qui représente le temps de départ du décompte
    CHRONO_BASE_DECOMPTE = 5*60 #5mins

    ##
    # Constructeur de ChronoDecompte
    def ChronoDecompte.creer()
      new()
    end

    ##
    # Initialise le chrono en mettant le temps à un temps fixe
    def initialize()
      super()
      @time = CHRONO_BASE_DECOMPTE
    end

    ##
    # Décremente le chronomètre selon la différence de temps entre ce moment et le dernier appel de top
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
    #Retourne le temps sous forme de String (arrondi différemment)
    def getTemps()
      top()
      return format("%02d", (@time.ceil/60).to_s) + ":" + format("%02d", (@time.ceil%60).to_s)
    end
end
