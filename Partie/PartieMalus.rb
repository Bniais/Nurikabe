require_relative "ChronoDecompte.rb"
require_relative "Malus.rb"

##
# Classe abstraite qui représente un partie qui se joue avec des malus
class PartieMalus < Partie

    #Classe abstraite ne pouvait être instanciée
    private_class_method :new

    ##
    # Définit comment les sous-classes seront initialisées
    def initalize(grille)
        super(grille)
    end

    ##
    # Redéfinition de la verification des erreurs, en ajoutant un malus
    def verifierErreur(fromUser)
        if(fromUser)
            ajouterMalus(Malus::MALUS_VERIFICATION)
        end
        super(fromUser)
    end

    ##
    # Redéfinition de l'indice sur la position de l'erreur, en ajoutant un malus
    def donnerErreur()
        ajouterMalus(Malus::MALUS_DONNER_ERREUR)
        super()
    end

    ##
    #Redéfinition de l'aide de retour à la dernière bonne position de jeu, en ajoutant un malus
    def revenirPositionBonne()
        ajouterMalus(Malus::MALUS_POS_BONNE)
        super()
    end

    ##
    # Redéfinition de l'aide d'indice, en ajoutant un malus
    def donneIndice()
        res = super()
        if res != nil
            ajouterMalus(Malus::MALUS_INDICE)
        end
        return res
    end
end