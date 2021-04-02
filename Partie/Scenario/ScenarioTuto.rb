# require "../Partie.rb"
# require "../Grille.rb"

class ScenarioTuto < Scenario

    def initialize()
        @@tabGrilles = Array.new()
    end

    def initialiserGrilles()
        # @@tabGrilles
    end

    def creerGrille()


        grille8 = Grille.creer(11,[
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

    def verifierEtat()
        # return un booleen
    end

    def chargerEtapeSuivante()

    end

    def afficheToi()

    end

end
