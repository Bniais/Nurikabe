load "Fenetre.rb"

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

# Classe qui gere la fenetre pendant la partie
class FenetrePartie < Fenetre

    
    # grille de la partie actuelle
    attr_accessor :grille
    # ensembles des sons (effets sonores) de la partie
    attr_accessor :son
    # parametres personnalises par l'utilisateur
    attr_accessor :parametre


    # Methode qui permet de creer une nouvelle partie
    def creer()
         # creation de la frame principale
         @mainFrame = Gtk::Box.new(:vertical)

         # ajout des elements
         @gameGrid = nil
         @mainFrame.add(creeToolbar)
         @mainFrame.add(creeNomGrille)
         @mainFrame.add(creeGrille)
         
         # ajout de l'element a la fenetre
         @application.add(@mainFrame)
         self.ouvrir()
    end




    # Methode qui permet d'initialiser la grille de la fenetre
    def initialize(title)
        super(title)
    end





    #Methode qui permet de cree un bouton 
    #qui sera dans la toolbar
    def creeBouttonToolbar(iconName)
        btn = Gtk::Button.new()
        image = Gtk::Image.new(:icon_name => iconName, :size => :LARGE_TOOLBAR) 
        btn.add(image) 
        btn.set_margin_left(5); btn.set_margin_right(5);
        btn.name = "btn-toolbar" # BTN STYLE
        return btn
    end
    private :creeBouttonToolbar





    #Methode qui permet de cree un separateur 
    #qui sera dans la toolbar
    def creerSeparatorToolbar()
        monSeparateur = Gtk::Separator.new(:horizontal)
        monSeparateur.set_margin_left(5);monSeparateur.set_margin_right(5);monSeparateur.set_margin_top(10);monSeparateur.set_margin_bottom(10)
        return monSeparateur
    end
    private :creerSeparatorToolbar





    # Methode qui permet de cree
    # la toolbar
    def creeToolbar()
        # BOX HORIZONTAL
        mainToolbar = Gtk::Box.new(:vertical, 0)
        
        box = Gtk::Box.new(:horizontal, 0)
        box.set_height_request(50)

        # creation des boutons de mode de jeu
        btnNewFile = creeBouttonToolbar("document-new");   btnSave = creeBouttonToolbar("document-save")
        btnPrint = creeBouttonToolbar("document-print");   btnSetting = creeBouttonToolbar("document-properties")
        btnUndo = creeBouttonToolbar("undo");              btnRedo = creeBouttonToolbar("redo")
        btnPlay = creeBouttonToolbar("player_play");       btnPause = creeBouttonToolbar("player_pause")
        btnHelp = creeBouttonToolbar("hint");              btnInfo = creeBouttonToolbar("help-contents")
        btnClear = creeBouttonToolbar("gtk-clear");        btnVerif = creeBouttonToolbar("gtk-apply")
        btnQuit = creeBouttonToolbar("gtk-quit")
        
        #Gestion des evenemeents
        btnNewFile.signal_connect("clicked") do
            puts "click NewFile"
        end
        btnSave.signal_connect("clicked") do
            puts "click Save"
        end

        btnPrint.signal_connect("clicked") do
            puts "click Print"
            # DARK MODE
            if @count == nil
                @count = 0
            end
            @count = @count + 1;
            provider = Gtk::CssProvider.new
            if( @count%2 != 0 )
                provider.load(path: "style_dark.css")
            else 
                provider.load(path: "style.css")   
            end
            Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
        end

        btnSetting.signal_connect("clicked") do
            puts "click Setting"
        end

        btnUndo.signal_connect("clicked") do
            puts "click Undo"
        end

        btnRedo.signal_connect("clicked") do
            puts "click Redo"
        end

        btnPlay.signal_connect("clicked") do
            puts "click Play"
        end

        btnPause.signal_connect("clicked") do
            puts "click Pause"
        end

        btnHelp.signal_connect("clicked") do
            puts "click Help"
        end

        btnInfo.signal_connect("clicked") do
            puts "click Info"
        end

        btnClear.signal_connect("clicked") do
            puts "click Clear"
            tab = @gameGrid.children
            for i in 0...tab.length
                tab.at(i).resetCell
            end
        end

        btnVerif.signal_connect("clicked") do
            puts "click Verif"
        end

        btnQuit.signal_connect("clicked") do
            puts "click Quit"
            Gtk.main_quit
        end

  
        # attachement des boutons de mode de jeu
        box.add(btnNewFile);    box.add(btnSave)
        box.add(btnPrint);      box.add(creerSeparatorToolbar)  # SEPARATOR
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
    
    
    
    
    # Methode qui permet de cree le
    # nom de la grille
    def creeNomGrille()
        nomGrille = Gtk::Label.new()
        nomGrille.set_markup("<span size='30000' > Grille #</span>")
        nomGrille.set_margin_top(15)
        nomGrille.set_margin_bottom(15)
        return nomGrille
    end
    private :creeNomGrille
    
    
    
    
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