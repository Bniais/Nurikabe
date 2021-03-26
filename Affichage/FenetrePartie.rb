require "./Fenetre.rb"
require "./../Partie/Partie.rb"

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

    def changerStatut(color)
        if color >= Couleur::ILE_1
            self.name = "grid-cell"
            self.set_label(color.to_s)
        elsif color == Couleur::NOIR
            self.name = "grid-cell-block"
        elsif color == Couleur::GRIS
            self.set_label("")
            self.name = "grid-cell"
        elsif color == Couleur::BLANC
            self.name = "grid-cell-round"
            self.set_label("●")
        end
    end

    def resetCell()
        self.name = "grid-cell"
        if self.label == "●"
            self.set_label("")
        end

    end

end




# Classe qui gere la fenetre 'A propos'
class FenetrePartie < Fenetre

    @@maPartie = nil
    @@maGrille = nil

    def initialize() 
        self
    end

    def self.afficheToi( lastView )
        if @@maPartie == nil
            @@maPartie = Partie.creer(Grille.creer(4, [[Case.creer(Couleur::BLANC, 0, 0) ,Case.creer(Couleur::ILE_6, 1, 0),Case.creer(Couleur::BLANC, 2, 0),Case.creer(Couleur::BLANC, 3, 0)],[Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::GRIS, 2, 1), Case.creer(Couleur::GRIS, 3, 1)], [Case.creer(Couleur::GRIS, 0, 2), Case.creer(Couleur::GRIS, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2)],[Case.creer(Couleur::GRIS, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::ILE_4, 3, 3)]]), nil, nil)
            @@maGrille = Array.new(@@maPartie.grilleEnCours.tabCases.size) {Array.new(@@maPartie.grilleEnCours.tabCases.size,false)}
        end
        Fenetre.set_subtitle( @@maPartie.class.to_s )
        maFenetrePartie = FenetrePartie.new()
        Fenetre.add( maFenetrePartie.creationInterface( lastView ) )
        Fenetre.show_all

        maFenetrePartie.threadChronometre
        
        return self
    end

    def threadChronometre
        Thread.new do
            while 1
                sleep(0.5)
                @monTimer.set_markup("<span size='25000' >" + @@maPartie.chrono.getTemps + "</span>")
            end
        end
    end

    def creationInterface( lastView )
        puts @@maPartie
        box = Gtk::Box.new(:vertical)
       
        #TOOLBAR
        box.add(creeToolbar)#ADD

        ## Nom de la grille
        nomGrille = Gtk::Label.new()
        nomGrille.set_markup("<span size='25000' > Grille #" + @@maPartie.grilleBase.numero.to_s + "</span>")
        nomGrille.set_margin_top(20)
        nomGrille.set_margin_bottom(10)
        box.add(nomGrille)#ADD

        #GRILLE
        box.add(creeGrille)#ADD

        #TIMER
        @monTimer = Gtk::Label.new()
        setmargin(@monTimer,20,0,300,300)
        @monTimer.name = "timer"
        @monTimer.set_markup("<span size='25000' >00:00</span>")
        box.add( @monTimer )

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
        btnNewGame = creeBouttonToolbar("add");            btnSetting = creeBouttonToolbar("document-properties")
        btnUndo = creeBouttonToolbar("undo");              btnRedo = creeBouttonToolbar("redo")
        btnPlay = creeBouttonToolbar("player_play");       btnPause = creeBouttonToolbar("player_pause")
        btnHelp = creeBouttonToolbar("hint");              btnInfo = creeBouttonToolbar("help-contents")
        btnClear = creeBouttonToolbar("gtk-clear");        btnVerif = creeBouttonToolbar("gtk-apply")
        btnQuit = creeBouttonToolbar("gtk-quit")
        
        #Gestion des evenemeents
        btnNewGame.signal_connect("clicked"){puts "click NewFile"}
        btnSetting.signal_connect("clicked"){ Fenetre.deleteChildren; FenetreParametre.afficheToi( FenetrePartie )  }
        btnUndo.signal_connect("clicked")   {
            @@maPartie.retourArriere
            @@maPartie.grilleEnCours.afficher
            for i in 0...@@maGrille.size
                for j in 0...@@maGrille[i].size
                    @@maGrille[i][j].changerStatut( @@maPartie.grilleEnCours.tabCases[i][j].couleur )
                end
            end
        }
        btnRedo.signal_connect("clicked")   {
            @@maPartie.retourAvant
            for i in 0...@@maGrille.size
                for j in 0...@@maGrille[i].size
                    @@maGrille[i][j].changerStatut( @@maPartie.grilleEnCours.tabCases[i][j].couleur )
                end
            end
        }
        btnPlay.signal_connect("clicked")   { @@maPartie.reprendrePartie}
        btnPause.signal_connect("clicked")  { @@maPartie.mettrePause }

        btnHelp.signal_connect("clicked")   { 
            indice = @@maPartie.donneIndice
            if ( indice != nil)
                puts [Indice::MESSAGES[indice[0]],indice[1]] #fait une erreur si pas d'indice trouvé
            else    
                puts "PAS D: INDICE"
            end
        }
        btnInfo.signal_connect("clicked")   { puts "click Info" }
        btnClear.signal_connect("clicked")  { 
            @@maPartie.raz
            for i in 0...@@maGrille.size
                for j in 0...@@maGrille[i].size
                    @@maGrille[i][j].resetCell
                end
            end
        }
        btnVerif.signal_connect("clicked")  {
            puts @@maPartie.verifierErreur
        }
        btnQuit.signal_connect("clicked")   { 
            @@maPartie = nil
            Fenetre.deleteChildren; 
            FenetreMenu.afficheToi( FenetrePartie )
        }

  
        # attachement des boutons de mode de jeu
        box.add(btnNewGame); 
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
    def creeCelluleGrille(line,colonne,color)

        btn = Cell.new()
        btn.changerStatut( @@maPartie.grilleEnCours.tabCases[colonne][line].couleur )
        btn.set_x(line);btn.set_y(colonne)
        btn.set_height_request(5)
        btn.set_width_request(5)

        btn.signal_connect "clicked" do |handler| 
            puts "BTN CLICKED {X:#{handler.x};Y:#{handler.y}}"
            maCellule = @@maPartie.grilleEnCours.tabCases[handler.y][handler.x]
            prochaineCouleur = maCellule.couleur + 1
            if prochaineCouleur == 0
                prochaineCouleur = Couleur::GRIS
            end
            @@maPartie.ajouterCoup( Coup.creer( maCellule  , prochaineCouleur , maCellule.couleur ) )
            @@maPartie.grilleEnCours.afficher
            handler.changerStatut( @@maPartie.grilleEnCours.tabCases[handler.y][handler.x].couleur )
        end
        return btn
    end
    private :creeCelluleGrille

    ## METHODE QUI CREE UNE GRILLE
    def creeGrille()

        # Frame exterieur pour que les rebord et la meme epaisseur
        maFrame = Gtk::Frame.new()
        maFrame.set_margin_left(70); maFrame.set_margin_right(70); maFrame.set_margin_top(15)
        
        # grid pour placer la grille de jeu dedans
        maGrille = Gtk::Grid.new()
        maGrille.name = "grid"
        maGrille.set_height_request(671-140);   maGrille.set_width_request(671-140)
        maGrille.set_row_homogeneous(true);     maGrille.set_column_homogeneous(true)

        maGrilleDeJeu = @@maPartie.grilleEnCours.tabCases
        # boucle pour cree la fenetre de jeu
        for ligne in 0...maGrilleDeJeu.size
            for colonne in 0...maGrilleDeJeu.size
                cell =  creeCelluleGrille(ligne,colonne, maGrilleDeJeu[colonne][ligne].couleur )
                @@maGrille[colonne][ligne] = cell
                maGrille.attach( cell , ligne,colonne,1,1)
            end
        end
        
        # ajout de la grille a la frame
        maFrame.add(maGrille)
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

###############################################################
