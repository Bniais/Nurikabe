class ChronoDecompte < Chrono
    CHRONO_BASE_DECOMPTE = 5*60 #5mins

    def ChronoDecompte.creer()
      new()
    end

    def initialize()
      super()
      @time = CHRONO_BASE_DECOMPTE
    end

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

    def ajouterMalus(n)
      @time -= n
      if(@time < 0)
        @time = 0
      end
    end
end
