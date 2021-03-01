# Classe qui gere les parametres
class Parametre
    # option d'affichage
    attr_accessor :casesGrises

    # AIDES VISUELLES
    # affichage de la taille d'une ile
    attr_accessor :compteurIlot
    # affichage de la portee d'une aide
    attr_accessor :affichagePortee
    # affichage des murs 2x2
    attr_accessor :murs2x2

    # comportement de la souris choisi
    attr_accessor :comportementSouris
    # raccourcis clavier choisi
    attr_accessor :raccourcisClavier
    # tableau des langues dispos
    attr_accessor :langue
    # indice de la langue choisie
    attr_accessor :indiceLangueChoisi
    # volume
    attr_accessor :volume


    # Methode qui permet de savoir si l'option des cases grises est activee ou pas
    def casesGrises?()
        # return un booleen
    end

    # Methode qui permet de savoir si l'aide visuelle 'compteur ilots' est activee
    def compteurIlots?()
        # return un booleen
    end

    # Methode qui permet de savoir si l'aide visuelle 'afficher portee' est activee
    def affichagePortee?()
        # return un booleen
    end

    # Methode qui permet de savoir si l'aide visuelle 'afficher les murs 2x2' est activee
    def mur2x2?()
        # return un booleen
    end

    # Methode qui permet de connaitre le comportement de la souris
    def comportementSouris?()
        # return un booleen
    end

     # Methode qui permet de connaitre les raccourcis clavier choisis
    def raccourcisClavier?()
        # return un booleen
    end
end