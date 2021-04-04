# require "../Partie.rb"
# require "../Grille.rb"

class ScenarioTuto < Scenario

    def initialize()
        initialiserGrilles()
        creerGrillesCorrigees()

        @@grilleActuelle = @@grille1
        @@tutoTermine = false
        
        initialiserEtapes()
        demarrerTuto()
    end

    def initialiserEtapes()
        @@etapes = Array.new()
        @@etapes << ""
    end

    def initialiserGrilles()
        # Grille Tuto 1
        @@grille1 = Grille.creer(1,[
            [Case.creer(Couleur::BLANC, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_6, 2, 0),
                Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

            [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::ILE_2, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::BLANC, 4, 1),Case.creer(Couleur::NOIR, 5, 1)],

            [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::BLANC, 2, 2),
                Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::BLANC, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

            [Case.creer(Couleur::BLANC, 0, 4), Case.creer(Couleur::ILE_1, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
                Case.creer(Couleur::ILE_2, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::BLANC, 5, 4)],

            [Case.creer(Couleur::BLANC, 0, 5), Case.creer(Couleur::BLANC, 1, 5), Case.creer(Couleur::BLANC, 2, 5),
                Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::ILE_4, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ])


        # Grille Tuto 2
        @@grille2 = Grille.creer(2,[
            [Case.creer(Couleur::BLANC, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
                Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::NOIR, 4, 0),Case.creer(Couleur::ILE_4, 5, 0)],

            [Case.creer(Couleur::ILE_6, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::BLANC, 5, 1)],

            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::ILE_5, 1, 2), Case.creer(Couleur::BLANC, 2, 2),
                Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::BLANC, 5, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::NOIR, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

            [Case.creer(Couleur::BLANC, 0, 4), Case.creer(Couleur::BLANC, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
                Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

            [Case.creer(Couleur::BLANC, 0, 5), Case.creer(Couleur::BLANC, 1, 5), Case.creer(Couleur::BLANC, 2, 5),
                Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::ILE_3, 4, 5),Case.creer(Couleur::BLANC, 5, 5)]
        ])

        # Grille Tuto 3
        @@grille3 = Grille.creer(3,[
            [Case.creer(Couleur::BLANC, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
                Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::NOIR, 4, 0),Case.creer(Couleur::ILE_4, 5, 0)],

            [Case.creer(Couleur::ILE_6, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::BLANC, 5, 1)],

            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::ILE_5, 2, 2),
                Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::BLANC, 5, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::NOIR, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
                Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::BLANC, 1, 5), Case.creer(Couleur::BLANC, 2, 5),
                Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::ILE_3, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ])


        # Grille Tuto 4
        @@grille4 = Grille.creer(4,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::ILE_1, 2, 0),
            Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

        [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::BLANC, 2, 1),
            Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::BLANC, 4, 1),Case.creer(Couleur::ILE_2, 5, 1)],

        [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::BLANC, 2, 2),
            Case.creer(Couleur::BLANC, 3, 2), Case.creer(Couleur::BLANC, 4, 2),Case.creer(Couleur::BLANC, 5, 2)],

        [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
            Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::ILE_2, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

        [Case.creer(Couleur::BLANC, 0, 4), Case.creer(Couleur::ILE_3, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
            Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::ILE_2, 5, 4)],

        [Case.creer(Couleur::BLANC, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
            Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::BLANC, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
    ])

        # Grille Tuto 5
        @@grille5 = Grille.creer(5,[
            [Case.creer(Couleur::ILE_3, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
                Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0),Case.creer(Couleur::NOIR, 5, 0)],

            [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::ILE_1, 4, 1),Case.creer(Couleur::NOIR, 5, 1)],

            [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::BLANC, 2, 2),
                Case.creer(Couleur::ILE_3, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::BLANC, 5, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::BLANC, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

            [Case.creer(Couleur::ILE_4, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
                Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::BLANC, 5, 4)],

            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
                Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_1, 4, 5),Case.creer(Couleur::BLANC, 5, 5)]
        ])

        @@tabGrilles = Array.new()
        # Ajout des grilles dans le tableau
        @@tabGrilles << @@grille1
        @@tabGrilles << @@grille2
        @@tabGrilles << @@grille3
        @@tabGrilles << @@grille4 
        @@tabGrilles << @@grille5 
    end

    def creerGrillesCorrigees()
         # Grille Tuto 1
        @@grille1Corr = = Grille.creer(1,[
            [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_6, 2, 0),
                Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::ILE_2, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::BLANC, 4, 1),Case.creer(Couleur::BLANC, 5, 1)],

            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
                Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::NOIR, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_1, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
                Case.creer(Couleur::ILE_2, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::ILE_2, 5, 4)],

            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::NOIR, 2, 5),
                Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_4, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ])
        
        # Grille Tuto 2
        @@grille2Corr = Grille.creer(2,[
            [Case.creer(Couleur::BLANC, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
                Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::NOIR, 4, 0),Case.creer(Couleur::ILE_4, 5, 0)],

            [Case.creer(Couleur::ILE_6, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::BLANC, 5, 1)],

            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::ILE_5, 1, 2), Case.creer(Couleur::BLANC, 2, 2),
                Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::BLANC, 5, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::NOIR, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

            [Case.creer(Couleur::BLANC, 0, 4), Case.creer(Couleur::BLANC, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
                Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

            [Case.creer(Couleur::BLANC, 0, 5), Case.creer(Couleur::BLANC, 1, 5), Case.creer(Couleur::BLANC, 2, 5),
                Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::ILE_3, 4, 5),Case.creer(Couleur::BLANC, 5, 5)]
        ])

        # Grille Tuto 3
        @@grille3Corr = Grille.creer(3,[
            [Case.creer(Couleur::BLANC, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
                Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::NOIR, 4, 0),Case.creer(Couleur::ILE_4, 5, 0)],

            [Case.creer(Couleur::ILE_6, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::BLANC, 5, 1)],

            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::ILE_5, 2, 2),
                Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::BLANC, 5, 2)],

            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::NOIR, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::BLANC, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
                Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::NOIR, 2, 5),
                Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::ILE_3, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ])


        # Grille Tuto 4
        @@grille4Corr = Grille.creer(4,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_1, 2, 0),
                Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0),Case.creer(Couleur::NOIR, 5, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::BLANC, 4, 1),Case.creer(Couleur::ILE_2, 5, 1)],

            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
                Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::ILE_2, 4, 3),Case.creer(Couleur::NOIR, 5, 3)],

            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_3, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
                Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::ILE_2, 5, 4)],

            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
                Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::NOIR, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ])


        # Grille Tuto 5
        @@grille5Corr = Grille.creer(5,[
            [Case.creer(Couleur::ILE_3, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
                Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0),Case.creer(Couleur::NOIR, 5, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::ILE_1, 4, 1),Case.creer(Couleur::NOIR, 5, 1)],

            [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
                Case.creer(Couleur::ILE_3, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR 3), Case.creer(Couleur::NOIR, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::BLANC, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

            [Case.creer(Couleur::ILE_4, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
                Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
                Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_1, 4, 5),Case.creer(Couleur::NOIR, 5, 5)]
        ])

        @@tabGrillesCorr = Array.new()

        # Ajout des grilles corrigées dans le tableau
        @@tabGrillesCorr << @@grille1Corr
        @@tabGrillesCorr << @@grille2Corr
        @@tabGrillesCorr << @@grille3Corr
        @@tabGrillesCorr << @@grille4Corr
        @@tabGrillesCorr << @@grille5Corr
    end

    def demarrerTuto()
        indice = 0
        etape = @@etapes.at(indice)
        while(!@@tutoTermine)
            if(etapeFinie?(etape))
                etape = chargerEtapeSuivante(indice++)
            end
        
        end
    end

    # Methode qui permet de verifier si la grille est terminee
    def grilleTerminee?(indice)
        return (@@grilleActuelle == @@tabGrillesCorr[indice])
    end

    # Methode qui permet de passer a la grille suivante
    def passerGrilleSuivante(numGrille, nouvelle)
        if(grilleTerminee?(numGrille))
            @@grilleActuelle = nouvelle
            puts "Passage a la grille suivante"
        end
        if(ancienne == @@grille5 && ancienne.verifierEtat())
            @@tutoTermine = true 
            puts "Bravo le tuto est termine !"
        end
    end

    # Methode qui permet de passer a l'etape suivante
    def chargerEtapeSuivante(indice)
        return @@etapes[indice]
    end

    # Methode qui permet de savoir si une etape est valide
    def etapeValidee?(indice)

    end
end
