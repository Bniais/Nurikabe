
require_relative '../Partie/Partie.rb'
require_relative '../Partie/PartieSurvie.rb'
require_relative '../Partie/PartieContreLaMontre.rb'
require_relative '../Partie/PartieTuto.rb'
require_relative '../Parametres/Parametre.rb'
require_relative 'SauvegardePartie.rb'
require_relative 'SauvegardeScore.rb'

##
# Classe qui contient l'ensemble des sauvegardes
class Sauvegardes

    ##
    # Instance de Sauvegarde
    @@instanceSauvegarde = nil

    ##
    # Sauvegarde des parties
    @sauvegardePartie = nil

    ##
    # Sauvegarde des parametres
    @sauvegardeParametre = nil

    ##
    # Sauvegarde des scores
    @sauvegardeScore = nil

    ##
    # Sauvegarde de la langue choisie
    @sauvegardeLangue = nil

    ##
    # Initialise la sauvegarde, en récuperant les différentes sauvegardes ou en les créant si elles n'existent pas
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
    # Constructeur de Sauvegardes
    def self.creer()
        if @@instanceSauvegarde == nil
            new()
        end
    end

    ##
    # Retourne l'unique instance de sauvegarde
    def self.getInstance()
        return @@instanceSauvegarde
    end

    ##
    # Sauvegarde les différentes données de l'utilisateur
    def sauvegarder()
        File.open("../Sauvegarde/save.dump", "wb") { |f| 
            f.write(Marshal.dump(@@instanceSauvegarde) ) 
        }
    end

    ##
    # Renvoie l'unique instance de sauvegardes de partie, ou la crée si elle n'existe pas
    def getSauvegardePartie()
        if @sauvegardePartie == nil
            @sauvegardePartie = SauvegardesParties.new()
            return @sauvegardePartie
        else
            return @sauvegardePartie
        end
    end

    ##
    # Renvoie l'unique instance de sauvegardes de paramètre, ou la crée si elle n'existe pas
    def getSauvegardeParametre()
        if @sauvegardeParametre == nil
            @sauvegardeParametre = Parametre.initialiseToi()
        else
            @sauvegardeParametre
        end
    end

    ##
    # Renvoie l'unique instance de sauvegardes de score, ou la crée si elle n'existe pas
    def getSauvegardeScore()
        if @sauvegardeScore == nil
            @sauvegardeScore = SauvegardesScore.new()
        else
            @sauvegardeScore
        end
    end

    ##
    # Renvoie l'unique instance de sauvegardes de la langue actuelle, ou la crée si elle n'existe pas
    def getSauvegardeLangue
        if @sauvegardeLangue == nil
            @sauvegardeLangue = Langue.creer()
        else
            @sauvegardeLangue
        end
    end

end
