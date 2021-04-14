
require_relative '../Partie/Partie.rb'
require_relative '../Partie/PartieSurvie.rb'
require_relative '../Partie/PartieContreLaMontre.rb'
require_relative '../Partie/PartieTuto.rb'
require_relative '../Parametres/Parametre.rb'
require_relative 'SauvegardePartie.rb'
require_relative 'SauvegardeScore.rb'

#require './SauvegardePartie.rb'

##
# Classe qui contient l'ensemble des sauvegardes
class Sauvegardes

    @@instanceSauvegarde = nil
    
    @sauvegardePartie = nil
    @sauvegardeParametre = nil
    @sauvegardeScore = nil
    @sauvegardeLangue = nil

    ##
    # Constructeur de Sauvegardes
    def initialize()
        if File.exist?("../Sauvegarde/save.dump") == true 
            @@instanceSauvegarde = Marshal.load( File.binread( "../Sauvegarde/save.dump" ) )
        else
            @@instanceSauvegarde = self
        end

        @@instanceSauvegarde.getSauvegardeParametre
        @@instanceSauvegarde.getSauvegardePartie
        @@instanceSauvegarde.getSauvegardeScore
        @@instanceSauvegarde.getSauvegardeLangue
        
        
        @@instanceSauvegarde
    end

     ##
    # Recupère le chemin d'un fichier de sauvegardes 
    def self.creer()
        if @@instanceSauvegarde == nil
            new()
        end
    end

    ##
    # Retourne la variable de classe d'instance de sauvegardes
    def self.getInstance()
        return @@instanceSauvegarde
    end

    ##
    # Sauvegarde les sauvegardes dans un chemin spécifique, ou dans un dossier préfait
    def sauvegarder()
        File.open("../Sauvegarde/save.dump", "wb") { |f| f.write(Marshal.dump(@@instanceSauvegarde) ) }
    end

    ##
    # Renvoie une sauvegarde de Partie
    def getSauvegardePartie()
        if @sauvegardePartie == nil
            @sauvegardePartie = SauvegardesParties.new()
            return @sauvegardePartie
        else 
            return @sauvegardePartie
        end
    end

    ##
    # Renvoie une sauvegarde de Parametre
    def getSauvegardeParametre()
        if @sauvegardeParametre == nil
            @sauvegardeParametre = Parametre.initialiseToi()
        else 
            @sauvegardeParametre
        end
    end

    ##
    # Renvoie une sauvegarde de Score
    def getSauvegardeScore()
        if @sauvegardeScore == nil
            @sauvegardeScore = SauvegardesScore.new()
        else 
            @sauvegardeScore      
        end
    end

    ##
    # Renvoie une sauvegarde de Score
    def getSauvegardeLangue
        if @sauvegardeLangue == nil
            @sauvegardeLangue = Langue.creer()
        else
            @sauvegardeLangue
        end
    end

end

