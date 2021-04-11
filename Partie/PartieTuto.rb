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
    @tabGrille = [

      Grille.creer(1,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::BLANC, 2, 1), Case.creer(Couleur::ILE_3, 3, 1)],

            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3), Case.creer(Couleur::ILE_2, 3, 3)],         
        ], [0,0,0] 
      ),
    
      Grille.creer(2,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::BLANC, 2, 1), Case.creer(Couleur::ILE_3, 3, 1)],

            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3), Case.creer(Couleur::ILE_2, 3, 3)],         
        ], [0,0,0] 
      ),

      Grille.creer(3,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::BLANC, 2, 1), Case.creer(Couleur::ILE_3, 3, 1)],

            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3), Case.creer(Couleur::ILE_2, 3, 3)],         
        ], [0,0,0] 
      ),

      Grille.creer(4,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::BLANC, 2, 1), Case.creer(Couleur::ILE_3, 3, 1)],

            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3), Case.creer(Couleur::ILE_2, 3, 3)],         
        ], [0,0,0] 
      ),

      Grille.creer(5,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::BLANC, 2, 1), Case.creer(Couleur::ILE_3, 3, 1)],

            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3), Case.creer(Couleur::ILE_2, 3, 3)],         
        ], [0,0,0] 
      ),
    ]



    @tabGrilleDepart = [
      Grille.creer(1,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::GRIS, 2, 1), Case.creer(Couleur::ILE_3, 3, 1)],

            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3), Case.creer(Couleur::ILE_2, 3, 3)],         
        ], [0,0,0] 
      ),
      Grille.creer(2,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::GRIS, 2, 1), Case.creer(Couleur::ILE_3, 3, 1)],

            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3), Case.creer(Couleur::ILE_2, 3, 3)],         
        ], [0,0,0] 
      ),
      Grille.creer(3,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::GRIS, 2, 1), Case.creer(Couleur::ILE_3, 3, 1)],

            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3), Case.creer(Couleur::ILE_2, 3, 3)],         
        ], [0,0,0] 
      ),
      Grille.creer(4,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::GRIS, 2, 1), Case.creer(Couleur::ILE_3, 3, 1)],

            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3), Case.creer(Couleur::ILE_2, 3, 3)],         
        ], [0,0,0] 
      ),
      Grille.creer(5,[
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0)],

            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::GRIS, 2, 1), Case.creer(Couleur::ILE_3, 3, 1)],

            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],

            [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::BLANC, 2, 3), Case.creer(Couleur::ILE_2, 3, 3)],         
        ], [0,0,0] 
      )
    ]

    @coupAutoriser = [
      [
        [false , false , false , false],[ false , false , true , false ],[false , false , false , false],[false , false , false , false]
      ],
      [
        [false , true , true , false],[ false , true , true , false ],[ false , true , true , false ],[ false , true , true , false ]       
      ],
      [
        [false , true , true , false],[ false , true , true , false ],[ false , true , true , false ],[ false , true , true , false ]
      ],
      [
        [false , true , true , false],[ false , true , true , false ],[ false , true , true , false ],[ false , true , true , false ]        
      ],
      [
        [false , true , true , false],[ false , true , true , false ],[ false , true , true , false ],[ false , true , true , false ]        
      ]
    ]

    @aidePourEtape = [
      [false,false,false,false,false,false,false,false,false,false,false],
      [false,false,false,false,false,false,false,false,false,false,false],
      [false,false,false,false,false,false,false,false,false,false,false],
      [false,false,false,false,false,false,false,false,false,false,false],
      [false,false,false,false,false,false,false,false,false,false,false]
    ]

    # Retourne un tableau de case a focus
    @caseFocus = [
      [ 
          [2,1],[3,1]
      ],
      [
          [0,0],[1,1],[2,2],[3,3]
      ],
      [
          [0,0]
      ],
      [
          [0,0],[2,2]
      ],
      [
        nil
      ]
    ]

    @messageEtape = [
      "Survoler la case en surbrillant vous permets de connaitre la taille d'une ile\n Cliquer dessus vous donnez la porter",
      "message pour grille 2",
      "message pour grille 3",
      "message pour grille 4",
      "message pour grille 5"
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
    puts "Je suis la"
    @grilleActuel += 1

    if @grilleActuel < @tabGrille.size() 
      @grilleBase = @tabGrille[@grilleActuel]

      @grilleEnCours = @tabGrilleDepart[@grilleActuel]

      return @tabGrille[@grilleActuel]
    end

    return nil
    #redef
  end

  # Retourne le message specifique a l'aide pour tel partie
  def getMessageAide()
    return @messageEtape[@grilleActuel];
  end

  # Retourne un tableau qui defini l'etat des differentes aides
  def aideADesactiver()
    return @aidePourEtape[@grilleActuel];
  end

  # Retourne les coordonnees d'une case que l'on voudront encadrer en rouge
  def getCaseFocus()
    return @caseFocus[@grilleActuel];
  end

  def ajouterCoup(coup)#TOTEST
    if(coup.couleur != coup.case.couleur && coup.couleur < Couleur::ILE_1 && @coupAutoriser[@grilleActuel][coup.case.positionY][coup.case.positionX] ) 
      coup.case.couleur = coup.couleur

      tabCoup.pop(tabCoup.size - @indiceCoup) #supprimer les coups annulés
      tabCoup.push(coup)
      @indiceCoup += 1
      return true
    end
    return false
  end

  ##
  #Retourne le mode Tutoriel
  def getMode()
    return Mode::TUTORIEL
  end
end
