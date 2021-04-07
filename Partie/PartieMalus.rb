require_relative "ChronoDecompte.rb"
require_relative "Malus.rb"

class PartieMalus < Partie

    private_class_method :new

    ##
    # Constructeur de PartieMalus
    def initalize()
        super(grille)
    end

    ##
    # A COMPLETER
    def verifierErreur(fromUser)
        if(fromUser)
            ajouterMalus(Malus::MALUS_VERIFICATION)
        end
        super(fromUser)   
    end
    ##
    #Donne la position de l'erreur au joueur
    def donnerErreur()
        ajouterMalus(Malus::MALUS_DONNER_ERREUR)
        super()    
    end
    ##
    #Revient a la dernière bonne position de jeu
    def revenirPositionBonne()
        ajouterMalus(Malus::MALUS_POS_BONNE)
        super()
    end
    ##
    #Donne un indice sur le meilleur coup a jouer
    def donneIndice()
        ajouterMalus(Malus::MALUS_INDICE)
        super()
    end
end