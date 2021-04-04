class Chrono

    private_class_method :new

    attr_reader :pause, :time

    def Chrono.creer()
      new()
    end

    def initialize()
      @pause = false
      @time = 0
      @starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end

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
    

    #savoir sir le chrono est nul
    def estNul?()
      return @time <= 0
    end


    #lance le chrono
    def demarrer()
      @pause = false
      @starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      top()
    end

    #met en pause le chrono
    def mettreEnPause()
      top()
      @pause = true
    end

    #Ajoute un malus au chrono
    def ajouterMalus(m)
      @time += m
    end

    def getTemps()
      top()
      return format("%02d", (@time.floor/60).to_s) + ":" + format("%02d", (@time.floor%60).to_s)
    end

end