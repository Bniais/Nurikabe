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
            self.set_label("")
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
    @@vraiPause = false

    def initialize() 
        self
    end

    def self.afficheToi( lastView )
        if @@maPartie == nil
            @@maPartie = Partie.creer(Grille.creer(4, 
            [
              [Case.creer(Couleur::GRIS, 0, 0) ,Case.creer(Couleur::ILE_4, 1, 0),Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::ILE_5, 3, 0), Case.creer(Couleur::GRIS, 4, 0)],
              [Case.creer(Couleur::GRIS, 0, 1), Case.creer(Couleur::GRIS, 1, 1), Case.creer(Couleur::NOIR, 2, 1), Case.creer(Couleur::GRIS, 3, 1), Case.creer(Couleur::GRIS, 4, 1)],
              [Case.creer(Couleur::GRIS, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::ILE_1, 2, 2), Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::GRIS, 4, 2)],
              [Case.creer(Couleur::ILE_4, 0, 3), Case.creer(Couleur::GRIS, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::GRIS, 3, 3), Case.creer(Couleur::GRIS, 4, 3)],
              [Case.creer(Couleur::GRIS, 0, 4), Case.creer(Couleur::GRIS, 1, 4), Case.creer(Couleur::GRIS, 2, 4), Case.creer(Couleur::GRIS, 3, 4), Case.creer(Couleur::GRIS, 4, 4)]
            ]), nil, nil)
            @@maGrille = Array.new(@@maPartie.grilleEnCours.tabCases.size) {Array.new(@@maPartie.grilleEnCours.tabCases.size,false)}
        end

        if !@@vraiPause 
            @@maPartie.reprendrePartie
        end

        Fenetre.set_subtitle( @@maPartie.class.to_s )
        maFenetrePartie = FenetrePartie.new()
        Fenetre.add( maFenetrePartie.creationInterface( lastView ) )
        Fenetre.show_all

        maFenetrePartie.threadChronometre
        
        return self
    end


    ################################################################
    ################## CREATION DE L INTERFACE #####################
    ################################################################   

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
        @frameGrille = creeGrille
        box.add(@frameGrille)#ADD

        #BOTTOM BOX
        bottomBox = Gtk::Box.new(:horizontal)
        bottomBox.set_homogeneous(true)

        # NB ERREUR

        @monCompteurErreur = Gtk::Label.new()
        setmargin(@monCompteurErreur,20,0,0,0)
        @monCompteurErreur.halign = :end
        @monCompteurErreur.set_markup("<span size='25000' ></span>")
        bottomBox.add( @monCompteurErreur ) #ADD

        # TIMER
        @monTimer = Gtk::Label.new()
        setmargin(@monTimer,20,0,0,0)
        @monTimer.halign = :center
        @monTimer.name = "timer"
        @monTimer.set_markup("<span size='25000' >00:00</span>")
        bottomBox.add( @monTimer)

        # HELP
        @btnHelpHelp = Gtk::Button.new("Montrer Erreur")
        @btnHelpHelp.name = "btnQuitter"
        setmargin(@btnHelpHelp,20,0,0,0)
        @btnHelpHelp.halign = :start
        @btnHelpHelp.signal_connect("clicked") { donnerErreur }
        bottomBox.add(@btnHelpHelp)

        cacherNbErreur

        box.add( bottomBox )#ADD

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
        @btnUndo = creeBouttonToolbar("undo");             @btnRedo = creeBouttonToolbar("redo")
        @btnUndoUndo = creeBouttonToolbar("start");@btnPlay = creeBouttonToolbar("player_play");      
        @btnPause = creeBouttonToolbar("player_pause");    @btnHelp = creeBouttonToolbar("hint");             
        @btnClear = creeBouttonToolbar("gtk-clear");       @btnVerif = creeBouttonToolbar("gtk-apply")
        btnQuit = creeBouttonToolbar("gtk-quit")
        # Disable btn att bottom of game
        
        # SET BTN ENABLE/DISABLE
        disableBtn(@btnRedo); disableBtn(@btnUndo); disableBtn(@btnUndoUndo)
        if @@maPartie.chrono.pause
            @@maPartie.mettrePause; disableBtn(@btnPause); disableBtn(@btnHelp); disableBtn(@btnUndoUndo); disableBtn(@btnClear); disableBtn(@btnVerif);
        else 
            disableBtn(@btnPlay)
            activerBtnApresPause
        end
                
        #Gestion des evenemeents
        btnNewGame.signal_connect("clicked")    { nouvellePartie } # NOUVELLE PARTIE
        btnSetting.signal_connect("clicked")    { ouvrirReglage  } # LANCER LES REGLAGLES
        @btnUndo.signal_connect("clicked")      { retourArriere } # RETOURNER EN ARRIERE
        @btnRedo.signal_connect("clicked")      { retourAvant } # RETOURNER EN AVANT
        @btnUndoUndo.signal_connect("clicked")  {  retourPositionBonne } # RETOURNER A LA DERNIERE POSITION BONNE
        @btnPlay.signal_connect("clicked")      { play  } # METTRE LE JEU EN PLAY
        @btnPause.signal_connect("clicked")     { pause } # METTRE LE JEU EN PAUSE
        @btnHelp.signal_connect("clicked")      { aide } # DEMANDER DE L AIDER
        @btnClear.signal_connect("clicked")     { raz } # REMISE A ZERO DE LA GRILLE
        @btnVerif.signal_connect("clicked")     { verifier } # VERFIER LA GRILLE
        btnQuit.signal_connect("clicked")       { quitter } # QUITTER LA PARTIE

  
        # attachement des boutons de mode de jeu
        box.add(btnNewGame); 
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(btnSetting);    box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnUndo);       box.add(@btnRedo)
        box.add(@btnUndoUndo);
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnPlay);       box.add(@btnPause)
        box.add(@btnHelp);       
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnClear);      box.add(@btnVerif)
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(btnQuit)

        mainToolbar.add(box)
        mainToolbar.add( Gtk::Separator.new(:horizontal) )
        return mainToolbar
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


    ## METHODE QUI CREE UNE GRILLE
    def creeGrille()

        # Frame exterieur pour que les rebord et la meme epaisseur
        maFrame = Gtk::Frame.new()
        maFrame.name = "fenetreGrille"
        maFrame.set_margin_left(70); maFrame.set_margin_right(70); maFrame.set_margin_top(15)
        
        # grid pour placer la grille de jeu dedans
        maGrille = Gtk::Grid.new()
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
        # hide if is in pause
        @@maPartie.chrono.pause ? maFrame.name = "fenetreGrilleHide" : self 
        maFrame.add(maGrille)
        return maFrame
    end

    # Methode qui permet de cree
    # une cellule destiner a la grille
    private 
    def creeCelluleGrille(line,colonne,color)

        btn = Cell.new()
        btn.changerStatut( @@maPartie.grilleEnCours.tabCases[colonne][line].couleur )
        btn.set_x(line);    btn.set_y(colonne); btn.set_height_request(5);  btn.set_width_request(5)

        btn.signal_connect "clicked" do |handler| 
            if @@maPartie.chrono.pause == false # PEUT INTERRAGIR UNIQUEMENT SI LA PARTIE N EST PAS EN PAUSE
                maCellule = @@maPartie.grilleEnCours.tabCases[handler.y][handler.x]
                prochaineCouleur = maCellule.couleur + 1
                if prochaineCouleur == 0
                    prochaineCouleur = Couleur::GRIS
                end
                if @@maPartie.ajouterCoup( Coup.creer( maCellule  , prochaineCouleur , maCellule.couleur ) ) 
                    cacherNbErreur
                    handler.changerStatut( @@maPartie.grilleEnCours.tabCases[handler.y][handler.x].couleur )
                    enableBtn(@btnUndo)
                    enableBtn(@btnUndoUndo)
                    disableBtn(@btnRedo)
                end
            end
        end
        return btn
    end

    ###################################################################
    ####################### BTN EVENTS ################################
    ###################################################################
    # EVENT NOUVELLE PARTIE
    private
    def nouvellePartie
        cacherNbErreur
        puts "click NewFile"
        @monCompteurErreur.set_markup("<span size='25000' ></span>")
    end
    
    # EVENT OUVRIR REGLAGE 
    private 
    def ouvrirReglage
        cacherNbErreur
        @monCompteurErreur.set_markup("<span size='25000' ></span>")
        Fenetre.deleteChildren; 
        @@maPartie.mettrePause; 
        FenetreParametre.afficheToi( FenetrePartie );
    end

    # EVENT UNDO
    private 
    def retourArriere
        cacherNbErreur
        enableBtn(@btnRedo) 
        statut = @@maPartie.retourArriere
        for i in 0...@@maGrille.size
            for j in 0...@@maGrille[i].size
                @@maGrille[i][j].changerStatut( @@maPartie.grilleEnCours.tabCases[i][j].couleur )
            end
        end
        if statut == false
             disableBtn(@btnUndo); 
             disableBtn(@btnUndoUndo);
        end 
    end

    # EVENT REDO
    private 
    def retourAvant 
        cacherNbErreur
        enableBtn(@btnUndo)
        enableBtn(@btnUndoUndo)
        statut = @@maPartie.retourAvant
        puts statut
        for i in 0...@@maGrille.size
            for j in 0...@@maGrille[i].size
               @@maGrille[i][j].changerStatut( @@maPartie.grilleEnCours.tabCases[i][j].couleur )
            end
        end
        statut == false ? disableBtn(@btnRedo) : 1 ;
    end

    # EVENT UNDO UNDO 
    private 
    def retourPositionBonne
        cacherNbErreur
        @@maPartie.revenirPositionBonne
        for i in 0...@@maGrille.size
            for j in 0...@@maGrille[i].size
                @@maGrille[i][j].changerStatut( @@maPartie.grilleEnCours.tabCases[i][j].couleur )
            end
        end
        disableBtn(@btnUndo); disableBtn(@btnRedo); disableBtn(@btnUndoUndo)
    end

    # EVENT PLAY 
    private 
    def play 
        cacherNbErreur
        @@maPartie.reprendrePartie; enableBtn(@btnPause); @@vraiPause = false; activerBtnApresPause; @frameGrille.name = "fenetreGrille"
    end

    # EVENT PAUSE
    private
    def pause 
        cacherNbErreur
        @@maPartie.mettrePause; 
        @@vraiPause = true; 
        enableBtn(@btnPlay);
        disableBtn(@btnPause);     disableBtn(@btnHelp); 
        disableBtn(@btnUndoUndo);  disableBtn(@btnClear); 
        disableBtn(@btnVerif);     disableBtn(@btnUndo); 
        disableBtn(@btnRedo); 
        @frameGrille.name = "fenetreGrilleHide"
    end

    # EVENT DEMANDER UNE AIDE
    private
    def aide 
        indice = @@maPartie.donneIndice
        if ( indice != nil)
             puts [Indice::MESSAGES[indice[0]],indice[1]] #fait une erreur si pas d'indice trouvé
             show_standard_message_dialog(Indice::MESSAGES[indice[0]])
        end
        
    end

    # EVENT REMISE A ZERO
    private
    def raz 
        cacherNbErreur
        @@maPartie.raz
        for i in 0...@@maGrille.size
            for j in 0...@@maGrille[i].size
                @@maGrille[i][j].resetCell
            end
        end
        disableBtn(@btnUndo) 
        disableBtn(@btnRedo)
        disableBtn(@btnUndoUndo)
    end

    # EVENT VERIFIER LA GRILLE
    private 
    def verifier 
        compteurErreur = @@maPartie.verifierErreur

        @monCompteurErreur.name = ""

        if compteurErreur > 0
            @btnHelpHelp.name = "btnQuitter"
            @btnHelpHelp.set_sensitive(true)
        end

        if compteurErreur <= 1 
            @monCompteurErreur.set_markup("<span size='25000' >" + compteurErreur.to_s + " erreur</span>")
        elsif compteurErreur > 1 
            @monCompteurErreur.set_markup("<span size='25000' >" + compteurErreur.to_s + " erreurs</span>")
        end
    end

    # EVENT QUITTER LA PARTIE
    private 
    def quitter
        cacherNbErreur
        @@maPartie = nil;     
        Fenetre.deleteChildren;    
        FenetreMenu.afficheToi( FenetrePartie )
    end

    # EVENEMENT POUR DONNER LES ERREURS
    private
    def donnerErreur
        uneCase = @@maPartie.donnerErreur
        @@maGrille[ uneCase.positionY ][ uneCase.positionX ].name = "grid-cell-red"
    end
    ##############################################################################
    ####################### FUNCTION #############################################
    ##############################################################################

    ## Methode qui permet de mettre a jours de chronometre
    public
    def threadChronometre
        Thread.new do
            @indiceRespiration = 0
            while @@maPartie != nil
                @indiceRespiration += 1
                if @indiceRespiration%4 == 0
                    @monTimer.name = "timer"
                elsif @indiceRespiration%4 == 2
                    @monTimer.name = "timer_respire"
                end
                @monTimer.set_markup("<span size='25000' >" + @@maPartie.chrono.getTemps + "</span>")
                sleep(0.5)
            end
        end
    end

    def show_standard_message_dialog(unMessage)
        @dialog = Gtk::MessageDialog.new(:parent => @@window,
                                        :flags => [:modal, :destroy_with_parent],
                                        :type => :info,
                                        :buttons => :none,
                                        :message => unMessage)
        @dialog.add_button( "OK" , 0)
        @dialog.run
        @dialog.destroy
    end
    
    ## CACHER LE NOMBRE D'ERREUR
    private 
    def cacherNbErreur
        @monCompteurErreur.name = "hide"
        @btnHelpHelp.name = "hide"
        @btnHelpHelp.set_sensitive(false)
    end

    # METHODE QUI PERMET DE GERER L ETAT DES 
    # DIFFERENTS BOUTONS AU RETOUR D UNE PAUSE 
    # OU AU DEBUT D UNE PARTIE SAUVEGARDER
    private
    def activerBtnApresPause()
        if @@maPartie.peutRetourArriere? 
            enableBtn(@btnUndo)
            enableBtn(@btnUndoUndo)
        end
        if @@maPartie.peutRetourAvant?
            enableBtn(@btnRedo)
        end
        enableBtn(@btnClear)
        disableBtn(@btnPlay)
        enableBtn(@btnHelp)
        enableBtn(@btnVerif);
    end

    # METHODE QUI PERMET DE 
    # DESACTIVER LE FONCTIONNEMENT D UN BTN
    private 
    def disableBtn(btn)
        btn.name = "btnHide"
        btn.set_sensitive(false)
    end

    # METHODE QUI PERMET DE 
    # D"ACTIVER LE FONCTIONNEMENT D UN BTN
    private 
    def enableBtn(btn)
        btn.name = "btn-toolbar"
        btn.set_sensitive(true)
    end

    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return nil
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
