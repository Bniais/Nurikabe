require_relative './Fenetre.rb'
require_relative './FenetreDetailScore.rb'

##
# Classe qui gere l'affichage de la fenetre 'Classement'
# Herite de la classe Fenetre
class FenetreClassement < Fenetre
    ##
    # Détermine si la case Facile est cochée
    @@easyActivated = true

    ##
    # Détermine si la case Moyen est cochée
    @@mediumActivated = true

    ##
    # Détermine si la case Difficile est cochée
    @@hardActivated = true

    ##
    # Methode pour l'initialisation
    def initialize()
        self
    end

    ##
    # Affiche la fenêtre de classement
    def self.afficheToi( lastView )
        Fenetre.set_subtitle(@@lg.gt("CLASSEMENT"))
        Fenetre.add( FenetreClassement.new().creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end

    ##
    # Crée l'interface :
    # * gestion de l'affichage des boutons, combobox
    # * gestion de l'affichage des grilles
    def creationInterface( lastView )

        box = Gtk::Box.new(:vertical)

        #Bouton retour
        btnBoxH = Gtk::ButtonBox.new(:horizontal)
        btnBoxH.halign = :fill
        btnBack = Gtk::Button.new(:label => @@lg.gt("RETOUR"))
        btnBack.name = "btnBack"
        btnBack.signal_connect("clicked") { Fenetre.remove(box) ; lastView.afficheToi( nil ) ; }
        lastView == nil ? btnBack.set_sensitive(false) : btnBack.set_sensitive(true)
        setmargin(btnBack,5,5,5,0)
        btnBoxH.add(btnBack)

        boxStar = Gtk::Box.new(:horizontal)
        boxStar.halign = :end

        labelStar = Gtk::Label.new()

        labelStar.set_markup("<span size='20000' >" + Sauvegardes.getInstance.getSauvegardeScore.nbEtoiles.to_s + "★</span>")
        labelStar.name = "stars"
        boxStar.add(labelStar)

        btnBoxH.add( setmargin( boxStar, 0,0,0,20 ) )

        box.add(btnBoxH)


        #Seperateur
        box.add( Gtk::Separator.new(:vertical) )
        scroll = Gtk::ScrolledWindow.new();

        # Box vertical pour stocker les deux box interne
        vBox = Gtk::Box.new(:vertical)

        # Box qui comprends 3 checkBox et la comboBox
        hBoxSelector = Gtk::Box.new(:horizontal)
        hBoxSelector.set_homogeneous(false)


        comboBox = Gtk::ComboBoxText.new()
        comboBox.prepend_text(@@lg.gt("CONTRELAMONTRE"))
        comboBox.append_text(@@lg.gt("SURVIE"))
        comboBox.wrap_width = 1


        comboBox.set_active(0)
        comboBox.name = "selecClassement"
        comboBox.set_margin_top(5)
        comboBox.set_margin_bottom(5)
        hBoxSelector.add( comboBox)

        s= Gtk::Separator.new(:vertical)
        s.halign = :end
        hBoxSelector.add( s )

        #Gestion du bouton 'facile'
        checkButtonEasy = Gtk::CheckButton.new(@@lg.gt("FACILE"))
        checkButtonEasy.active = @@easyActivated
        checkButtonEasy.name = "selecClassement"
        hBoxSelector.add( checkButtonEasy )

        #Gestion du bouton 'moyen'
        checkButtonMedium = Gtk::CheckButton.new(@@lg.gt("MOYEN"))
        checkButtonMedium.active = @@mediumActivated
        checkButtonMedium.name = "selecClassement"
        hBoxSelector.add( checkButtonMedium )

        #Gestion du bouton 'difficile'
        checkButtonHard = Gtk::CheckButton.new(@@lg.gt("DIFFICILE"))
        checkButtonHard.active = @@hardActivated
        checkButtonHard.name = "selecClassement"
        hBoxSelector.add( checkButtonHard )


        vBox.add( hBoxSelector )

        #Gestion des évènements de la combobox (choix : contre-la-montre ou survie)
        comboBox.signal_connect("changed"){
            if comboBox.active_text == @@lg.gt("CONTRELAMONTRE")
                hBoxSelector.add( s )
                hBoxSelector.add( checkButtonEasy )
                hBoxSelector.add( checkButtonMedium )
                hBoxSelector.add( checkButtonHard )


                #creation interface clm
                scroll.remove( scroll.children[0] )
                scroll.add_with_viewport(ajouterGrille(box))
                Fenetre.show_all
            else
                hBoxSelector.remove( s )
                hBoxSelector.remove( checkButtonEasy )
                hBoxSelector.remove( checkButtonMedium )
                hBoxSelector.remove( checkButtonHard )

                #creation interface survie
                scroll.remove( scroll.children[0] )
                scroll.add_with_viewport(ajouterSurvieInfo(box))
                Fenetre.show_all
            end
        }

        # ScrollView qui contient les grilles
        scroll.set_size_request(200, 648)

        boxGrille = ajouterGrille(box)
        scroll.add_with_viewport( boxGrille )

        #Gestion des evenements des boutons de check (choix des niveaux a afficher)
        checkButtonEasy.signal_connect("clicked") {
            @@easyActivated = !@@easyActivated
            Fenetre.remove(box)
            Fenetre.add(creationInterface( lastView))
            Fenetre.show_all
        }
        checkButtonMedium.signal_connect("clicked") {
            @@mediumActivated = !@@mediumActivated
            Fenetre.remove(box)
            Fenetre.add(creationInterface( lastView ))
            Fenetre.show_all
        }
        checkButtonHard.signal_connect("clicked") {
            @@hardActivated = !@@hardActivated
            Fenetre.remove(box)
            Fenetre.add(creationInterface( lastView))
            Fenetre.show_all
        }
        vBox.add( Gtk::Separator.new(:horizontal) )
        vBox.add( scroll )
        box.add(vBox)#ADD
        return box
    end

    ##
    # Ajoute les informations de records du mode survie à la fenêtre
    def ajouterSurvieInfo(box)

        hBoxSurvie = Gtk::Box.new(:horizontal , 20)
        hBoxSurvie.set_homogeneous(true)

        # gestion de l'affichage des grilles de niveau 'facile'
        vBoxSurvie = Gtk::Box.new(:vertical , 20)
        vBoxSurvie.add(titleLabel( @@lg.gt("FACILE") ))

        score = Sauvegardes.getInstance.getSauvegardeScore.scoresSurvie[0]
        lbFacile = Gtk::Label.new(score == -1 ? @@lg.gt("AUCUN_RECORD") : (score.to_s + " " + (score >= 2 ? @@lg.gt("GRILLES").downcase : @@lg.gt("GRILLE").downcase ) ))
        lbFacile.name = "recordSurvie"
        vBoxSurvie.add( lbFacile )
        hBoxSurvie.add( vBoxSurvie )

        # gestion de l'affichage des grilles de niveau 'moyen'
        vBoxSurvie = Gtk::Box.new(:vertical , 20)
        vBoxSurvie.add(titleLabel( @@lg.gt("MOYEN") ))

        score = Sauvegardes.getInstance.getSauvegardeScore.scoresSurvie[1]
        lbMoyen = Gtk::Label.new(score == -1 ? @@lg.gt("AUCUN_RECORD") : (score.to_s + " " + (score >= 2 ? @@lg.gt("GRILLES").downcase : @@lg.gt("GRILLE").downcase ) ))
        lbMoyen.name = "recordSurvie"
        vBoxSurvie.add(lbMoyen)
        hBoxSurvie.add( vBoxSurvie )

         # gestion de l'affichage des grilles de niveau 'difficile'
        vBoxSurvie = Gtk::Box.new(:vertical , 20)
        vBoxSurvie.add(titleLabel( @@lg.gt("DIFFICILE") ))

        score = Sauvegardes.getInstance.getSauvegardeScore.scoresSurvie[2]
        lbDifficile = Gtk::Label.new(score == -1 ? @@lg.gt("AUCUN_RECORD") : (score.to_s + " " + (score >= 2 ? @@lg.gt("GRILLES").downcase : @@lg.gt("GRILLE").downcase ) ))
        lbDifficile.name = "recordSurvie"
        vBoxSurvie.add(lbDifficile)
        hBoxSurvie.add( vBoxSurvie  )

        setmargin(hBoxSurvie,15,15,0,0  )
    end

    ##
    # Ajoute les grilles dans la fenetre en fonction de l'activation des boutons de niveau actifs
    def ajouterGrille(box)
        vBoxGrille = Gtk::Box.new(:vertical , 20)
        tabPartieEnCours = Sauvegardes.getInstance.getSauvegardePartie.getListPartieLibreEnCours

        # Si le bouton 'facile' est actif => affichage des scores pour les grilles du niveau 'facile'
        if @@easyActivated
            vBoxGrille.add( titleLabel( @@lg.gt("FACILE") )  )
            i = 1
            while ( i <= SauvegardeGrille.getInstance.getNombreGrille / 3 )
                if i == SauvegardeGrille.getInstance.getNombreGrille / 3
                    vBoxGrille.add( generateHbox( generateFrame( SauvegardeGrille.getInstance.getGrilleAt(i) , box ) , nil ) )
                else
                    vBoxGrille.add( generateHbox( generateFrame(SauvegardeGrille.getInstance.getGrilleAt(i) , box ) ,generateFrame(SauvegardeGrille.getInstance.getGrilleAt(i + 1) , box )) )
                    i+=1
                end
                i+=1
            end

            if(@@mediumActivated || @@hardActivated)
                vBoxGrille.add( Gtk::Separator.new(:horizontal) )
            end
        end

        # Si le bouton 'moyen' est actif => affichage des scores pour les grilles du niveau 'moyen'
        if @@mediumActivated
            vBoxGrille.add( titleLabel( @@lg.gt("MOYEN") )  )
            i = 1 + SauvegardeGrille.getInstance.getNombreGrille / 3
            while ( i <= SauvegardeGrille.getInstance.getNombreGrille / 3 * 2 )
                if i == SauvegardeGrille.getInstance.getNombreGrille / 3 * 2
                    vBoxGrille.add( generateHbox( generateFrame( SauvegardeGrille.getInstance.getGrilleAt(i) , box ) , nil ) )
                else
                    vBoxGrille.add( generateHbox( generateFrame(SauvegardeGrille.getInstance.getGrilleAt(i) , box ) ,generateFrame(SauvegardeGrille.getInstance.getGrilleAt(i + 1) , box )) )
                    i+=1
                end
                i+=1
            end

            if(@@hardActivated)
                vBoxGrille.add( Gtk::Separator.new(:horizontal) )
            end
        end

        # Si le bouton 'difficile' est actif => affichage des scores pour les grilles du niveau 'difficile'
        if @@hardActivated
            vBoxGrille.add( titleLabel( @@lg.gt("DIFFICILE") )  )
            i = 1 + SauvegardeGrille.getInstance.getNombreGrille / 3 * 2
            while ( i <= SauvegardeGrille.getInstance.getNombreGrille  )
                if i == SauvegardeGrille.getInstance.getNombreGrille
                    vBoxGrille.add( generateHbox( generateFrame( SauvegardeGrille.getInstance.getGrilleAt(i) , box ) , nil ) )
                else
                    vBoxGrille.add( generateHbox( generateFrame(SauvegardeGrille.getInstance.getGrilleAt(i) , box ) ,generateFrame(SauvegardeGrille.getInstance.getGrilleAt(i + 1) , box)) )
                    i+=1
                end
                i+=1
            end
        end
        setmargin(vBoxGrille,15,15,0,0  )

        return vBoxGrille
    end

    ##
    # Change la taille d'un label en format titre
    def titleLabel(unLabel)
        label = Gtk::Label.new()
        label.set_markup("<span size='25000' >" + unLabel.to_s + "</span>")
        return label
    end

    ##
    # Crée une box horizontal qui contient les deux grilles de la ligne
    private
    def generateHbox( grille1, grille2)
        hBox = Gtk::Box.new(:horizontal,15)
        hBox.set_height_request(200)
        hBox.add( grille1 )
        if grille2 != nil
            hBox.add( grille2 )
            hBox.set_homogeneous(true)
        end
        setmargin(hBox,0,0,15,15)
        return hBox
    end

    ##
    # Genère une frame qui contient les scores, les étoiles et la grille
    def generateFrame( uneGrille , mainBox )
        btnFrame = Gtk::Button.new()
        btnFrame.name = "bg-FenetreSelection"

        box = Gtk::Box.new(:vertical)

        vBoxTite = Gtk::Box.new(:horizontal)
        vBoxTite.set_homogeneous(true)

        title = Gtk::Label.new()
        title.set_markup("<span size='25000' >#" + uneGrille.numero.to_s + "</span>")

        title.name = "bg-FenetreSelection-title"
        title.halign = :start


        #Affichage des étoiles
        stars = Gtk::Label.new()
        starTxt = ""
        for i in 0..2
            if(i<Sauvegardes.getInstance.getSauvegardeScore.scoresContreLaMontre[uneGrille.numero][1])
                    starTxt += "★"
            else
                starTxt += "☆"
            end
        end
        stars.set_markup("<span size='25000' >" + starTxt + "</span>")

        stars.name = "stars"
        stars.halign = :end


        vBoxTite.add(title)
        vBoxTite.add(stars)

        setmargin(vBoxTite,5,5,0,0)
        box.add(vBoxTite)
        box.add(  setmargin( creeGrille( uneGrille) , 0 , 5 , 0 , 0 ) )

        btnFrame.add( box )#ADD

        #Evènements
        btnFrame.signal_connect("clicked") {
            Fenetre.remove(mainBox);
            indice = Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieLibreSauvegarder(uneGrille.numero)
            FenetreDetailScore.afficheToiSelec( FenetreClassement , uneGrille.numero)
        }
        tps = Sauvegardes.getInstance.getSauvegardeScore.scoresContreLaMontre[uneGrille.numero][0]
        textTps = Gtk::Label.new(tps == -1 ? @@lg.gt("AUCUN_RECORD") : Chrono.getTpsFormat(tps))
        textTps.name = "timer-clasement"
        textTps.halign = :center
        setmargin(textTps,5,5,0,0)
        box.add(textTps)
        return btnFrame
    end

    ##
    #Crée une grille pour l'affichage de son score
    def creeGrille( uneGrille )
        #Frame exterieur pour que les rebord et la meme epaisseur
        maFrame = Gtk::Frame.new()
        maFrame.name = "fenetreGrille"
        #Grid pour placer la grille de jeu dedans
        maGrille = Gtk::Grid.new()
        maGrille.set_height_request(300);   maGrille.set_width_request(300)
        maGrille.set_row_homogeneous(true);     maGrille.set_column_homogeneous(true)

        maGrilleDeJeu = uneGrille.tabCases
        #Boucle pour créer chaque cellule
        for ligne in 0...maGrilleDeJeu.size
            for colonne in 0...maGrilleDeJeu.size
                cell =  creeCelluleGrille(maGrilleDeJeu[colonne][ligne].couleur )
                maGrille.attach( cell , ligne,colonne,1,1)
            end
        end

        #Ajout de la grille a la frame
        maFrame.add(maGrille)


        return maFrame
    end

    ##
    # Crée une cellule destinée à la grille
    private
    def creeCelluleGrille(color)
        if color <= 0
            color = ""
        elsif color >= 10
            color = "+"
        end
        btn = Gtk::Label.new(color.to_s)
        btn.name = "little"
        return btn
    end

    ##
    # Met des marges à un objet
    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end

end
