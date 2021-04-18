require_relative './../Sauvegarde/Sauvegardes.rb'

##
# Classe qui gere les parametres
class Parametre
    ##
    # @casesGrises => option d'affichage
    attr_accessor :casesGrises

    ##
    # AIDES VISUELLES
    # @compteurIlot => affichage de la taille d'une ile
    attr_accessor :compteurIlot

    ##
    # @affichagePortee => affichage de la portee d'une aide
    attr_accessor :affichagePortee


    ##
    # @volume => volume
    attr_accessor :volume

    ##
    # @modeSombre => mode sombre
    attr_accessor :modeSombre

    ##
    # instance des parametres
    @@instanceParametre = nil

    ##
    # Constructeur de Parametre, initialisation des différents paramètres
    def initialize()
        @casesGrises = false
        @compteurIlot = true
        @affichagePortee = true
        @modeSombre = false
    end

    ##
    # Methode de class qui permet
    # d'initialiser la class Parametre
    def self.initialiseToi()
        if @@instanceParametre == nil
            @@instanceParametre = new()
        end
    end

    ##
    # A Methode de class
    # type singleton qui permet de recuperer
    # l'instance des parametre
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
    # Methode qui permet de savoir si l'option des cases grises est activee ou pas
    def casesGrises?()
        return @casesGrises
    end

    ##
    # Methode qui permet de set le parametre case grise
    def setCasesGrises(statut)
        @casesGrises = statut
        Fenetre.setModeGris(@casesGrises)
        Sauvegardes.getInstance.sauvegarder()
    end

    ##
    # Methode qui permet de savoir si l'aide visuelle 'compteur ilots' est activee
    def compteurIlots?()
        return @compteurIlot
    end

    ##
    # Methode qui permet de set le parametre compteur ilots
    def setCompteurIlots(statut)
        @compteurIlot = statut
        Sauvegardes.getInstance.sauvegarder()
    end

    ##
    # Methode qui permet de savoir si l'aide visuelle 'afficher portee' est activee
    def affichagePortee?()
        return @affichagePortee
    end

    ##
    # Methode qui permet de set le parametre affichage portee
    def setAffichagePortee(statut)
        @affichagePortee = statut
        Sauvegardes.getInstance.sauvegarder()
    end


    ##
    # Methode qui permet de savoir si
    def modeSombre?()
        return @modeSombre
    end

    ##
    # Methode qui permet de set le mode sombre
    def setModeSombre(statut)
        @modeSombre = statut
        Fenetre.setModeSombre(@modeSombre)
        Sauvegardes.getInstance.sauvegarder()
    end

    ##
    # Methode qui permet de connaitre le comportement de la souris
    def comportementSouris?()
        # return un booleen
    end

end