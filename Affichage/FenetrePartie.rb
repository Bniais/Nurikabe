load "Fenetre.rb"

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

       
        provider = Gtk::CssProvider.new
        provider.load(path: "style.css")
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,provider, Gtk::StyleProvider::PRIORITY_APPLICATION)

         # creation de la box principale
         @mainBox = Gtk::Box.new(:vertical, 10)

         # ajout des 3 vues à la fenêtre
         @mainBox.pack_start(@viewOne, :expand => false, :fill => true)

         # quitter quand la fenetre est detruite
          @application.signal_connect("destroy") { detruire() }

          @application.add(@mainBox)
          self.ouvrir()

    end

    # Methode qui permet d'initialiser la grille de la fenetre
    def initialize(title)
        super(title)
        @viewOne = creerBarreOutil()
    end


    #Creation de bouttons 
    def creerBoutonBarreOutil(iconName)
        btn = Gtk::Button.new()
        image = Gtk::Image.new(:icon_name => iconName, :size => :LARGE_TOOLBAR)
        btn.add(image)
        btn.set_margin_left(5)
        btn.set_margin_right(5)
        btn.name = "btntoolbar"
        return btn
    end

    def creerSeparateurBarreOutil()
        monSeparateur = Gtk::Separator.new(:horizontal)
        monSeparateur.set_margin_left(5)
        monSeparateur.set_margin_right(5)
        monSeparateur.set_margin_top(10)
        monSeparateur.set_margin_bottom(10)
        return monSeparateur
    end


    def creerBarreOutil()
        # BOX HORIZONTAL
        mainBox = Gtk::Box.new(:vertical, 0)
        
        box = Gtk::Box.new(:horizontal, 0)
        box.set_height_request(50)

        # creation des boutons de mode de jeu
        btnNewFile = creerBoutonBarreOutil("document-new")
        btnSave = creerBoutonBarreOutil("document-save")
        btnPrint = creerBoutonBarreOutil("document-print")
        btnSetting = creerBoutonBarreOutil("document-properties")
        btnUndo = creerBoutonBarreOutil("undo")
        btnRedo = creerBoutonBarreOutil("redo")
        btnPlay = creerBoutonBarreOutil("player_play")
        btnPause = creerBoutonBarreOutil("player_pause")
        btnHelp = creerBoutonBarreOutil("hint")
        btnInfo = creerBoutonBarreOutil("help-contents")
        btnClear = creerBoutonBarreOutil("gtk-clear")
        btnVerif = creerBoutonBarreOutil("gtk-apply")
        btnQuit = creerBoutonBarreOutil("gtk-quit")

        
        #Gestion des evenemeents
        btnNewFile.signal_connect("clicked") do
            puts "click NewFile"
        end
        btnSave.signal_connect("clicked") do
            puts "click Save"
        end
        btnPrint.signal_connect("clicked") do
            puts "click Print"
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
        end
        btnVerif.signal_connect("clicked") do
            puts "click Verif"
        end
        btnQuit.signal_connect("clicked") do
            puts "click Quit"
        end



  
        # attachement des boutons de mode de jeu
        box.add(btnNewFile)
        box.add(btnSave)
        box.add(btnPrint)
        box.add(creerSeparateurBarreOutil)  # SEPARATOR
        box.add(btnSetting)
        box.add(creerSeparateurBarreOutil)  # SEPARATOR
        box.add(btnUndo)
        box.add(btnRedo)
        box.add(creerSeparateurBarreOutil)  # SEPARATOR
        box.add(btnPlay)
        box.add(btnPause)
        box.add(btnHelp)
        box.add(btnInfo)
        box.add(creerSeparateurBarreOutil)  # SEPARATOR
        box.add(btnClear)
        box.add(btnVerif)
        box.add(creerSeparateurBarreOutil)  # SEPARATOR
        box.add(btnQuit)

        mainBox.add(box)
        mainBox.add( Gtk::Separator.new(:horizontal) )
        mainBox.add(creerNomGrille)
        mainBox.add(creerGrille)
        return mainBox
    end

    def creerNomGrille()
        nomGrille = Gtk::Label.new()
        nomGrille.set_markup("<span size='30000' > Grille #</span>")
        nomGrille.set_margin_top(15)
        nomGrille.set_margin_bottom(15)
    end



    def creerGrille()
        
        
        maGrille = Gtk::Grid.new()
        maGrille.set_height_request(671-140)
        maGrille.set_width_request(671-140)
        maGrille.set_row_homogeneous(true)
        maGrille.set_column_homogeneous(true)

        maGrille.set_margin_left(70)
        maGrille.set_margin_right(70)



        for ligne in 0..10
            for colonne in 0..10
                maGrille.attach( creerBouttonGrille(ligne,colonne) , ligne,colonne,1,1)
            end
        end
        
        puts @application.size
        return maGrille
    end

    def creerBouttonGrille(line,colonne)
        btn = Gtk::Button.new(:label => line.to_s)

        btn.name = "grid-cell"

        if line == 0 && colonne == 0
            btn.name = "grid-cell-left grid-cell-top"
        elsif line == 0 && colonne == 10
            btn.name = "grid-cell-right grid-cell-bottom"
        elsif line == 0
            btn.name = "grid-cell-left"
        elsif line == 10
            btn.name = "grid-cell-right"   
        elsif colonne == 0 
            btn.name = "grid-cell-top"
        elsif colonne == 10
            btn.name = "grid-cell-bottom"
        end

        return btn
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