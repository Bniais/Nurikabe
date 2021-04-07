# require "../Partie.rb"
# require "../Grille.rb"

class ScenarioTuto < Scenario

    ##
    # Constructeur de ScenarioTuto
    def initialize()
        initialiserGrilles()
        creerGrillesCorrigees()

        initialiserEtapes()
        demarrerTuto()
    end

    ##
    # Initialise les différentes étapes du tutoriel
    def initialiserEtapes()
        @@etapes = Array.new()

        # Grille 1
        @@etapes << "Deux îles ne peuvent pas être connectées : elles sont forcément séparées par une case noire."
        @@etapes << "Lorsqu'une île a un indice de 1 (sa taille = 1), cela signifie que ses cases voisines doivent être noires."
        @@etapes << "Les cases entourés de murs horizontaux et verticaux ne peuvent pas appartenir à une île et doivent donc être colorés en noir pour faire partie d'un mur."
        @@etapes << "Tous les murs doivent former un chemin continu. Ce qui signifie que tous les murs doivent être connectés entre eux. Ici, le mur adjacent à l'ile d'incide 6 à un seul carré, la seule façon de le relier aux autres murs est de l'agrandir avec trois carrés à sa gauche."

        # Grille 2
        @@etapes << " Attention, une des règles du Nurikabe interdit les murs de 2x2 cases. L'une des ces cases est forcément blanche."

        # Grille 3
        @@etapes << "Lorsque 2 indices sont adjacents en diagonale chacune des 2 cases touchant les 2 indices doivent être noires."
        @@etapes << " Dans certains cas, une ile d'indice 2 ou le dernier carré d'une ile plus grande ne peut être agrandi que dans deux directions perpendiculaires. Dans ce cas, quelle que soit la direction dans laquelle l'expansion de l'île aura lieu, le carré diagonal doit faire partie d'un mur et est donc BLANCé."
        @@etapes << "Une île peut être agrandie directement à partir d'un indice. L'île 3 ne peut être agrandie que vers le haut et l'île 2 ne peut être agrandie que vers la droite. Nous allons marquer ces carrés avec des points pour montrer qu'ils font partie des îles respectives et ne peuvent pas faire partie d'un mur."

        # Grille 4
        @@etapes << "Cette case n'est pas atteignable car elle se situe trop loin des îles. Elle fait donc partie d'un mur et elle est de couleur noire."

        # Grille 5
        @@etapes << "Le point indique qu'il s'agit d'une case qui appartient à une île car il faut éviter d'avoir un mur 2x2."
        @@etapes << "Si ton île est déjà complète, la case BLANCe adjacente doit être noire."

    end

    ##
    # Initialise les différentes grilles du tutoriel
    def initialiserGrilles()
        # Grille Tuto 1
        @@grille1 = Grille.creer(1,[
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
              Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_1, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ])


        # Grille Tuto 2
        @@grille2 = Grille.creer(2,[
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

          [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::BLANC, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
              Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

          [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::BLANC, 2, 5),
              Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::ILE_3, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
      ])


        # Grille Tuto 4
        @@grille4 = Grille.creer(4,[
          [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_7, 2, 0),
              Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

          [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
              Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::BLANC, 4, 1),Case.creer(Couleur::BLANC, 5, 1)],

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
          [Case.creer(Couleur::BLANC, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
              Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

          [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
              Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::ILE_5, 5, 1)],

          [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::ILE_2, 1, 2), Case.creer(Couleur::BLANC, 2, 2),
              Case.creer(Couleur::BLANC, 3, 2), Case.creer(Couleur::ILE_5, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

          [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
              Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::BLANC, 4, 3),Case.creer(Couleur::NOIR, 5, 3)],

          [Case.creer(Couleur::ILE_1, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
              Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::BLANC, 5, 4)],

          [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::BLANC, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
              Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::BLANC, 4, 5),Case.creer(Couleur::ILE_1, 5, 5)],
      ])

        @@tabGrilles = Array.new()
        # Ajout des grilles dans le tableau
        @@tabGrilles << @@grille1
        @@tabGrilles << @@grille2
        @@tabGrilles << @@grille3
        @@tabGrilles << @@grille4
        @@tabGrilles << @@grille5
    end

    ##
    # A COMPLETER
    def creerGrillesCorrigees()
         # Grille Tuto 1
        @@grille1Corr = = Grille.creer(1,[
          [Case.creer(Couleur::ILE_3, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
              Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0),Case.creer(Couleur::NOIR, 5, 0)],

          [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
              Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::ILE_1, 4, 1),Case.creer(Couleur::NOIR, 5, 1)],

          [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
              Case.creer(Couleur::ILE_3, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

          [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
              Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::BLANC, 4, 3),Case.creer(Couleur::NOIR, 5, 3)],

          [Case.creer(Couleur::ILE_4, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
              Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

          [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
              Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_1, 4, 5),Case.creer(Couleur::NOIR, 5, 5)],
      ])

        # Grille Tuto 2
        @@grille2Corr = Grille.creer(2,[
          [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_6, 2, 0),
              Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

          [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::ILE_2, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
              Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::BLANC, 4, 1),Case.creer(Couleur::NOIR, 5, 1)],

          [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
              Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

          [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
              Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::NOIR, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

          [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_1, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
              Case.creer(Couleur::ILE_2, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::BLANC, 5, 4)],

          [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::NOIR, 2, 5),
              Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_4, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
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
          [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_7, 2, 0),
              Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

          [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
              Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::BLANC, 4, 1),Case.creer(Couleur::BLANC, 5, 1)],

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
          [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
              Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

          [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
              Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::ILE_5, 5, 1)],

          [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::ILE_2, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
              Case.creer(Couleur::BLANC, 3, 2), Case.creer(Couleur::ILE_5, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

          [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
              Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::BLANC, 4, 3),Case.creer(Couleur::NOIR, 5, 3)],

          [Case.creer(Couleur::ILE_1, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
              Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

          [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
              Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::NOIR, 4, 5),Case.creer(Couleur::ILE_1, 5, 5)],
      ])

        @@tabGrillesCorr = Array.new()

        # Ajout des grilles corrigées dans le tableau
        @@tabGrillesCorr << @@grille1Corr
        @@tabGrillesCorr << @@grille2Corr
        @@tabGrillesCorr << @@grille3Corr
        @@tabGrillesCorr << @@grille4Corr
        @@tabGrillesCorr << @@grille5Corr
    end

    ##
    # Met le tutoriel à l'état initial et parcours les différentes étapes
    def demarrerTuto()
        indice = 0
        @@grilleActuelle = @@tabGrilles.at(indice)
        @@tutoTermine = false
        etape = @@etapes.at(indice)

        while(!@@tutoTermine)
            if(etapeFinie?(etape))
                etape = chargerEtapeSuivante(indice++)
            end
            passerGrilleSuivante()
        end
    end
    ##
    # Methode qui permet de verifier si la grille est terminee
    def grilleTerminee?(indice)
        return (@@grilleActuelle == @@tabGrillesCorr[indice])
    end
    ##
    # Methode qui permet de passer a la grille suivante
    def passerGrilleSuivante(numGrille)
        # Verification que la grille est terminee avant de passer a la suivante
        if(grilleTerminee?(numGrille))
            @@grilleActuelle = @@tabGrilles.at(numGrille+1)
            puts "Passage a la grille suivante"
        end
        # Si on est sur la derniere grille et qu'elle est terminee => tuto fini
        if(numGrille == 4 && grilleTerminee?(numGrille))
            @@tutoTermine = true
            puts "Bravo le tuto est termine !"
        end
    end
    ##
    # Methode qui permet de passer a l'etape suivante
    def chargerEtapeSuivante(indice)
        return @@etapes[indice+1]
    end
    ##
    # Methode qui permet de savoir si une etape est valide
    def etapeValidee?(indice)
        #
    end
end
