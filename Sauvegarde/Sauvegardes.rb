# Classe qui contient l'ensemble des sauvegardes
require '../Partie/Partie.rb'
require '../Parametres/Parametre.rb'

#require './SauvegardePartie.rb'

class Sauvegardes

    @@instanceSauvegarde = nil
    

    @sauvegardePartie = nil
    @sauvegardeParametre = nil

    def initialize(chemin)
        if File.exist?(chemin) == true 
            @@instanceSauvegarde = Marshal.load( File.binread( chemin ) )
        else
            @@instanceSauvegarde = self
        end

        @@instanceSauvegarde.getSauvegardeParametre
        @@instanceSauvegarde.getSauvegardePartie
        @@instanceSauvegarde
    end

    def self.creer(chemin)
        if @@instanceSauvegarde == nil
            new(chemin)
        else 
            puts "Save already exist"
        end
    end

    def self.getInstance()
        return @@instanceSauvegarde
    end


    def sauvegarder(chemin)
        if chemin == nil
            chemin = "../Sauvegarde/save.dump"
        end
        puts "JE SAUVEGARDE"
        File.open(chemin, "wb") { |f| f.write(Marshal.dump(@@instanceSauvegarde) ) }
    end

    def getSauvegardePartie()
        if @sauvegardePartie == nil
            @sauvegardePartie = SauvegardesParties.new()
            return @sauvegardePartie
        else 
            return @sauvegardePartie
        end
    end


    def getSauvegardeParametre()
        if @sauvegardeParametre == nil
            @sauvegardeParametre = Parametre.initialiseToi()
        else 
            @sauvegardeParametre
        end
    end

end



class SauvegardesParties < Sauvegardes 

    @mesParties = nil

    def initialize()
        @mesParties = Array.new
    end

    def getPartie( indice )
        puts "indice = " + indice.to_s
        return @mesParties[indice]
    end

    def ajouterSauvegardePartie( unePartie )
        @mesParties.push(unePartie)
    end

    def supprimerSauvegardePartie( unePartie )
        @mesParties.delete(unePartie)
    end

    def nbPartieSauvegarder()
        return @mesParties.size
    end

    def nbPartieSauvegarderLibre()
        compteur = 0;
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::LIBRE
                compteur += 1;
            end
        end
        compteur
    end

    def getIndicePartieSauvegarderLibre()
        indice = Array.new
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::LIBRE
                indice.push(i)
            end
        end
        return indice;
    end

    def nbPartieSauvegarderSurvie()
        compteur = 0;
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::SURVIE
                compteur += 1;
            end
        end
        compteur
    end

    def getIndicePartieSauvegarderSurvie()
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::SURVIE
                return i;
            end
        end
        return -1;
    end

    def nbPartieSauvegarderContreLaMontre()
        compteur = 0;
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::CONTRE_LA_MONTRE
                compteur += 1;
            end
        end
        compteur
    end

    def getIndicePartieSauvegarderContreLaMontre()
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::CONTRE_LA_MONTRE
                return i;
            end
        end
        return -1;
    end

    def nbPartieSauvegarderTutoriel()
        compteur = 0;
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::TUTORIEL
                compteur += 1;
            end
        end
        compteur
    end 

    def getIndicePartieSauvegarderTutoriel()
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::TUTORIEL
                return i;
            end
        end
        return -1;
    end

end



