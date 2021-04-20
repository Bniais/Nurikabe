require_relative '../Partie/Grille.rb'
##
# Classe qui représente une sauvegarde de grille
class SauvegardeGrille 

    ##
    # @@instanceSauvegardeGrille => Unique instance de SauvegardeGrille
    @@instanceSauvegardeGrille = nil

    ##
    # @mesGrilles => Tableau qui contient des grilles
    @mesGrilles = nil

    ##
    # Initialise la sauvegardeGrille en essayant de charger la sauvegarde dans le fichier grilles.dump
    def initialize()
        if File.exist?("../Sauvegarde/grilles.dump") == true 
            @@instanceSauvegardeGrille = Marshal.load( File.binread( "../Sauvegarde/grilles.dump" ) )
        else
            @mesGrilles = [nil]
            @@instanceSauvegardeGrille = self
        end
        @@instanceSauvegardeGrille
    end

    ##
    # Constructeur de SauvegardeGrille, en singleton
    def self.creer()
        if @@instanceSauvegardeGrille == nil
            new()
        end
    end

    ##
    # Renvoie l'unique instance de SauvegardeGrille
    def self.getInstance()
        return @@instanceSauvegardeGrille
    end

    ##
    # Sauvegarde les grilles
    def sauvegarder()
        File.open("../Sauvegarde/grilles.dump", "wb") { |f| f.write(Marshal.dump(@@instanceSauvegardeGrille) ) }
    end

    ##
    # Retourne le nombre de grilles
    def getNombreGrille
        @mesGrilles.size - 1
    end

    ##
    # Retourne la grille à un indice passé en paramètre
    def getGrilleAt(indice)
        @mesGrilles[indice]
    end

    ##
    # Ajoute une grille en fonction de son numéro dans le tableau
    def ajouterGrille(uneGrille)
        @mesGrilles[ uneGrille.numero ] = uneGrille
    end

end