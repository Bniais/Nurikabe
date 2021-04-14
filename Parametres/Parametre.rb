require './../Sauvegarde/Sauvegardes.rb'

# Classe qui gere les parametres
class Parametre
    ##
    # option d'affichage
    attr_accessor :casesGrises
    ##
    # AIDES VISUELLES
    # affichage de la taille d'une ile
    attr_accessor :compteurIlot
    ##
    # affichage de la portee d'une aide
    attr_accessor :affichagePortee
    ##
    # affichage des murs 2x2
    attr_accessor :murs2x2
    ##
    # comportement de la souris choisi
    attr_accessor :comportementSouris
    ##
    # raccourcis clavier choisi
    attr_accessor :raccourcisClavier
    ##
    # tableau des langues dispos
    attr_accessor :langue
    ##
    # indice de la langue choisie
    attr_accessor :indiceLangueChoisi
    ##
    # volume
    attr_accessor :volume

    @@instanceParametre = nil

    ##
    # Constructeur de Parametre, initialisation des différents paramètres
    def initialize()
        @casesGrises = false
        @compteurIlot = true
        @affichagePortee = true
        @murs2x2 = false
        @modeSombre = false
    end

    ##
    # A COMPLETER
    def self.initialiseToi()
        if @@instanceParametre == nil
            @@instanceParametre = new()
        end
    end

    ##
    # A COMPLETER
    def self.getInstance()
        return @@instanceParametre
    end

    ##
    # Remettre à zéro les paramètres
    def resetAll()
        set_casesGrises(false)
        set_compteurIlots(true)
        set_affichagePortee(true)
        set_mur2x2(false)
        set_modeSombre(false)
    end

    ##
    # Methode qui permet de savoir si l'option des cases grises est activee ou pas
    def casesGrises?()
        return @casesGrises
    end
    ##
    # Methode qui permet de set le parametre case grise
    def set_casesGrises(statut)
        @casesGrises = statut
        Fenetre.set_modeGris(@casesGrises)
        Sauvegardes.getInstance.sauvegarder()
    end
    ##
    # Methode qui permet de savoir si l'aide visuelle 'compteur ilots' est activee
    def compteurIlots?()
        return @compteurIlot
    end
    ##
    # Methode qui permet de set le parametre compteur ilots
    def set_compteurIlots(statut)
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
    def set_affichagePortee(statut)
        @affichagePortee = statut
        Sauvegardes.getInstance.sauvegarder()
    end
    ##
    # Methode qui permet de savoir si l'aide visuelle 'afficher les murs 2x2' est activee
    def mur2x2?()
        return @murs2x2
    end
    ##
    # Methode qui permet de set le parametre murs 2x2
    def set_mur2x2(statut)
        @murs2x2 = statut
        Sauvegardes.getInstance.sauvegarder()
    end
    ##
    # Methode qui permet de savoir si
    def modeSombre?()
        return @modeSombre
    end
    ##
    # Methode qui permet de set le mode sombre
    def set_modeSombre(statut)
        @modeSombre = statut
        Fenetre.set_modeSombre(@modeSombre)
        Sauvegardes.getInstance.sauvegarder()
    end
    ##
    # Methode qui permet de connaitre le comportement de la souris
    def comportementSouris?()
        # return un booleen
    end
    ##
    # Methode qui permet de connaitre les raccourcis clavier choisis
    def raccourcisClavier?()
        # return un booleen
    end
end