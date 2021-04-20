require_relative './../Sauvegarde/Sauvegardes.rb'

##
# Classe qui gère les parametres
class Parametre
    ##
    # Unique instance de paramètres
    @@instanceParametre = nil

    ##
    # Intitialisation des différents paramètres
    def initialize()
        @casesGrises = false
        @compteurIlot = true
        @affichagePortee = true
        @modeSombre = false
    end

    ##
    # Constructeur des paramètres
    def self.initialiseToi()
        if @@instanceParametre == nil
            @@instanceParametre = new()
        end
        @@instanceParametre
    end

    ##
    # Obtenir l'unique instance des paramètres
    def self.getInstance()
        return @@instanceParametre
    end

    ##
    # Remettre à zéro les paramètres
    def resetAll()
        setCasesGrises(false)
        setCompteurIlots(true)
        setAffichagePortee(true)
        setModeSombre(false)
    end

    ##
    # Permet de savoir si l'option des cases grises est activee ou pas
    def casesGrises?()
        return @casesGrises
    end

    ##
    # Accesseur en écriture des paramètres de cases grises
    def setCasesGrises(statut)
        @casesGrises = statut
        Fenetre.setModeGris(@casesGrises)
        Sauvegardes.getInstance.sauvegarder()
    end

    ##
    # Permet de savoir si l'aide visuelle 'compteur ilots' est activ"e"e
    def compteurIlots?()
        return @compteurIlot
    end

    ##
    # Accesseur en écriture des paramètres de compteur ilots
    def setCompteurIlots(statut)
        @compteurIlot = statut
        Sauvegardes.getInstance.sauvegarder()
    end

    ##
    # Permet de savoir si l'aide visuelle 'afficher portee' est activee
    def affichagePortee?()
        return @affichagePortee
    end

    ##
    # Accesseur en écriture des paramètres de l'affichage de la portée
    def setAffichagePortee(statut)
        @affichagePortee = statut
        Sauvegardes.getInstance.sauvegarder()
    end


    ##
    # Permet de savoir si le mode sombre est activé
    def modeSombre?()
        return @modeSombre
    end

    ##
    # Accesseur en écriture des paramètres du mode sombre
    def setModeSombre(statut)
        @modeSombre = statut
        Fenetre.setModeSombre(@modeSombre)
        Sauvegardes.getInstance.sauvegarder()
    end
end