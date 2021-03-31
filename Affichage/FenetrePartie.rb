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

    def changerStatut(color, forceEnleverRouge)
        if color >= Couleur::ILE_1
            if(!forceEnleverRouge && self.name.include?("red"))
                self.name = "grid-cell-red"
            else
                self.name = "grid-cell"
            end
            
            self.set_label(color.to_s)
        elsif color == Couleur::NOIR
            if(!forceEnleverRouge && self.name.include?("red"))
                 self.name = "grid-cell-red-block"
            else
                 self.name = "grid-cell-block"
            end

            self.set_label("")
           
        elsif color == Couleur::GRIS
            self.set_label("")
            if(!forceEnleverRouge && self.name.include?("red"))
                self.name = "grid-cell-red"
            else
                self.name = "grid-cell"
            end
        elsif color == Couleur::BLANC
            if(!forceEnleverRouge && self.name.include?("red"))
                self.name = "grid-cell-red"
            else
                 self.name = "grid-cell-round"
            end
           
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

    # Lancer une nouvelle partie avec un mode specifique ? A FAIRE
    def self.afficheToi( lastView )
        if @@maPartie == nil
            @@maPartie = Partie.creer(Grille.creer(10,
                [
                    [Case.creer(Couleur::BLANC, 0, 0) ,Case.creer(Couleur::ILE_4, 1, 0),Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::ILE_5, 3, 0), Case.creer(Couleur::BLANC, 4, 0)],
                    [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1), Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::BLANC, 4, 1)],
                    [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::ILE_1, 2, 2), Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::BLANC, 4, 2)],
                    [Case.creer(Couleur::ILE_4, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::BLANC, 4, 3)],
                    [Case.creer(Couleur::BLANC, 0, 4), Case.creer(Couleur::BLANC, 1, 4), Case.creer(Couleur::BLANC, 2, 4), Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4)]
                ]), nil, nil)
                Sauvegardes.getInstance.getSauvegardePartie.ajouterSauvegardePartie(@@maPartie)
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

    ## Charger une partie specifique presente dans la sauvegarde
    def self.afficheToiChargerPartie( lastView , loadAtIndice )
        puts loadAtIndice
        @@maPartie = Sauvegardes.getInstance.getSauvegardePartie.getPartie( loadAtIndice )
        @@maGrille = Array.new(@@maPartie.grilleEnCours.tabCases.size) {Array.new(@@maPartie.grilleEnCours.tabCases.size,false)}

        Fenetre.set_subtitle( @@maPartie.class.to_s )
        maFenetrePartie = FenetrePartie.new()
        Fenetre.add( maFenetrePartie.creationInterface( lastView ) )
        Fenetre.show_all
        
        maFenetrePartie.threadChronometre
        maFenetrePartie.play
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
        @btnHelpHelp = Gtk::Button.new(:label =>"Montrer Erreur")
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

    def afficherNbCase(x, y)
        res = @@maPartie.afficherNbBloc(@@maPartie.grilleEnCours.tabCases[x][y])
        if(res[0] > 1 || @@maPartie.grilleEnCours.tabCases[x][y].estIle?)
            #trouver île
            found = false
            for i in 0...@@maPartie.grilleEnCours.tabCases.size
                for j in 0...@@maPartie.grilleEnCours.tabCases.size
                    if res[1][i][j]

                        if(@@maPartie.grilleEnCours.tabCases[i][j].estIle?)
                            @@maGrille[i][j].name = "grid-cell-ile-appartient-ile"
                        else
                            if( @@maGrille[i][j].name.include?("red"))
                                @@maGrille[i][j].name = "grid-cell-red-appartient"
                            else
                                @@maGrille[i][j].name = "grid-cell-appartient-ile"
                            end
                        end


                        if !found && @@maPartie.grilleEnCours.tabCases[i][j].estIle?
                            #trouver direction popover
                            if( i-1 < 0 || !res[1][i-1][j])
                                @popover = create_popover(@@maGrille[i][j], Gtk::Label.new(res[0].to_s), :top)
                            elsif(i+1 >= @@maPartie.grilleEnCours.tabCases.size || !res[1][i+1][j])
                                @popover = create_popover(@@maGrille[i][j], Gtk::Label.new(res[0].to_s), :bottom)
                            elsif(j-1 < 0 || !res[1][i][j-1])
                                @popover = create_popover(@@maGrille[i][j], Gtk::Label.new(res[0].to_s), :left)
                            elsif(j+1 >= @@maPartie.grilleEnCours.tabCases.size || !res[1][i][j+1])
                                @popover = create_popover(@@maGrille[i][j], Gtk::Label.new(res[0].to_s), :right)
                            else
                                @popover = create_popover(@@maGrille[i][j], Gtk::Label.new(res[0].to_s), :top)
                            end

                            
                            @popover.modal = false
                            @popover.visible = true
                            found = true
                        end
                    end
                end
            end     
        end
    end

    def enleverNbCase()
        if(@popover != nil)
            @popover.visible = false
        end

        for i in 0...@@maPartie.grilleEnCours.tabCases.size
            for j in 0...@@maPartie.grilleEnCours.tabCases.size
                @@maGrille[i][j].changerStatut(@@maPartie.grilleEnCours.tabCases[i][j].couleur, false)
            end
        end
    end

    def afficherPortee(x, y)#TODO
        self
    end


    def create_popover(parent, child, pos)
        popover = Gtk::Popover.new(parent)
        popover.position = pos
        popover.add(child)
        child.margin = 6
        child.show
        popover
     end

    # Methode qui permet de cree
    # une cellule destiner a la grille
    private
    def creeCelluleGrille(line,colonne,color)

        btn = Cell.new()
        btn.changerStatut( @@maPartie.grilleEnCours.tabCases[colonne][line].couleur, true)
        btn.set_x(line);    btn.set_y(colonne); btn.set_height_request(5);  btn.set_width_request(5)

        btn.signal_connect "clicked" do |handler|
            if @@maPartie.chrono.pause == false # PEUT INTERRAGIR UNIQUEMENT SI LA PARTIE N EST PAS EN PAUSE
                maCellule = @@maPartie.grilleEnCours.tabCases[handler.y][handler.x]


                prochaineCouleur = maCellule.couleur + 1
                if prochaineCouleur == 0
                    prochaineCouleur = Couleur::GRIS
                end

                if(prochaineCouleur < Couleur::ILE_1 )
                    if @@maPartie.ajouterCoup( Coup.creer( maCellule  , prochaineCouleur , maCellule.couleur ) )
                        cacherNbErreur
                        handler.changerStatut( @@maPartie.grilleEnCours.tabCases[handler.y][handler.x].couleur , true)
                        enableBtn(@btnUndo)
                        enableBtn(@btnUndoUndo)
                        disableBtn(@btnRedo)
                    end

                    
                    if  @@maPartie.grilleEnCours.tabCases[handler.y][handler.x].couleur == Couleur::BLANC
                        afficherNbCase(handler.y, handler.x)
                    elsif !@@maPartie.grilleEnCours.tabCases[handler.y][handler.x].estIle?
                        enleverNbCase()
                    end

                    if @@maPartie.partieTerminee? == true 
                        pause
                        Sauvegardes.getInstance.getSauvegardePartie.supprimerSauvegardePartie(@@maPartie)
                        show_standard_message_dialog(@@lg.gt("MESSAGE_DE_VICTOIRE"))
                        quitter
                    end

                else
                    afficherPortee(handler.y, handler.x)
                end


            end
        end



       
        btn.signal_connect "enter" do |handler| 
            if @@maPartie.chrono.pause == false
                if @@maPartie.grilleEnCours.tabCases[colonne][line].estIle? || @@maPartie.grilleEnCours.tabCases[handler.y][handler.x].couleur == Couleur::BLANC
                    afficherNbCase(handler.y, handler.x)
                end
            end
        end

        btn.signal_connect "leave" do |handler| 
            if @@maPartie.chrono.pause == false
                if @@maPartie.grilleEnCours.tabCases[colonne][line].estIle? || @@maPartie.grilleEnCours.tabCases[handler.y][handler.x].couleur == Couleur::BLANC
                    enleverNbCase()
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
        @@maGrille[statut[1].positionY][statut[1].positionX].changerStatut( @@maPartie.grilleEnCours.tabCases[statut[1].positionY][statut[1].positionX].couleur, true )
        if statut[0] == false
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

        @@maGrille[statut[1].positionY][statut[1].positionX].changerStatut( @@maPartie.grilleEnCours.tabCases[statut[1].positionY][statut[1].positionX].couleur, true )

        statut[0] == false ? disableBtn(@btnRedo) : 1 ;
    end

    # EVENT UNDO UNDO
    private
    def retourPositionBonne
        cacherNbErreur
        @@maPartie.revenirPositionBonne
        for i in 0...@@maGrille.size
            for j in 0...@@maGrille[i].size
                @@maGrille[i][j].changerStatut( @@maPartie.grilleEnCours.tabCases[i][j].couleur, true )
            end
        end
        disableBtn(@btnUndo); disableBtn(@btnRedo); disableBtn(@btnUndoUndo)
    end

    # EVENT PLAY
    public
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
        enleverNbCase();
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
        pause
        Sauvegardes.getInstance.sauvegarder(nil)
        cacherNbErreur
        @@maPartie = nil;
        Fenetre.deleteChildren;
        FenetreMenu.afficheToi( FenetrePartie )
    end

    # EVENEMENT POUR DONNER LES ERREURS
    private
    def donnerErreur
        uneCase = @@maPartie.donnerErreur
        if uneCase.couleur == Couleur::NOIR 
            @@maGrille[ uneCase.positionY ][ uneCase.positionX ].name = "grid-cell-red-block"
        else
            @@maGrille[ uneCase.positionY ][ uneCase.positionX ].name = "grid-cell-red"
        end
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


=begin
class PopoverDemo
  def initialize(main_window)
    @window = Gtk::Window.new(:toplevel)
    @window.screen = main_window.screen
    box = Gtk::Box.new(:vertical, 24)
    box.margin = 24
    @window.add(box)

    widget = add_toggle_button_with_popover
    box.add(widget)

    widget = add_custom_entry_with_complex_popover
    box.add(widget)

    widget = add_calendar_with_popover
    box.add(widget)
  end

  def run
    if !@window.visible?
      @window.show_all
    else
      @window.destroy
    end
    @window
  end

  

  def create_complex_popover(parent, pos)
    if Gtk::Version.or_later?(3, 20)
      builder = Gtk::Builder.new(:resource => "/popover/popover.ui")
    else
      builder = Gtk::Builder.new(:resource => "/popover/popover-3.18.ui")
    end
    window = builder["window"]
    content = window.child
    content.parent.remove(content)
    window.destroy
    popover = create_popover(parent, content, pos)
    popover
  end

  def add_toggle_button_with_popover
    widget = Gtk::ToggleButton.new(:label => "Button")
    label = Gtk::Label.new("This popover does not grab input")
    toggle_popover = create_popover(widget, label, :top)
    toggle_popover.modal = false
    widget.signal_connect "toggled" do |button|
      toggle_popover.visible = button.active?
    end
    widget
  end

  def add_custom_entry_with_complex_popover
    widget = CustomEntry.new
    entry_popover = create_complex_popover(widget, :top)
    widget.set_icon_from_icon_name(:primary, "edit-find")
    widget.set_icon_from_icon_name(:secondary, "edit-clear")
    widget.signal_connect "icon-press" do |entry, icon_pos, _event|
      rect = entry.get_icon_area(icon_pos)
      entry_popover.pointing_to = rect
      entry_popover.show
      entry.popover_icon_pos = icon_pos
    end

    widget.signal_connect "size-allocate" do |entry, _allocation|
      if entry_popover.visible?
        popover_pos = entry.popover_icon_pos
        rect = entry.get_icon_area(popover_pos)
        entry_popover.pointing_to = rect
      end
    end
    widget
  end

  def add_calendar_with_popover
    widget = Gtk::Calendar.new
    widget.signal_connect "day-selected" do |calendar|
      event = Gtk.current_event
      if event.type == :button_press
        x, y = event.window.coords_to_parent(event.x, event.y)
        allocation = calendar.allocation
        rect = Gdk::Rectangle.new(x - allocation.x, y - allocation.y, 1, 1)
        cal_popover = create_popover(calendar, CustomEntry.new, :bottom)
        cal_popover.pointing_to = rect
        cal_popover.show
      end
    end
    widget
  end
end

class CustomEntry < Gtk::Entry
  attr_accessor :popover_icon_pos
  def initialize
    super
  end
end
=end