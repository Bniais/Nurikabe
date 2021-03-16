class Chrono

    attr_accessor :temps, :Malus

    private_class_method :new

    def Chrono.creer()
      new()
    end

    def initialize()
      @malus = 0
      @pause = false
      @time = 0
      @starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end

    def top()
      if(!@pause)
        ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        @time += (ending - @starting) * (@mode == Mode::SURVIE ? -1 : 1)
        @starting = ending
      end

      return estNul?()
    end

    #savoir sir le chrono est nul
    def estNul?()
      return @time <= 0
    end


    #lance le chrono
    def demarrer()
       @pause = false
      top()
    end

    #met en pause le chrono
    def mettreEnPause()
      top()
      @pause = true
    end

    #Ajoute un malus au chrono
    def addMalus(m)
      @malus += m
    end

end

Chrono.creer