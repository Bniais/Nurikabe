# Classe qui contient l'ensemble des sauvegardes
require '../Partie/Partie.rb'
require '../Partie/PartieSurvie.rb'
require '../Partie/PartieContreLaMontre.rb'
require '../Partie/PartieTuto.rb'
require '../Parametres/Parametre.rb'
require_relative 'SauvegardePartie.rb'
require_relative 'SauvegardeScore.rb'

#require './SauvegardePartie.rb'

class Sauvegardes

    @@instanceSauvegarde = nil
    
    @sauvegardePartie = nil
    @sauvegardeParametre = nil
    @sauvegardeScore = nil
    @sauvegardeLangue = nil

    ##
    # Constructeur de Sauvegardes
    def initialize(chemin)
        if File.exist?(chemin) == true 
            @@instanceSauvegarde = Marshal.load( File.binread( chemin ) )
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
    def self.creer(chemin)
        if @@instanceSauvegarde == nil
            new(chemin)
        else 
            puts "Save already exist"
        end
    end

    ##
    # Retourne la variable de classe d'instance de sauvegardes
    def self.getInstance()
        return @@instanceSauvegarde
    end

    ##
    # Sauvegarde les sauvegardes dans un chemin spécifique, ou dans un dossier préfait
    def sauvegarder(chemin)
        if chemin == nil
            chemin = "../Sauvegarde/save.dump"
        end
        puts "JE SAUVEGARDE"
        File.open(chemin, "wb") { |f| f.write(Marshal.dump(@@instanceSauvegarde) ) }
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

