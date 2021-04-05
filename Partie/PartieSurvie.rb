require_relative "PartieMalus.rb"
class PartieSurvie < PartieMalus
    ##
    #ceer une partie en mode survie
    def PartieSurvie.creer(grille, parametres, sauvegardes)
      new(grille, parametres, sauvegardes)
    end

    ##
    #Constructeur de PartieSurvie
    def initialize(grille, parametres, sauvegardes) #Créer une nouvelle partie
      super(grille, parametres, sauvegardes)
      @chrono = ChronoDecompte.creer()
      @chrono.demarrer()
      
      @nbGrilleFinis = 0
      @grilles = Array.new()
      nbGrille = SauvegardeGrille.getInstance.getNombreGrille

      if(grille.numero <= nbGrille / 3) #facile
        for i in 1..(nbGrille / 3)
          if( i != grille.numero)
            @@grilles.append(i)
          end
        end
      elsif(grille.numero <= 2 * nbGrille / 3) #facile
        for i in (1 + nbGrille / 3)..(2 * nbGrille / 3)
          if( i != grille.numero)
            @grilles.append(i)
          end
        end
      else
        for i in (1 + 2 * nbGrille / 3)..nbGrille
          if( i != grille.numero)
            @grilles.append(i)
          end
        end
      end

      @grilles = @grilles.shuffle
    end

    ##
    #Tire lla prochaine grille
    def grilleSuivante()
      @nbGrilleFinis += 1
      indice = @grilles.delete_at(0)
      if(indice == nil)
        return nil
      end

      nextGrille = SauvegardeGrille.getInstance.getGrilleAt(indice)

      @grilleBase = nextGrille
   
      @tabCoup = Array.new(0);

      @nbAideUtilise = 0
      @indiceCoup = 0

      @grilleEnCours = Marshal.load( Marshal.dump(@grilleBase) )
      @grilleEnCours.raz()
      
      return nextGrille
    end

    ##
    #Retourne le nombre de grille réalisées
    def getNbGrilleFinis
      return @nbGrilleFinis
    end


    ##
    #Retourne le mode Survie
    def getMode
      return Mode::SURVIE
    end
end
