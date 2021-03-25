require "./Fenetre.rb"

# TAMPORAIRE EN ATTENDANT LA CLASS CELL
## TAMPORAIRE EN ATTENDANT LA CLASS CELL
### TAMPORAIRE EN ATTENDANT LA CLASS CELL
#### TAMPORAIRE EN ATTENDANT LA CLASS CELL
class Cell < Gtk::Button
    attr_reader :x, :y

    def set_x(x)
        @x = x
    end

    def set_y(y)
        @y = y
    end

    def changeStatut()

        #INIT
        if( @saveLabel == nil)
            @saveLabel = self.children.at(0).label
        end

        if self.name == "grid-cell"
            self.name = "grid-cell-block"
        elsif self.name == "grid-cell-block"
             self.name = "grid-cell-round"
             self.children.at(0).label = "●"
        else 
            self.children.at(0).label = @saveLabel
            self.children.at(0).label = @saveLabel
            self.name = "grid-cell"
        end
    end

    def resetCell()
        self.name = "grid-cell"
        if ( @saveLabel != nil )
            self.children.at(0).label = @saveLabel
        end
    end

end




# Classe qui gere la fenetre 'A propos'
class FenetrePartie < Fenetre

    def initialize() 
        self
    end

    def self.afficheToi( lastView )
        Fenetre.set_subtitle("Partie")
        Fenetre.add( FenetrePartie.new().creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end

    def creationInterface( lastView )

        box = Gtk::Box.new(:vertical)
       
        #TOOLBAR
        box.add(creeToolbar)#ADD

        ## Nom de la grille
        nomGrille = Gtk::Label.new()
        nomGrille.set_markup("<span size='30000' > Grille #</span>")
        nomGrille.set_margin_top(15)
        nomGrille.set_margin_bottom(15)
        box.add(nomGrille)#ADD

        #GRILLE
        box.add(creeGrille)#ADD

        return box
    end

    # Methode qui permet de cree
    # la toolbar
    private
    def creeToolbar()
        # BOX HORIZONTAL
        mainToolbar = Gtk::Box.new(:vertical, 0)
        
        box = Gtk::Box.new(:horizontal, 0)
        box.set_height_request(50)

        # creation des boutons de mode de jeu
        btnNewFile = creeBouttonToolbar("document-new");   btnSave = creeBouttonToolbar("document-save")
        btnSetting = creeBouttonToolbar("document-properties")
        btnUndo = creeBouttonToolbar("undo");              btnRedo = creeBouttonToolbar("redo")
        btnPlay = creeBouttonToolbar("player_play");       btnPause = creeBouttonToolbar("player_pause")
        btnHelp = creeBouttonToolbar("hint");              btnInfo = creeBouttonToolbar("help-contents")
        btnClear = creeBouttonToolbar("gtk-clear");        btnVerif = creeBouttonToolbar("gtk-apply")
        btnQuit = creeBouttonToolbar("gtk-quit")
        
        #Gestion des evenemeents
        btnNewFile.signal_connect("clicked"){puts "click NewFile"}
        btnSave.signal_connect("clicked")   {puts "click Save"}
        btnSetting.signal_connect("clicked"){ Fenetre.deleteChildren; FenetreParametre.afficheToi( FenetrePartie )  }
        btnUndo.signal_connect("clicked")   {puts "click Undo"}
        btnRedo.signal_connect("clicked")   {puts "click Redo"}
        btnPlay.signal_connect("clicked")   {puts "click Play"}
        btnPause.signal_connect("clicked")  {puts "click Pause"}
        btnHelp.signal_connect("clicked")   { puts "click Help"}
        btnInfo.signal_connect("clicked")   { puts "click Info" }
        btnClear.signal_connect("clicked")  { 
            puts "click Clear"
            tab = @gameGrid.children
            for i in 0...tab.length
                tab.at(i).resetCell
            end
        }
        btnVerif.signal_connect("clicked")  {puts "click Verif"}
        btnQuit.signal_connect("clicked")   { Fenetre.deleteChildren; FenetreMenu.afficheToi( FenetrePartie ) }

  
        # attachement des boutons de mode de jeu
        box.add(btnNewFile);    box.add(btnSave)
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(btnSetting);    box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(btnUndo);       box.add(btnRedo)
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(btnPlay);       box.add(btnPause)
        box.add(btnHelp);       box.add(btnInfo)
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(btnClear);      box.add(btnVerif)
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(btnQuit)

        mainToolbar.add(box)
        mainToolbar.add( Gtk::Separator.new(:horizontal) )
        return mainToolbar
    end

       # Methode qui permet de cree
    # une cellule destiner a la grille
    def creeCelluleGrille(line,colonne)
        btn = Cell.new(:label => line.to_s)
        btn.name = "grid-cell"
        btn.set_x(line);btn.set_y(colonne)
        btn.set_height_request(5)
        btn.set_width_request(5)

        btn.signal_connect "clicked" do |handler| 
            puts "BTN CLICKED {X:#{handler.x};Y:#{handler.y}}"
            handler.changeStatut
        end
        return btn
    end
    private :creeCelluleGrille

    ## METHODE QUI CREE UNE GRILLE
    def creeGrille()
        tmpGrilleSize = 10

        # Frame exterieur pour que les rebord et la meme epaisseur
        maFrame = Gtk::Frame.new()
        maFrame.set_margin_left(70); maFrame.set_margin_right(70); maFrame.set_margin_top(30)
        
        # grid pour placer la grille de jeu dedans
        maGrille = Gtk::Grid.new()
        maGrille.name = "grid"
        maGrille.set_height_request(671-140);   maGrille.set_width_request(671-140)
        maGrille.set_row_homogeneous(true);     maGrille.set_column_homogeneous(true)

        # A MODIFIER
        # boucle pour cree la fenetre de jeu
        for ligne in 0..tmpGrilleSize
            for colonne in 0..tmpGrilleSize
                maGrille.attach( creeCelluleGrille(ligne,colonne) , ligne,colonne,1,1)
            end
        end
        
        # ajout de la grille a la frame
        maFrame.add(maGrille)
        @gameGrid = maGrille
        return maFrame
    end

    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return nil
    end

    #Methode qui permet de cree un bouton 
    #qui sera dans la toolbar
    private
    def creeBouttonToolbar(iconName)
        btn = Gtk::Button.new()
        image = Gtk::Image.new(:icon_name => iconName, :size => :LARGE_TOOLBAR) 
        btn.add(image) 
        btn.set_margin_left(5); btn.set_margin_right(5);
        btn.name = "btn-toolbar" # BTN STYLE
        return btn
    end

    #Methode qui permet de cree un separateur 
    #qui sera dans la toolbar
    private
    def creerSeparatorToolbar()
        monSeparateur = Gtk::Separator.new(:horizontal)
        monSeparateur.set_margin_left(5);monSeparateur.set_margin_right(5);monSeparateur.set_margin_top(10);monSeparateur.set_margin_bottom(10)
        return monSeparateur
    end

end


=begin

# Classe qui gere la fenetre pendant la partie
class FenetrePartie < Fenetre

    # Methode qui permet de mettre a jour le chrono
    def rafraichirTemps()   
        
    end

    # Methode qui permet de mettre a jour l'affichage d'une case donnee
    def changerEtatCase()
        #
    end

    
    # Methode ..................
    def listenerBoutonCase()
        #
    end

    # Methode pour revenir en arriere (coup precedent)
    def listenerBoutonPrecedent()
        #
    end

    # Methode pour revenir au coup suivant (apres un retour en arriere, un coup suivant est sauvegarde)
    def listenerBoutonSuivant()
        #
    end

    # Methode qui permet de remettre a zero la grille
    def listenerBoutonRemiseAZero()
        #
    end

    # Methode qui permet de mettre en pause la partie
    def listenerBoutonPause()
        #
    end

    # Methode qui permet de quitter la partie
    def listenerQuitterPartie()
        #
    end

    # Methode qui permet de fermer la fenetre de jeu
    def listenerQuitter()
        @application.signal_connect('destroy'){
            Gtk.main_quit()
        }
    end
end


##################### CODE DE TEST DE LA CLASSE #####################

fenetrePartie= FenetrePartie.creer("Nurikabe")
fenetrePartie.creer()



Gtk.main

=end