require_relative '../Partie/Grille.rb'

class SauvegardeGrille 

    @@instanceSauvegardeGrille = nil

    @mesGrilles = nil

    def initialize(chemin)
        if File.exist?(chemin) == true 
            @@instanceSauvegardeGrille = Marshal.load( File.binread( chemin ) )
        else
            @mesGrilles = [nil]
            @@instanceSauvegardeGrille = self
        end
        @@instanceSauvegardeGrille
    end

    def self.creer(chemin)
        if @@instanceSauvegardeGrille == nil
            new(chemin)
        else 
            puts "SauvegardeGrille already exist"
        end
    end

    def self.getInstance()
        return @@instanceSauvegardeGrille
    end

    def sauvegarder(chemin)
        if chemin == nil
            chemin = "../Sauvegarde/grilles.dump"
        end
        puts "JE SAUVEGARDE LES GRILLES"
        File.open(chemin, "wb") { |f| f.write(Marshal.dump(@@instanceSauvegardeGrille) ) }
    end

    def getNombreGrille
        @mesGrilles.size - 1
    end

    def getGrilleAt(indice)
        @mesGrilles[indice]
    end

    def ajouterGrille(uneGrille)
        @mesGrilles[ uneGrille.numero ] = uneGrille
    end

end


#########################################################################