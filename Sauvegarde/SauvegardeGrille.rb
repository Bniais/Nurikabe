require_relative '../Partie/Grille.rb'

class SauvegardeGrille 

    @@instanceSauvegardeGrille = nil

    @mesGrilles = nil

    ##
    # Constructeur de SauvegardeGrille
    def initialize(chemin)
        if File.exist?(chemin) == true 
            @@instanceSauvegardeGrille = Marshal.load( File.binread( chemin ) )
        else
            @mesGrilles = [nil]
            @@instanceSauvegardeGrille = self
        end
        @@instanceSauvegardeGrille
    end

    ##
    # Recupère le chemin d'un fichier de sauvegarde de grille
    def self.creer(chemin)
        if @@instanceSauvegardeGrille == nil
            new(chemin)
        end
    end

    ##
    # Renvoie la variable de classe instance de sauvegarde
    def self.getInstance()
        return @@instanceSauvegardeGrille
    end

    ##
    # Sauvegarde les grilles dans un chemin spécifique, ou dans un dossier préfait
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
    # Ajout une grille en fonction de son numéro dans le tableau
    def ajouterGrille(uneGrille)
        @mesGrilles[ uneGrille.numero ] = uneGrille
    end

end


#########################################################################