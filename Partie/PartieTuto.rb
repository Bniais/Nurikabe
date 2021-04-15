class PartieTuto < Partie
  private_class_method :new
  attr_accessor :grille, :progression, :senarios
  ##
  #ceer une partie en mode survie


  def PartieTuto.creer()
    new()
  end
  ##
  #Contructeur de PartieTuto
  def initialize()

    @grilleActuel = 0
    @dernierMessageDemander = -1
    @ordreDeClicCpt = 0
    @tabGrille = [

      Grille.creer(1,[
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

            ], [0,0,0]
      ),

      Grille.creer(2,[
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
        ], [0,0,0]
      ),

      Grille.creer(3,[
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
        ], [0,0,0]
      ),

      Grille.creer(4,[
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
        ], [0,0,0]
      ),
    ]



    @tabGrilleDepart = [
      Grille.creer(1,[
        [Case.creer(Couleur::ILE_3, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
            Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::BLANC, 2, 1),
            Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::ILE_1, 4, 1),Case.creer(Couleur::BLANC, 5, 1)],

        [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
            Case.creer(Couleur::ILE_3, 3, 2), Case.creer(Couleur::BLANC, 4, 2),Case.creer(Couleur::BLANC, 5, 2)],

        [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
            Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::BLANC, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

        [Case.creer(Couleur::ILE_4, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
            Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::BLANC, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
            Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::ILE_1, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ], [0,0,0]
      ),

      Grille.creer(2,[
        [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_6, 2, 0),
          Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::ILE_2, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
          Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::NOIR, 5, 1)],

        [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
          Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

        [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
          Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::NOIR, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

        [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_1, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
          Case.creer(Couleur::ILE_2, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::BLANC, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::NOIR, 2, 5),
          Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_4, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ], [0,0,0]
      ),

      Grille.creer(3,[
        [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_7, 2, 0),
            Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
            Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::BLANC, 4, 1),Case.creer(Couleur::BLANC, 5, 1)],

        [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
            Case.creer(Couleur::BLANC, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

        [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
            Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::ILE_2, 4, 3),Case.creer(Couleur::BLANC, 5, 3)],

        [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_3, 1, 4), Case.creer(Couleur::BLANC, 2, 4),
            Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::BLANC, 4, 4),Case.creer(Couleur::ILE_2, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::BLANC, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
            Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::BLANC, 4, 5),Case.creer(Couleur::BLANC, 5, 5)],
        ], [0,0,0]
      ),


    Grille.creer(4,[
        [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::BLANC, 1, 0), Case.creer(Couleur::BLANC, 2, 0),
            Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0),Case.creer(Couleur::BLANC, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
            Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::ILE_5, 5, 1)],

        [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::ILE_2, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
            Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::ILE_5, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

        [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3),
            Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::NOIR, 4, 3),Case.creer(Couleur::NOIR, 5, 3)],

        [Case.creer(Couleur::ILE_1, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
            Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
            Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::NOIR, 4, 5),Case.creer(Couleur::ILE_1, 5, 5)],
      ], [0,0,0]
      )
    ]

    @coupAutoriser = [
      [
        [999 , 999 , 999 , 999, 1, 2],[ 999 , 999 , 3 , 1, 999, 1],[999 , 999 , 999 , 999, 1, 3],[999 , 999 , 3 , 999, 999, 3],[999 , 999 , 999 , 999, 1, 3],[999 , 999 , 999 , 0, 999, 1]
      ],
      [
        [999 , 999 , 999 , 999, 999, 999],[ 999 , 999 , 999 , 999, 0, 0],[999 , 999 , 999 , 999, 0, 0],[999 , 999 , 999 , 999, 999, 999],[999 , 999 , 999 , 999, 999, 999],[1 , 999 , 999 , 999, 999, 999]
      ],
      [
        [999 , 999 , 999 , 999, 999, 999],[ 999 , 999 , 999 , 999, 999, 999],[999 , 999 , 999 , 1, 999, 999],[999 , 999 , 999 , 999, 999, 0],[999 , 999 , 0 , 2, 0, 999],[999 , 0 , 999 , 999, 2, 999]
      ],
      [
        [999 , 1 , 999 , 999, 999, 999],[ 999 , 999 , 999 , 999, 999, 999],[999 , 999 , 999 , 0, 999, 999],[999 , 999 , 999 , 999, 0, 999],[999 , 999 , 999 , 999, 999, 999],[999 , 999 , 999 , 999, 999, 999]
      ],
    ]

    @aidePourEtape = [
      [true, true, true, true, true, true, true, true, true, true, true],
      [true, true, true, true, true, true, true, true, true, true, true],
      [true, true, true, true, true, true, true, true, true, true, true],
      [true, true, true, true, true, true, true, true, true, true, true],
      [true, true, true, true, true, true, true, true, true, true, true],
      [true, true, true, true, true, true, true, true, true, true, true],
      [true, true, true, true, true, true, true, true, true, true, true],
      [true, true, true, true, true, true, true, true, true, true, true],
      [true, true, true, true, true, true, true, true, true, true, true],
      [true, true, true, true, true, true, true, true, true, true, true],
      [true, true, true, true, true, true, true, true, true, true, true]
    ]

    @messageEtape = [
      # Grille 1
      [
        "Deux îles ne peuvent pas être connectées : elles sont forcément séparées par une case noire.",

        "Lorsqu'une île a un indice de 1 (sa taille = 1), cela signifie que ses cases voisines doivent être noires.",

        "Les cases entourés de murs horizontaux et verticaux ne peuvent pas appartenir à une île et doivent donc être colorés en noir pour faire partie d'un mur.",

        "Tous les murs doivent former un chemin continu. Ce qui signifie que tous les murs doivent être connectés entre eux."
      ],
       # Grille 2
      [
        " Attention, une des règles du Nurikabe interdit les murs de 2x2 cases. L'une des ces cases est forcément blanche.",

        "Cette case n'est pas atteignable car elle se situe trop loin des îles. Elle fait donc partie d'un mur et elle est de couleur noire."
      ],
      # Grille 3
      [
        "Lorsque 2 indices sont adjacents en diagonale chacune des 2 cases touchant les 2 indices doivent être noires.",

        "Dans certains cas, une ile d'indice 2 ou le dernier carré d'une ile plus grande ne peut être agrandi que dans deux directions perpendiculaires. Dans ce cas, quelle que soit la direction dans laquelle l'expansion de l'île aura lieu, le carré diagonal doit faire partie d'un mur et est donc grisé.",

        "Une île peut être agrandie directement à partir d'un indice. L'île 3 ne peut être agrandie que vers le haut et l'île 2 ne peut être agrandie que vers la droite. Nous allons marquer ces carrés avec des points pour montrer qu'ils font partie des îles respectives et ne peuvent pas faire partie d'un mur."
      ],
      # Grille 4
      [
        "Le point indique qu'il s'agit d'une case qui appartient à une île car il faut éviter d'avoir un mur 2x2.",

        "Si ton île est déjà complète, la case blanche adjacente doit être noire."
      ]
    ]

    # CALL SUPER TO INIT PARTIE
    super( @tabGrille[@grilleActuel] )

    # SET TO GRILLE DEPART DIFFERENTE POUR ETAPES
    # DU TUTORIEL
    @grilleEnCours = @tabGrilleDepart[@grilleActuel]
  end


  ##
  #Tire lla prochaine grille
  def grilleSuivante()
    @grilleActuel += 1
    @ordreDeClicCpt = 0;

    if @grilleActuel < @tabGrille.size()
      @grilleBase = @tabGrille[@grilleActuel]

      @grilleEnCours = @tabGrilleDepart[@grilleActuel]

      return @tabGrille[@grilleActuel]
    end

    return nil
    #redef
  end

   ##
  # Retourne le message specifique a l'aide pour tel partie
  def getMessageAide()
    @dernierMessageDemander = @ordreDeClicCpt
    return @messageEtape[@grilleActuel][@ordreDeClicCpt];
  end

  ##
  # Retourne vrai si un nouveau message est disponible
  # faux sinon
  def messageDifferent?()
    puts "dm = " + @dernierMessageDemander.to_s +  " odc = " + @ordreDeClicCpt.to_s
    return @dernierMessageDemander < @ordreDeClicCpt
  end

  # Retourne un tableau qui defini l'etat des differentes aides
  def aideADesactiver()
    return @aidePourEtape[@grilleActuel];
  end



  def ajouterCoup(coup) #TOTEST

    # @ordreDeClicCpt
    find = false
    for x in 0...@grilleEnCours.tabCases.size
      for y in 0...@grilleEnCours.tabCases.size
        if ( @coupAutoriser[@grilleActuel][y][x] == @ordreDeClicCpt )
          find = true;
        end
      end
    end


    if !find
      @ordreDeClicCpt += 1;
    end

    if ( @coupAutoriser[@grilleActuel][coup.case.positionY][coup.case.positionX] == @ordreDeClicCpt )

      if(coup.couleur != coup.case.couleur && coup.couleur < Couleur::ILE_1)
        coup.case.couleur = coup.couleur
        tabCoup.pop(tabCoup.size - @indiceCoup) #supprimer les coups annulés
        tabCoup.push(coup)
        @indiceCoup += 1

        if( @grilleEnCours.tabCases[coup.case.positionY][coup.case.positionX].couleur == @grilleBase.tabCases[coup.case.positionY][coup.case.positionX].couleur )
          @coupAutoriser[@grilleActuel][coup.case.positionY][coup.case.positionX] = 999;
        end

      else
        @coupAutoriser[@grilleActuel][coup.case.positionY][coup.case.positionX] = 999;
      end

      # @ordreDeClicCpt
      find = false
      for x in 0...@grilleEnCours.tabCases.size
        for y in 0...@grilleEnCours.tabCases.size
          if ( @coupAutoriser[@grilleActuel][y][x] == @ordreDeClicCpt )
            find = true;
          end
        end
      end


      if !find
        @ordreDeClicCpt += 1;
      end

      return true
    end


    return false
  end

  ##
  # Retourne le tableau de coup autoriser
  def getCoupAutoriser
    return @coupAutoriser[@grilleActuel];
  end

  ##
  #Retourne le mode Tutoriel
  def getMode()
    return Mode::TUTORIEL
  end
end
