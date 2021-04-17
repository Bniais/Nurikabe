##
# Classe du chrono
class Chrono

    private_class_method :new

    ##
    # Variables d'instance de Case :
    # @pause => Booléen qui indique si la partie est en pause
    # @time => Temps du chronomètre
    # @starting => debut du chrono
    attr_reader :pause, :time

    ##
    #Crée un chrono initialisé au temps 0
    def Chrono.creer()
      new()
    end

    ##
    # Constructeur du chrono
    def initialize()
      @pause = false
      @time = 0
      @starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end

    ##
    # Methode qui incremente le chronometre
    # Elle fait la difference entre le temps
    # de depart et le temps actuel
    def top()
      if(!@pause)
        ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        @time += (ending - @starting) * (@mode == Mode::SURVIE ? -1 : 1)
        @starting = ending

        if(@time < 0)
          @time = 0
        end
      end

      return estNul?()
    end

    ##
    # Savoir si le chrono est nul
    def estNul?()
      return @time <= 0
    end

    ##
    # Lance le chrono
    def demarrer()
      @pause = false
      @starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      top()
    end

    ##
    # Met en pause le chrono
    def mettreEnPause()
      top()
      @pause = true
    end

    ##
    # Ajoute un malus au chrono
    def ajouterMalus(m)
      @time += m
    end

    ##
    # Retourne le temps sous forme de String
    def getTemps()
      top()
      return format("%02d", (@time.floor/60).to_s) + ":" + format("%02d", (@time.floor%60).to_s)
    end

    ##
    # Retourne un temps passé en paramètre sous forme de String
    def self.getTpsFormat(floatTps)
      return format("%02d", (floatTps.floor/60).to_s) + ":" + format("%02d", (floatTps.floor%60).to_s)
    end

    ##
    # Retourne un temps passé en paramètre sous forme de String
    def self.getTpsFormatPrecis(floatTps)
      if(floatTps == -1)
        return Sauvegardes.getInstance.getSauvegardeLangue.gt("AUCUN_TEMPS")
      else
        return format("%02d", (floatTps.floor/60).to_s) +
        ":" + format("%02d", (floatTps.floor%60).to_s) +
        "." + format("%03d", ((floatTps-floatTps.floor)*1000).round.to_s)
      end
    end

end