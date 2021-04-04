# require "../Partie.rb"
# require "../Grille.rb"

class ScenarioTuto < Scenario

    def initialize()
        initialiserGrilles()
        @@grilleActuelle = @@grille1
    end

    def initialiserGrilles()
        # Grille Tuto 1
        # @@grille1 =

        # Grille Tuto 2
        # @@grille2 =

        # Grille Tuto 3
        # @@grille3 =

        # Grille Tuto 4
        @@grille4 = Grille.creer(4,[
            [Case.creer(Couleur::BLANC, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::GRIS, 2, 0),
                Case.creer(Couleur::GRIS, 3, 0), Case.creer(Couleur::GRIS, 4, 0),Case.creer(Couleur::GRIS, 5, 0)],

            [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::ILE_5, 5, 1)],

            [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::ILE_2, 1, 2), Case.creer(Couleur::BLANC, 2, 2),
                Case.creer(Couleur::BLANC, 3, 2), Case.creer(Couleur::ILE_4, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::BLANC, 4, 3),Case.creer(Couleur::NOIR, 5, 3)],

            [Case.creer(Couleur::ILE_2, 0, 4), Case.creer(Couleur::BLANC, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
                Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::BLANC, 5, 4)],

            [Case.creer(Couleur::BLANC, 0, 5), Case.creer(Couleur::BLANC, 1, 5), Case.creer(Couleur::BLANC, 2, 5),
                Case.creer(Couleur::ILE_3, 3, 5), Case.creer(Couleur::BLANC, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ])

        # Grille Tuto 5
        @@grille5 = Grille.creer(5,[
            [Case.creer(Couleur::ILE_3, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::GRIS, 2, 0),
                Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0),Case.creer(Couleur::NOIR, 5, 0)],

            [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
                Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::ILE_1, 4, 1),Case.creer(Couleur::NOIR, 5, 1)],

            [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::BLANC, 2, 2),
                Case.creer(Couleur::ILE_2, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::BLANC, 5, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
                Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::BLANC, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

            [Case.creer(Couleur::ILE_1, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
                Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::ILE_1, 4, 4),Case.creer(Couleur::BLANC, 5, 4)],

            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
                Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::BLANC, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ])


    end

    def creerGrille()




    end

    def verifierEtat()
        # return un booleen
    end

    def chargerEtapeSuivante(ancienne, nouvelle)
        if(ancienne.verifierEtat)
            @@grilleActuelle = nouvelle
        end
    end

    def afficheToi()

    end

end
