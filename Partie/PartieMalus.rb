class PartieMalus < Partie

    def PartieContreLaMontre.creer()
        new();
    end

    def verifierErreur()
        super()
        ajouterMalus(MALUS_VERIFICATION)
    end

    #donne la position de l'erreur au joueur
    def donnerErreur()
        super()
        ajouterMalus(MALUS_DONNER_ERREUR)
    end

    #revient a la dernière bonne position de jeu
    def revenirPositionBonne()
        super()
        ajouterMalus(MALUS_POS_BONNE)
    end

    #donne un indice sur le meilleur coup a jouer
    def donneIndice()
        super()
        ajouterMalus(MALUS_INDICE)
    end
end