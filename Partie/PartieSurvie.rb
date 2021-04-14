require_relative "PartieMalus.rb"
class PartieSurvie < PartieMalus

    private_class_method :new

    ##
    # Creer une partie en mode survie, puisque new est private
    def PartieSurvie.creer(grille)
      new(grille)
    end

    ##
    # Initialise une partie survie, en mettant en place une liste aléatoires de grilles de la difficulté voulue
    def initialize(grille) #Créer une nouvelle partie
      super(grille)
      @chrono = ChronoDecompte.creer()
      @chrono.demarrer()
      
      @nbGrilleFinis = 0
      @grilles = Array.new()
      nbGrille = SauvegardeGrille.getInstance.getNombreGrille

      if(grille.numero <= nbGrille / 3) #facile
        for i in 1..(nbGrille / 3)
          if( i != grille.numero)
            @grilles.append(i)
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
    # Passe à la prochaine grille tout en la renvoyant
    def grilleSuivante()
      @grilleRaz = nil
      @nbGrilleFinis += 1
      indice = @grilles.delete_at(0)
      if(indice == nil)
        return nil
      end

      nextGrille = SauvegardeGrille.getInstance.getGrilleAt(indice)

      if(nextGrille != nil)
        @grilleBase = nextGrille
    
        @tabCoup = Array.new(0);

        @nbAideUtilise = 0
        @indiceCoup = 0

        @grilleEnCours = Marshal.load( Marshal.dump(@grilleBase) )
        @grilleEnCours.raz()
      end
      
      return nextGrille
    end

    ##
    # Retourne le nombre de grille terminée
    def getNbGrilleFinis
      return @nbGrilleFinis
    end

    ##
    #Retourne le mode de la partie : Survie
    def getMode
      return Mode::SURVIE
    end
end
