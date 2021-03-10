class Chrono

    attr_accessor :temps, :Malus

    private_class_method :new

    def Chrono.creer(t)
      new(t)
    end

    def initialize(t)
        @malus = 0
        @time = t
        @starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end

    #
    def top(mode)
      ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      @time += (ending - @starting) * (mode == SURVIE ? -1 : 1)
      @starting = ending
    end

    #savoir sir le chrono est nul
    def estNul?()
      return @time <= 0
    end


    #lance le chrono
    def demarrer()
      #return void
    end

    #met en pause le chrono
    def mettreEnPause()
      #return void
    end

    #Ajoute un malus au chrono
    def addMalus(m)
      @malus += m
    end

end
