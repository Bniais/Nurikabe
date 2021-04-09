require './Fenetre.rb'
require './FenetreDetailScore.rb'

##
# Classe qui gere l'affichage de la fenetre 'Classement'
#
# Herite de la classe abstraite Fenetre
class FenetreClassement < Fenetre
    @@easyActivated = true
    @@mediumActivated = true
    @@hardActivated = true


    ##
    # Methode privee pour l'initialisation
    def initialize()
        self
    end

    ##
    # Methode qui permet a la fenetre du classement de s'afficher
    def self.afficheToi( lastView )
        Fenetre.set_subtitle(@@lg.gt("CLASSEMENT"))
        Fenetre.add( FenetreClassement.new().creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end


    ##
    # Methode qui permet de creer l'interface :
    # * gestion de l'affichage des boutons, combobox
    # * gestion de l'affichage des grilles
    def creationInterface( lastView )

        box = Gtk::Box.new(:vertical)

        # BACK BUTTON

        btnBoxH = Gtk::ButtonBox.new(:horizontal)
        btnBoxH.layout = :start
        btnBack = Gtk::Button.new(:label => @@lg.gt("RETOUR"))
        btnBack.name = "btnBack"
        btnBack.signal_connect("clicked") { Fenetre.remove(box) ; lastView.afficheToi( nil ) ; }
        lastView == nil ? btnBack.set_sensitive(false) : btnBack.set_sensitive(true)
        setmargin(btnBack,5,5,5,0)
        btnBoxH.add(btnBack)
        box.add(btnBoxH) #ADD

        # SEPARATOR
        box.add( Gtk::Separator.new(:vertical) ) #ADD
        scroll = Gtk::ScrolledWindow.new();

        # VUE PRINCIPAL
        # EDIT HERE
        # ADD CONTENT HERE IN BOX

        # Box vertical pour stocker les deux box interne
        vBox = Gtk::Box.new(:vertical)

        # Box qui comprends 3 radios selector
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

        # gestion du bouton 'facile'
        checkButtonEasy = Gtk::CheckButton.new(@@lg.gt("FACILE"))
        checkButtonEasy.active = @@easyActivated
        checkButtonEasy.name = "selecClassement"
        hBoxSelector.add( checkButtonEasy )

        # gestion du bouton 'moyen'
        checkButtonMedium = Gtk::CheckButton.new(@@lg.gt("MOYEN"))
        checkButtonMedium.active = @@mediumActivated
        checkButtonMedium.name = "selecClassement"
        hBoxSelector.add( checkButtonMedium )

        # gestion du bouton 'difficile'
        checkButtonHard = Gtk::CheckButton.new(@@lg.gt("DIFFICILE"))
        checkButtonHard.active = @@hardActivated
        checkButtonHard.name = "selecClassement"
        hBoxSelector.add( checkButtonHard )


        vBox.add( hBoxSelector )

        # gestion des evenements de la combobox (choix : contre-la-montre ou survie)
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
        # ScrollView qui comprends les grilles

        scroll.set_size_request(200, 658)

        boxGrille = ajouterGrille(box)
        scroll.add_with_viewport( boxGrille )

        # gestion des evenements des boutons de check (choix des niveaux a afficher)
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
    # Methode qui permet de gerer l'affichage pour le classement du mode 'survies'
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
    # Methode qui permet d'ajouter les grilles dans la fenetre
    # en fonction de l'activation des boutons de niveau actifs
    def ajouterGrille(box)
        vBoxGrille = Gtk::Box.new(:vertical , 20)

        puts " nb : #{SauvegardeGrille.getInstance.getNombreGrille}"
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
    # Methode qui permet de changer la taille d'un label
    def titleLabel(unLabel)
        label = Gtk::Label.new()
        label.set_markup("<span size='25000' >" + unLabel.to_s + "</span>")
        return label
    end

    ##
    # Methode qui permet de creer une box horizontal
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
    # Methode qui permet de gerer l'affichage d'une grille
    def generateFrame( uneGrille , mainBox )
        puts uneGrille.numero
        btnFrame = Gtk::Button.new()
        btnFrame.name = "bg-FenetreSelection"

        box = Gtk::Box.new(:vertical)

        vBoxTite = Gtk::Box.new(:horizontal)
        vBoxTite.set_homogeneous(true)

        title = Gtk::Label.new()
        title.set_markup("<span size='25000' >#" + uneGrille.numero.to_s + "</span>")

        title.name = "bg-FenetreSelection-title"
        title.halign = :start


        # gestion de l'affichage des étoiles
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

        # gestion des evenements
        btnFrame.signal_connect("clicked") {
            Fenetre.remove(mainBox);
            indice = Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieLibreSauvegarder(uneGrille.numero)
            puts indice
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
    # Methode qui permet de creer un bouton avec un icone
    private
    def generateBtnWithIcon(iconName)
        btn = Gtk::Button.new()
        image = Gtk::Image.new(:icon_name => iconName, :size => :LARGE_TOOLBAR)
        btn.add(image)
        return btn
    end

    ##
    # Methode qui creer une grille
    def creeGrille( uneGrille )
        # Frame exterieur pour que les rebord et la meme epaisseur
        maFrame = Gtk::Frame.new()
        maFrame.name = "fenetreGrille"
        # grid pour placer la grille de jeu dedans
        maGrille = Gtk::Grid.new()
        maGrille.set_height_request(300);   maGrille.set_width_request(300)
        maGrille.set_row_homogeneous(true);     maGrille.set_column_homogeneous(true)

        maGrilleDeJeu = uneGrille.tabCases
        # boucle pour cree la fenetre de jeu
        for ligne in 0...maGrilleDeJeu.size
            for colonne in 0...maGrilleDeJeu.size
                cell =  creeCelluleGrille(maGrilleDeJeu[colonne][ligne].couleur )
                maGrille.attach( cell , ligne,colonne,1,1)
            end
        end

        # ajout de la grille a la frame
        maFrame.add(maGrille)


        return maFrame
    end

    ##
    # Methode qui permet de creer une cellule destinee a la grille
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
    # Methode qui permet de gerer les marges d'un objet
    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end

end
