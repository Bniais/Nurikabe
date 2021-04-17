require_relative '../Parametres/Langue.rb'
require_relative '../Sauvegarde/Sauvegardes.rb'

##
# Classe qui gere le tutoriel du jeu
class PartieTuto < Partie

  private_class_method :new

  ##
  # variable qui permet d'accéder aux langues
  @@lg = nil


  ##
  # Methode qui permet de creer une partie en mode 'tutoriel'
  def PartieTuto.creer()
    new()
  end

  ##
  # Methode privee pour l'initialisation
  def initialize()
    Sauvegardes.creer
    ## gestion des langues
    @@lg = Sauvegardes.getInstance.getSauvegardeLangue

    @grilleActuel = 0
    @dernierMessageDemander = -1
    @ordreDeClicCpt = 0

    # tableau des grilles du tuto dans leur etats finaux
    @tabGrille = [
      Grille.creer(1,[
            [Case.creer(Couleur::ILE_3, 0, 0), Case.creer(Couleur::GRIS, 1, 0), Case.creer(Couleur::GRIS, 2, 0),
              Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0),Case.creer(Couleur::NOIR, 5, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
              Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::ILE_1, 4, 1),Case.creer(Couleur::NOIR, 5, 1)],

            [Case.creer(Couleur::GRIS, 0, 2), Case.creer(Couleur::GRIS, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
              Case.creer(Couleur::ILE_3, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

            [Case.creer(Couleur::GRIS, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
              Case.creer(Couleur::GRIS, 3, 3), Case.creer(Couleur::GRIS, 4, 3),Case.creer(Couleur::NOIR, 5, 3)],

            [Case.creer(Couleur::ILE_4, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::GRIS, 2, 4),
              Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
              Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_1, 4, 5),Case.creer(Couleur::NOIR, 5, 5)],

            ], [0,0,0]
      ),

      Grille.creer(2,[
        [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_6, 2, 0),
          Case.creer(Couleur::GRIS, 3, 0), Case.creer(Couleur::GRIS, 4, 0),Case.creer(Couleur::GRIS, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::ILE_2, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
          Case.creer(Couleur::GRIS, 3, 1), Case.creer(Couleur::GRIS, 4, 1),Case.creer(Couleur::NOIR, 5, 1)],

        [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::GRIS, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
          Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

        [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
          Case.creer(Couleur::GRIS, 3, 3), Case.creer(Couleur::NOIR, 4, 3),Case.creer(Couleur::GRIS, 5, 3)],

        [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_1, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
          Case.creer(Couleur::ILE_2, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::GRIS, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::NOIR, 2, 5),
          Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_4, 4, 5),Case.creer(Couleur::GRIS, 5, 5)],
        ], [0,0,0]
      ),

      Grille.creer(3,[
        [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_7, 2, 0),
          Case.creer(Couleur::GRIS, 3, 0), Case.creer(Couleur::GRIS, 4, 0),Case.creer(Couleur::GRIS, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
          Case.creer(Couleur::GRIS, 3, 1), Case.creer(Couleur::GRIS, 4, 1),Case.creer(Couleur::GRIS, 5, 1)],

        [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::GRIS, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
          Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

        [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::GRIS, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
          Case.creer(Couleur::GRIS, 3, 3), Case.creer(Couleur::ILE_2, 4, 3),Case.creer(Couleur::NOIR, 5, 3)],

        [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_3, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
          Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::ILE_2, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
          Case.creer(Couleur::GRIS, 3, 5), Case.creer(Couleur::NOIR, 4, 5),Case.creer(Couleur::GRIS, 5, 5)],
        ], [0,0,0]
      ),

      Grille.creer(4,[
        [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::GRIS, 2, 0),
        Case.creer(Couleur::GRIS, 3, 0), Case.creer(Couleur::GRIS, 4, 0),Case.creer(Couleur::GRIS, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::GRIS, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
        Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::ILE_5, 5, 1)],

        [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::ILE_2, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
        Case.creer(Couleur::BLANC, 3, 2), Case.creer(Couleur::ILE_5, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

        [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::GRIS, 2, 3),
        Case.creer(Couleur::GRIS, 3, 3), Case.creer(Couleur::BLANC, 4, 3),Case.creer(Couleur::NOIR, 5, 3)],

        [Case.creer(Couleur::ILE_1, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
        Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
        Case.creer(Couleur::GRIS, 3, 5), Case.creer(Couleur::NOIR, 4, 5),Case.creer(Couleur::ILE_1, 5, 5)],
        ], [0,0,0]
      ),
    ]

    # tableau des grilles du tuto dans leurs etats initiaux
    @tabGrilleDepart = [
      Grille.creer(1,[
        [Case.creer(Couleur::ILE_3, 0, 0), Case.creer(Couleur::GRIS, 1, 0), Case.creer(Couleur::GRIS, 2, 0),
            Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::GRIS, 4, 0),Case.creer(Couleur::GRIS, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::GRIS, 2, 1),
            Case.creer(Couleur::GRIS, 3, 1), Case.creer(Couleur::ILE_1, 4, 1),Case.creer(Couleur::GRIS, 5, 1)],

        [Case.creer(Couleur::GRIS, 0, 2), Case.creer(Couleur::GRIS, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
            Case.creer(Couleur::ILE_3, 3, 2), Case.creer(Couleur::GRIS, 4, 2),Case.creer(Couleur::GRIS, 5, 2)],

        [Case.creer(Couleur::GRIS, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::GRIS, 2, 3),
            Case.creer(Couleur::GRIS, 3, 3), Case.creer(Couleur::GRIS, 4, 3),Case.creer(Couleur::GRIS, 5, 3)],

        [Case.creer(Couleur::ILE_4, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::GRIS, 2, 4),
            Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::GRIS, 4, 4),Case.creer(Couleur::GRIS, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
            Case.creer(Couleur::GRIS, 3, 5), Case.creer(Couleur::ILE_1, 4, 5),Case.creer(Couleur::GRIS, 5, 5)],
        ], [0,0,0]
      ),

      Grille.creer(2,[
        [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_6, 2, 0),
          Case.creer(Couleur::GRIS, 3, 0), Case.creer(Couleur::GRIS, 4, 0),Case.creer(Couleur::GRIS, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::ILE_2, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
          Case.creer(Couleur::GRIS, 3, 1), Case.creer(Couleur::GRIS, 4, 1),Case.creer(Couleur::GRIS, 5, 1)],

        [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::GRIS, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
          Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::GRIS, 4, 2),Case.creer(Couleur::GRIS, 5, 2)],

        [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
          Case.creer(Couleur::GRIS, 3, 3), Case.creer(Couleur::NOIR, 4, 3),Case.creer(Couleur::GRIS, 5, 3)],

        [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_1, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
          Case.creer(Couleur::ILE_2, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::GRIS, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::NOIR, 2, 5),
          Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_4, 4, 5),Case.creer(Couleur::GRIS, 5, 5)],
        ], [0,0,0]
      ),

      Grille.creer(3,[
        [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::ILE_7, 2, 0),
            Case.creer(Couleur::GRIS, 3, 0), Case.creer(Couleur::GRIS, 4, 0),Case.creer(Couleur::GRIS, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
            Case.creer(Couleur::GRIS, 3, 1), Case.creer(Couleur::GRIS, 4, 1),Case.creer(Couleur::GRIS, 5, 1)],

        [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::GRIS, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
            Case.creer(Couleur::GRIS, 3, 2), Case.creer(Couleur::NOIR, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

        [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::GRIS, 1, 3), Case.creer(Couleur::NOIR, 2, 3),
            Case.creer(Couleur::GRIS, 3, 3), Case.creer(Couleur::ILE_2, 4, 3),Case.creer(Couleur::GRIS, 5, 3)],

        [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_3, 1, 4), Case.creer(Couleur::GRIS, 2, 4),
            Case.creer(Couleur::GRIS, 3, 4), Case.creer(Couleur::GRIS, 4, 4),Case.creer(Couleur::ILE_2, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::GRIS, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
            Case.creer(Couleur::GRIS, 3, 5), Case.creer(Couleur::GRIS, 4, 5),Case.creer(Couleur::GRIS, 5, 5)],
        ], [0,0,0]
      ),


      Grille.creer(4,[
        [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::GRIS, 1, 0), Case.creer(Couleur::GRIS, 2, 0),
            Case.creer(Couleur::GRIS, 3, 0), Case.creer(Couleur::GRIS, 4, 0),Case.creer(Couleur::GRIS, 5, 0)],

        [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::GRIS, 1, 1), Case.creer(Couleur::NOIR, 2, 1),
            Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::NOIR, 4, 1),Case.creer(Couleur::ILE_5, 5, 1)],

        [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::ILE_2, 1, 2), Case.creer(Couleur::NOIR, 2, 2),
            Case.creer(Couleur::GRIS, 3, 2), Case.creer(Couleur::ILE_5, 4, 2),Case.creer(Couleur::NOIR, 5, 2)],

        [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::GRIS, 2, 3),
            Case.creer(Couleur::GRIS, 3, 3), Case.creer(Couleur::GRIS, 4, 3),Case.creer(Couleur::NOIR, 5, 3)],

        [Case.creer(Couleur::ILE_1, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::NOIR, 2, 4),
            Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4),Case.creer(Couleur::NOIR, 5, 4)],

        [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),
            Case.creer(Couleur::GRIS, 3, 5), Case.creer(Couleur::NOIR, 4, 5),Case.creer(Couleur::ILE_1, 5, 5)],
      ], [0,0,0]
      )
      ]

    # tableau des coups autorises <=> determine les cases a modifier dans l'ordre (999 == case non modifiable / sinon : numero de l'etape dans laquelle la case sera modifiable)
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

    # aides disponibles par etapes
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

    # tableau des messages de chaque etape du tuto
    @messageEtape = [
      # Grille 1
      [
        @@lg.gt("ETAPE_1_TUTO"),
        @@lg.gt("ETAPE_2_TUTO"),
        @@lg.gt("ETAPE_3_TUTO"),
        @@lg.gt("ETAPE_4_TUTO")
      ],
       # Grille 2
      [
        @@lg.gt("ETAPE_5_TUTO"),
        @@lg.gt("ETAPE_6_TUTO")
      ],
      # Grille 3
      [
        @@lg.gt("ETAPE_7_TUTO"),
        @@lg.gt("ETAPE_8_TUTO"),
        @@lg.gt("ETAPE_9_TUTO")
      ],
      # Grille 4
      [
        @@lg.gt("ETAPE_10_TUTO"),
        @@lg.gt("ETAPE_11_TUTO")
      ]
    ]

    # CALL SUPER TO INIT PARTIE
    super( @tabGrille[@grilleActuel] )

    # SET TO GRILLE DEPART DIFFERENTE POUR ETAPES
    # DU TUTORIEL
    @grilleEnCours = @tabGrilleDepart[@grilleActuel]
  end


  ##
  # Tire la prochaine grille
  def grilleSuivante()
    @grilleActuel += 1
    @ordreDeClicCpt = 0

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
    return @messageEtape[@grilleActuel][@ordreDeClicCpt]
  end

  ##
  # Retourne vrai si un nouveau message est disponible
  # faux sinon
  def messageDifferent?()
    return @dernierMessageDemander < @ordreDeClicCpt
  end

  ##
  # Retourne un tableau qui defini l'etat des differentes aides
  def aideADesactiver()
    return @aidePourEtape[@grilleActuel]
  end


  ##
  # Methode qui permet d'ajouter un coup
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
