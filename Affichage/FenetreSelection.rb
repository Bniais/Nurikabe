require './Fenetre.rb'


# Classe qui gere la fenetre 'A propos'
class FenetreSelection < Fenetre

    def initialize() 
        self
    end

    def self.afficheToi( lastView )
        @@uneGrilleTMP = Grille.creer(10,
                [
                    [Case.creer(Couleur::BLANC, 0, 0) ,Case.creer(Couleur::ILE_4, 1, 0),Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::ILE_5, 3, 0), Case.creer(Couleur::BLANC, 4, 0)],
                    [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1), Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::BLANC, 4, 1)],
                    [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::ILE_1, 2, 2), Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::BLANC, 4, 2)],
                    [Case.creer(Couleur::ILE_4, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::BLANC, 4, 3)],
                    [Case.creer(Couleur::BLANC, 0, 4), Case.creer(Couleur::BLANC, 1, 4), Case.creer(Couleur::BLANC, 2, 4), Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4)]
                ])
         

        Fenetre.set_subtitle(@@lg.gt("SELECTION_MODE_LIBRE"))
        Fenetre.add( FenetreSelection.new().creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end

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

        # VUE PRINCIPAL
        # EDIT HERE
        # ADD CONTENT HERE IN BOX
        scroll = Gtk::ScrolledWindow.new();
        scroll.set_size_request(200, 700)

        vBox = Gtk::Box.new(:vertical , 20)

        vBox.add( generateHbox( generateFrame(@@uneGrilleTMP , box) ,generateFrame(@@uneGrilleTMP , box )) )
        vBox.add( generateHbox( generateFrame(@@uneGrilleTMP , box) ,nil) )

        setmargin(vBox,15,15,0,0  )
        scroll.add_with_viewport( vBox )


        box.add(scroll)#ADD
        return box
    end

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


    def generateFrame( uneGrille , mainBox )
        btnFrame = Gtk::Button.new()
        btnFrame.name = "bg-FenetreSelection"
        
        box = Gtk::Box.new(:vertical)
        
        title = Gtk::Label.new()
        title.set_markup("<span size='25000' >#" + uneGrille.numero.to_s + "</span>")
        title.name = "bg-FenetreSelection-title"
        title.halign = :start
        setmargin(title,5,5,0,0)
        box.add(title)

       
        box.add(  setmargin( creeGrille( uneGrille) , 0 , 5 , 0 , 0 ) )
  
        btnFrame.add( box )#ADD

        btnFrame.signal_connect("clicked") { Fenetre.remove(mainBox); FenetrePartie.afficheToi( FenetreSelection ) }

        return btnFrame
    end

    private
    def generateBtnWithIcon(iconName)
        btn = Gtk::Button.new()
        image = Gtk::Image.new(:icon_name => iconName, :size => :LARGE_TOOLBAR)
        btn.add(image)
        return btn
    end

    ## METHODE QUI CREE UNE GRILLE
    def creeGrille( uneGrille )
        # Frame exterieur pour que les rebord et la meme epaisseur
        maFrame = Gtk::Frame.new()
        # grid pour placer la grille de jeu dedans
        maGrille = Gtk::Grid.new()
        maGrille.set_height_request(300);   maGrille.set_width_request(300)
        maGrille.set_row_homogeneous(true);     maGrille.set_column_homogeneous(true)

        maGrilleDeJeu = uneGrille.tabCases
   #     # boucle pour cree la fenetre de jeu
        for ligne in 0...maGrilleDeJeu.size
            for colonne in 0...maGrilleDeJeu.size
                cell =  creeCelluleGrille(maGrilleDeJeu[colonne][ligne].couleur )
                maGrille.attach( cell , ligne,colonne,1,1)
            end
        end
    
  #      # ajout de la grille a la frame
        maFrame.add(maGrille)
           
    
        return maFrame
    end

        # Methode qui permet de cree
    # une cellule destiner a la grille
    private
    def creeCelluleGrille(color)
        if color <= 0 
            color = ""
        elsif color >= 10
            color = "+"
        end 
        btn = Gtk::Button.new(:label => color.to_s)
        btn.name = "little"
        return btn
    end

    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end

end

