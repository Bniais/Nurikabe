require_relative "ChronoDecompte.rb"
require_relative "Malus.rb"

class PartieMalus < Partie

    private_class_method :new

    def initalize()
        super(grille, parametres, sauvegardes)
    end

    def verifierErreur(fromUser)
        if(fromUser)
            ajouterMalus(Malus::MALUS_VERIFICATION)
        end
        super(fromUser)   
    end
    ##
    #donne la position de l'erreur au joueur
    def donnerErreur()
        ajouterMalus(Malus::MALUS_DONNER_ERREUR)
        super()    
    end
    ##
    #revient a la dernière bonne position de jeu
    def revenirPositionBonne()
        ajouterMalus(Malus::MALUS_POS_BONNE)
        super()
    end
    ##
    #donne un indice sur le meilleur coup a jouer
    def donneIndice()
        ajouterMalus(Malus::MALUS_INDICE)
        super()
    end
end