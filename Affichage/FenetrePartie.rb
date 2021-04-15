
require_relative "./Fenetre.rb"
require_relative "./../Partie/Partie.rb"

##
# Classe qui gere l'affichage de la partie
class FenetrePartie < Fenetre

    ##
    # partie en cours
    @@maPartie = nil

    ##
    # grille actuelle
    @@maGrille = nil

    ##
    # booleen qui permet de savoir si le jeu est en pause
    @@vraiPause = false

    ##
    # booleen qui permet de savoir si le joueur a perdu
    @@perdu = false

    ##
    # booleen de la deco
    @@deco = false

    ##
    # booleen pour l'affichage du premier message du tutoriel
    @@tutoStart = true

    ##
    # fenetre de la partie en cours
    @@maFenetrePartie = nil

    ##
    # Methode privee pour l'initialisation
    def initialize()
        self
    end

    ##
    # Fonction qui met les donnees
    # de la headerbar a jours
    def self.metSousTitre
        Fenetre.set_subtitle( @@maPartie.getMode == Mode::LIBRE ? @@lg.gt("PARTIE_LIBRE") :
                              @@maPartie.getMode == Mode::CONTRE_LA_MONTRE ? @@lg.gt("PARTIE_CLM") :
                              @@maPartie.getMode == Mode::SURVIE ? @@lg.gt("PARTIE_SURVIE") :
                              @@maPartie.getMode == Mode::VS ? @@lg.gt("PARTIE_1V1") :
                              @@maPartie.getMode == Mode::TUTORIEL ? @@lg.gt("PARTIE_TUTORIEL") : @@lg.gt("UNKNOWN"))
    end

    ##
    # Methode qui permet d'afficher la fenetre
    def self.afficheToi(lastView)
        self.afficheToiSelec(lastView, nil)
    end

    ##
    # Lancer une nouvelle partie avec un mode specifique
    def self.afficheToiSelec( lastView, unePartie )
        @@perdu = false
        @@deco = false
        # Verifier qu'on a pas recu une partie nil..
        if(unePartie != nil)
            @@maPartie = unePartie
            @@maGrille = Array.new(@@maPartie.grilleEnCours.tabCases.size) {Array.new(@@maPartie.grilleEnCours.tabCases.size,false)}
            if(@@maPartie.getMode != Mode::VS)
                Sauvegardes.getInstance.getSauvegardePartie.ajouterSauvegardePartie(@@maPartie)
            end
        end

        self.metSousTitre # Mettre les sous titre
        @@maFenetrePartie = FenetrePartie.new()

        Fenetre.add( @@maFenetrePartie.creationInterface( lastView ) ) # Creation de l'interface
        Fenetre.show_all

        @@maPartie.reprendrePartie
        @@maFenetrePartie.play

        ##
        # FOR TUTO
        # CHARGE LE MESSAGE
        # CHARGE LES AIDES A ACTIVER / DESACTIVER
        # CASE A FOCUS
        if( @@maPartie.getMode == Mode::TUTORIEL)
            # message d'arrivee du tutoriel
            if @@tutoStart
                @@tutoStart = false
                @@maFenetrePartie.show_standard_message_dialog( @@lg.gt("MSG_DEBUT_TUTO") )
            end
            @@maFenetrePartie.show_standard_message_dialog( @@maPartie.getMessageAide );
            @@maFenetrePartie.setBtnStatut( @@maPartie.aideADesactiver() ) # DESACTIVE LES AIDES
            @@maFenetrePartie.mettreCasesEnRouge()
        end

        ##
        # Lancer le chrono
        @@maFenetrePartie.threadChronometre
        return self
    end

    ##
    # Methode liee au tutoriel
    # qui permet de mettre les cases
    # a focus en rouge
    def mettreCasesEnRouge
        tabAutoriser = @@maPartie.getCoupAutoriser() # tab de coup autoriser du tuto
        min = tabAutoriser.map {|a| a.min}.min # plus petit nombre

        if( min != 999)
            for x in 0...@@maPartie.grilleEnCours.tabCases.size
                for y in 0...@@maPartie.grilleEnCours.tabCases.size
                    if ( tabAutoriser[x][y] == min )
                        if @@maPartie.grilleEnCours.tabCases[x][y].couleur == Couleur::NOIR
                            @@maGrille[ x ][ y ].name = "grid-cell-red-block"
                        elsif  @@maPartie.grilleEnCours.tabCases[x][y].estIle?
                            @@maGrille[ x ][ y ].name = "grid-cell-red-ile"
                        else
                            @@maGrille[ x ][ y ].name = "grid-cell-red"
                        end
                    end
                end
            end
        end
    end

    ##
    # Retourne l'instance de partie
    def self.getInstance
        return @@maFenetrePartie
    end

    ##
    # Charger une partie specifique presente dans la sauvegarde
    def self.afficheToiChargerPartie( lastView , loadAtIndice )
        @@perdu = false
        @@deco = false
        @@maPartie = Sauvegardes.getInstance.getSauvegardePartie.getPartie( loadAtIndice ) # charge une sauvegarde
        @@maGrille = Array.new(@@maPartie.grilleEnCours.tabCases.size) {Array.new(@@maPartie.grilleEnCours.tabCases.size,false)} # Charge une grille

        self.metSousTitre
        @@maFenetrePartie = FenetrePartie.new()
        Fenetre.add( @@maFenetrePartie.creationInterface( lastView ) )
        Fenetre.show_all


        @@maFenetrePartie.threadChronometre
        @@maFenetrePartie.play
        return self
    end


    ##
    # Methode accesseur sur une
    # variable de class en lecture
    def self.getPartie
        return @@maPartie
    end


    ################################################################
    ################## CREATION DE L INTERFACE #####################
    ################################################################

    ##
    # Methode qui permet de cree
    # l'interface de la partie
    def creationInterface( lastView )
        @indiceMalusPopover = -1
        @box = Gtk::Box.new(:vertical)

        #TOOLBAR
        @box.add(creeToolbar)#ADD

        ## Nom de la grille
        boxTop = Gtk::Box.new(:horizontal)

        boxTop.set_margin_top 20
        boxTop.set_margin_bottom 10
        boxTop.set_homogeneous(true)

        nomGrille = Gtk::Label.new()
        nomGrille.set_markup("<span size='25000' > " + @@lg.gt("GRILLE") + " #" + @@maPartie.grilleBase.numero.to_s + "</span>")
        nomGrille.halign = :end

        ##
        # Affichage specifique pour le mode 1V1
        if(@@maPartie.getMode == Mode::VS)
            boxTop.add( nomGrille)
            labelBox = Gtk::Box.new(:vertical)
            labelBox.set_homogeneous(true)


            labelProgressEnemy = Gtk::Label.new(@@lg.gt("AVANCEMENT_ENEMY"))
            labelProgressEnemy.halign = :end
            labelProgressEnemy.valign = :center
            labelProgressEnemy.name = "avancementLabel"

            labelBox.add(labelProgressEnemy)


            progressBox = Gtk::Box.new(:vertical)
            progressBox.set_homogeneous(true)

            @progressEnemy = Gtk::ProgressBar.new()
            @progressEnemy.halign = :start
            @progressEnemy.valign = :center

            progressBox.add(@progressEnemy)

            boxTop.add (labelBox)
            boxTop.add (progressBox)
            nomGrille.halign = :end
            boxTop.set_margin_left(20)
            boxTop.set_margin_right(20)


        elsif(@@maPartie.getMode == Mode::SURVIE)
            boxTop.add( nomGrille)
            #boxTop.add(Gtk::Label.new(""))
            label =Gtk::Label.new(@@maPartie.getNbGrilleFinis.to_s + (@@maPartie.getNbGrilleFinis < 2 ? @@lg.gt("GRILLE_TERMINEE") : @@lg.gt("GRILLES_TERMINEES")) )
            label.halign= :end
            nomGrille.halign = :start
            label.name = "grillesTerminees"
            boxTop.add(label)
            boxTop.set_margin_left 120
            boxTop.set_margin_right 120
         elsif(@@maPartie.getMode == Mode::CONTRE_LA_MONTRE)
            boxTop.add(Gtk::Label.new(""))
            boxTop.add( nomGrille)
            @labelStars = Gtk::Label.new("★★★")
            @labelStars.halign= :end
            @labelStars.set_margin_right(68)
            nomGrille.halign = :center
            @labelStars.name = "stars-actuelles"
            boxTop.add(@labelStars)
        else
            boxTop.add( nomGrille)
            nomGrille.halign = :center
        end

        @box.add( boxTop )#ADD

        #GRILLE
        @frameGrille = creeGrille
        @box.add(@frameGrille)#ADD

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

        @box.add( bottomBox )#ADD

        return @box
    end

    ##
    # Affiche une nouvelle grille
    # Sur la fenetre
    def afficherNextGrille
        Fenetre.remove(@box)
        FenetrePartie.afficheToiSelec( FenetreMenu, @@maPartie )
    end

    ##
    # Partie perdu
    def perdre(tpsEnemi)
        @@perdu = true
        @tpsEnemi = tpsEnemi
    end

    ##
    # Methode qui set l'état deco
    def deco
        @@deco = true
    end

    ##
    # Methode propre au mode 1V1
    # permet de mettre a jour la barre de progression adverse
    def setAvancementEnemy(avancement)
        @progressEnemy.fraction = avancement.to_f
    end

    ##
    # Affiche un message en cas de defaite
    def perdreMsg
        if(@@maPartie != nil)
            if(@popover != nil)
                @popover.visible = false
            end
            pause

            show_standard_message_dialog(@@lg.gt("MSG_PERDRE") + Chrono.getTpsFormatPrecis(@@maPartie.chrono.time) + @@lg.gt("MSG_PERDRE_FIN" ) + @tpsEnemi)

            quitter
        end
    end

    ##
    # Affiche un message en cas de deconnexion
    # propre au mide 1V1 uniquement
    def decoMsg
        if(@@maPartie != nil)
            if(@popover != nil)
                @popover.visible = false
            end
            pause

            show_standard_message_dialog(@@lg.gt("DECO_MSG"))

            quitter
        end
    end

    ##
    # Activer / Desactiver les fonctions d'un
    # btn en fonction d'un tableau qui renvoi
    # des booleans
    def setBtnStatut( unTabDeBoolean )
        tmpTabOfBtn = [ @btnSetting , @btnRedo, @btnUndo, @btnUndoUndo, @btnPlay, @btnPause, @btnHelp, @btnHelpLocation , @btnClear, @btnVerif, @btnQuit ];
        for i in 0...unTabDeBoolean.size
            unTabDeBoolean[i] == true ? enableBtn(tmpTabOfBtn[i]) : disableBtn(tmpTabOfBtn[i])
        end
    end

    ##
    # Methode qui permet de cree
    # la toolbar
    private
    def creeToolbar()
        # BOX HORIZONTAL
        mainToolbar = Gtk::Box.new(:vertical, 0)

        box = Gtk::Box.new(:horizontal, 0)
        box.set_height_request(50)
        # creation des boutons de mode de jeu
        @btnSetting = creeBouttonToolbar("document-properties")
        @btnUndo = creeBouttonToolbar("undo");             @btnRedo = creeBouttonToolbar("redo")
        @btnUndoUndo = creeBouttonToolbar("start");@btnPlay = creeBouttonToolbar("player_play");
        @btnPause = creeBouttonToolbar("player_pause");    @btnHelp = creeBouttonToolbar("help"); @btnHelpLocation = creeBouttonToolbar("hint");
        @btnClear = creeBouttonToolbar("gtk-clear");       @btnVerif = creeBouttonToolbar("gtk-apply")
        @btnQuit = creeBouttonToolbar("gtk-quit")
        # Disable btn att bottom of game

        # SET BTN ENABLE/DISABLE
        disableBtn(@btnRedo); disableBtn(@btnUndo); disableBtn(@btnUndoUndo)
        if @@maPartie.chrono.pause
            @@maPartie.mettrePause; disableBtn(@btnPause); disableBtn(@btnHelp); disableBtn(@btnHelpLocation); disableBtn(@btnUndoUndo); disableBtn(@btnClear); disableBtn(@btnVerif);
        else
            disableBtn(@btnPlay)
            disableBtn(@btnHelpLocation); disableBtn(@btnUndoUndo)
            activerBtnApresPause
        end

        enableBtnIfNot1v1(@btnPause)
        enableBtnIfNot1v1(@btnSetting)
        enableBtnIfNot1v1(@btnHelp)


        #Gestion des evenements + des popups sur les boutons pour le mode tutoriel
        @popoverBtnSetting  = create_popover(@btnSetting, Gtk::Label.new(@@lg.gt("POPUP_REGLAGES")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnSetting.modal = false
        @popoverBtnSetting.visible = false
        @btnSetting.signal_connect("clicked")    { ouvrirReglage  } # LANCER LES REGLAGLES
        @btnSetting.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnSetting.visible = true  : self  } # afficher popup quand souris dessus
        @btnSetting.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnSetting.visible = false : self } # cacher quand la souris n'est plus dessus

        @popoverBtnUndo = create_popover(@btnUndo, Gtk::Label.new(@@lg.gt("POPUP_UNDO")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnUndo.modal = false
        @popoverBtnUndo.visible = false
        @btnUndo.signal_connect("clicked")      {
            if @@maPartie.getMode != Mode::TUTORIEL
                 retourArriere
            end
        } # RETOURNER EN ARRIERE
        @btnUndo.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnUndo.visible = true  : self  } # afficher popup quand souris dessus
        @btnUndo.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnUndo.visible = false : self } # cacher quand la souris n'est plus dessus

        @popoverBtnRedo  = create_popover(@btnRedo, Gtk::Label.new(@@lg.gt("POPUP_REDO")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnRedo.modal = false
        @popoverBtnRedo.visible = false
        @btnRedo.signal_connect("clicked")      {
            if (@@maPartie.getMode != Mode::TUTORIEL)
                 retourAvant
            end
        } # RETOURNER EN AVANT
        @btnRedo.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnRedo.visible = true  : self  } # afficher popup quand souris dessus
        @btnRedo.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnRedo.visible = false : self } # cacher quand la souris n'est plus dessus

        @popoverBtnUndoUndo  = create_popover(@btnUndoUndo, Gtk::Label.new(@@lg.gt("POPUP_UNDOUNDO")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnUndoUndo.modal = false
        @popoverBtnUndoUndo.visible = false
        @btnUndoUndo.signal_connect("clicked")  {  retourPositionBonne } # RETOURNER A LA DERNIERE POSITION BONNE
        @btnUndoUndo.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnUndoUndo.visible = true  : self  } # afficher popup quand souris dessus
        @btnUndoUndo.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnUndoUndo.visible = false : self } # cacher quand la souris n'est plus dessus

        @popoverBtnPlay  = create_popover(@btnPlay, Gtk::Label.new(@@lg.gt("POPUP_PLAY")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnPlay.modal = false
        @popoverBtnPlay.visible = false
        @btnPlay.signal_connect("clicked")      { play  } # METTRE LE JEU EN PLAY
        @btnPlay.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnPlay.visible = true  : self  } # afficher popup quand souris dessus
        @btnPlay.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnPlay.visible = false : self } # cacher quand la souris n'est plus dessus

        @popoverBtnPause  = create_popover(@btnPause, Gtk::Label.new(@@lg.gt("POPUP_PAUSE")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnPause.modal = false
        @popoverBtnPause.visible = false
        @btnPause.signal_connect("clicked")     { pause } # METTRE LE JEU EN PAUSE
        @btnPause.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnPause.visible = true  : self  } # afficher popup quand souris dessus
        @btnPause.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnPause.visible = false : self } # cacher quand la souris n'est plus dessus

        @popoverBtnHelp  = create_popover(@btnHelp, Gtk::Label.new(@@lg.gt("POPUP_HELP")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnHelp.modal = false
        @popoverBtnHelp.visible = false
        @btnHelp.signal_connect("clicked")      { aide } # DEMANDER DE L AIDER
        @btnHelp.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnHelp.visible = true  : self  } # afficher popup quand souris dessus
        @btnHelp.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnHelp.visible = false : self } # cacher quand la souris n'est plus dessus

        @popoverBtnLocation  = create_popover(@btnHelpLocation, Gtk::Label.new(@@lg.gt("POPUP_HELPLOCATION")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnLocation.modal = false
        @popoverBtnLocation.visible = false
        @btnHelpLocation.signal_connect("clicked") { aideLocation }
        @btnHelpLocation.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnLocation.visible = true  : self  } # afficher popup quand souris dessus
        @btnHelpLocation.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnLocation.visible = false : self } # cacher quand la souris n'est plus dessus

        @popoverBtnClear  = create_popover(@btnClear, Gtk::Label.new(@@lg.gt("POPUP_CLEAR")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnClear.modal = false
        @popoverBtnClear.visible = false
        @btnClear.signal_connect("clicked")     {
            if @@maPartie.getMode != Mode::TUTORIEL
                raz
            end
        } # REMISE A ZERO DE LA GRILLE
        @btnClear.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnClear.visible = true  : self  } # afficher popup quand souris dessus
        @btnClear.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnClear.visible = false : self } # cacher quand la souris n'est plus dessus

        @popoverBtnVerif  = create_popover(@btnVerif, Gtk::Label.new(@@lg.gt("POPUP_CHECK")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnVerif.modal = false
        @popoverBtnVerif.visible = false
        @btnVerif.signal_connect("clicked")     { verifier } # VERFIER LA GRILLE
        @btnVerif.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnVerif.visible = true  : self  } # afficher popup quand souris dessus
        @btnVerif.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnVerif.visible = false : self } # cacher quand la souris n'est plus dessus

        @popoverBtnQuit  = create_popover(@btnQuit, Gtk::Label.new(@@lg.gt("POPUP_QUIT")), :bottom) # POP UP POUR LE MODE TUTO
        @popoverBtnQuit.modal = false
        @popoverBtnQuit.visible = false
        @btnQuit.signal_connect("clicked")       {
            if @@maPartie.getMode == Mode::VS
                socket = Fenetre1v1.getSocket
                if(socket != nil)
                    socket.puts "dc"
                end
            end
            quitter

          } # QUITTER LA PARTIE
        @btnQuit.signal_connect("enter") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnQuit.visible = true  : self  } # afficher popup quand souris dessus
        @btnQuit.signal_connect("leave") { @@maPartie.getMode == Mode::TUTORIEL ? @popoverBtnQuit.visible = false : self } # cacher quand la souris n'est plus dessus


        # attachement des boutons de mode de jeu
        box.add(@btnSetting);    box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnUndo);       box.add(@btnRedo)
        box.add(@btnUndoUndo);
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnPlay);       box.add(@btnPause)
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnHelp); box.add(@btnHelpLocation);
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnClear);      box.add(@btnVerif)
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnQuit)


        mainToolbar.add(box)
        mainToolbar.add( Gtk::Separator.new(:horizontal) )
        return mainToolbar
    end

    ##
    # Methode qui permet de creer un bouton
    # qui sera dans la toolbar
    private
    def creeBouttonToolbar(iconName)
        btn = Gtk::Button.new()
        image = Gtk::Image.new(:icon_name => iconName, :size => :LARGE_TOOLBAR)
        btn.add(image)
        btn.set_margin_left(5); btn.set_margin_right(5);
        btn.name = "btn-toolbar" # BTN STYLE
        return btn
    end


    ##
    ## METHODE QUI CREE UNE GRILLE
    def creeGrille()
        # Frame exterieur pour que les rebord et la meme epaisseur
        maFrame = Gtk::Frame.new()
        maFrame.name = "fenetreGrille"
        maFrame.set_margin_left(50); maFrame.set_margin_right(50); maFrame.set_margin_top(15)

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

    ##
    # Methode qui est liee
    # a l'aide compteur d'ilot
    # elle permet donc d'afficher
    # cette aide sur le plateau de jeu
    def afficherNbCase(x, y)
        if(Sauvegardes.getInstance.getSauvegardeParametre.compteurIlot)
            res = @@maPartie.afficherNbBloc(@@maPartie.grilleEnCours.tabCases[x][y])
            if(res[0] > 1 || @@maPartie.grilleEnCours.tabCases[x][y].estIle?)
                #trouver île
                found = false
                for i in 0...@@maPartie.grilleEnCours.tabCases.size
                    for j in 0...@@maPartie.grilleEnCours.tabCases.size
                        if res[1][i][j]

                            if(@@maPartie.grilleEnCours.tabCases[i][j].estIle?)
                                if( @@maGrille[i][j].name.include?("red"))
                                    if(@@maPartie.grilleEnCours.tabCases[i][j].couleur > Couleur::ILE_9)
                                        @@maGrille[i][j].name = "grid-cell-ile-appartient-ile-small-red"
                                    else
                                        @@maGrille[i][j].name = "grid-cell-ile-appartient-ile-red"
                                    end
                                else
                                    if(@@maPartie.grilleEnCours.tabCases[i][j].couleur > Couleur::ILE_9)
                                        @@maGrille[i][j].name = "grid-cell-ile-appartient-ile-small"
                                    else
                                        @@maGrille[i][j].name = "grid-cell-ile-appartient-ile"
                                    end
                                end
                            else
                                if( @@maGrille[i][j].name.include?("red"))
                                    @@maGrille[i][j].name = "grid-cell-red-appartient"
                                else
                                    @@maGrille[i][j].name = "grid-cell-appartient-ile"
                                end
                            end


                            if !found && @@maPartie.grilleEnCours.tabCases[i][j].estIle?
                                @popover = create_popover(@@maGrille[i][j], Gtk::Label.new(res[0].to_s), :top)
                                @popover.modal = false
                                @popover.visible = true
                                found = true
                            end
                        end
                    end
                end

                if(!found)
                    for i in 0...@@maPartie.grilleEnCours.tabCases.size
                        for j in 0...@@maPartie.grilleEnCours.tabCases.size
                            if !found &&res[1][i][j]
                              @popover = create_popover(@@maGrille[i][j], Gtk::Label.new(res[0].to_s), :top)
                              @popover.modal = false
                              @popover.visible = true
                              found = true
                            end
                        end
                    end
                end
            end
        end
    end

    ##
    # Methode complementaire a
    # afficherNbCase sauf que ca
    # enleve l'afficha du nombre d'ilot de
    # la grille
    def enleverNbCase()
        #if(Sauvegardes.getInstance.getSauvegardeParametre.compteurIlot)
            if(@popover != nil)
                @popover.visible = false
            end

            for i in 0...@@maPartie.grilleEnCours.tabCases.size
                for j in 0...@@maPartie.grilleEnCours.tabCases.size
                    @@maGrille[i][j].changerStatut(@@maPartie.grilleEnCours.tabCases[i][j].couleur, false)
                end
            end
        #end
    end

    ##
    # Methode qui Afficher la portee
    # d'une ile sur la grille
    def afficherPortee(x, y)
        if(Sauvegardes.getInstance.getSauvegardeParametre.affichagePortee)
            @porteeAffichee = true
            enleverNbCase
            result = @@maPartie.porteeIle(x, y)

            for i in 0...@@maPartie.grilleEnCours.tabCases.size
                for j in 0...@@maPartie.grilleEnCours.tabCases.size
                    if(result[i][j])
                        if(@@maGrille[i][j].name.include?("block"))
                            if(@@maGrille[i][j].name.include?("red"))
                                @@maGrille[i][j].name = "grid-cell-portee-ile-black-red"
                            else
                                @@maGrille[i][j].name = "grid-cell-portee-ile-black"
                            end
                        elsif @@maPartie.grilleEnCours.tabCases[i][j].estIle?
                            if( @@maGrille[i][j].name.include?("red") )
                                if(@@maPartie.grilleEnCours.tabCases[i][j].couleur > Couleur::ILE_9)
                                    @@maGrille[i][j].name = "grid-cell-portee-ile-ile-small-red"
                                else
                                    @@maGrille[i][j].name = "grid-cell-portee-ile-ile-red"
                                end
                            else
                                if(@@maPartie.grilleEnCours.tabCases[i][j].couleur > Couleur::ILE_9)
                                    @@maGrille[i][j].name = "grid-cell-portee-ile-ile-small"
                                else
                                    @@maGrille[i][j].name = "grid-cell-portee-ile-ile"
                                end
                            end

                        elsif @@maPartie.grilleEnCours.tabCases[i][j].couleur == Couleur::BLANC
                            if(@@maGrille[i][j].name.include?("red"))
                                @@maGrille[i][j].name = "grid-cell-portee-ile-round-red"
                            else
                                @@maGrille[i][j].name = "grid-cell-portee-ile-round"
                            end
                        else
                            if(@@maGrille[i][j].name.include?("red"))
                                @@maGrille[i][j].name = "grid-cell-portee-ile-red"
                            else
                                @@maGrille[i][j].name = "grid-cell-portee-ile"
                            end


                        end
                    end
                end
            end
        end

    end

    ##
    # Methode complementaire qui
    # retire de l'affichage la portee d'une ile
    def enleverPortee(x, y)
        if(@porteeAffichee && Sauvegardes.getInstance.getSauvegardeParametre.affichagePortee)
            @porteeAffichee = false
            enleverNbCase
            if(x!=nil)
                afficherNbCase(x,y)
            end
        end
    end

    ##
    # Creation d'une popover
    def create_popover(parent, child, pos)
        popover = Gtk::Popover.new(parent)
        popover.position = pos
        popover.add(child)
        child.margin = 6
        child.show
        popover
     end

    ##
    # Methode semi-accesseur
    # qui modofie le contenu des btn
    # gris en leur mettant soit un point
    # soit en les mettant gris selon le
    # mode selectionner
    def set_modeGris(estGris)
        for i in 0...@@maGrille.size
            for j in 0...@@maGrille[i].size
                if(@@maPartie.grilleEnCours.tabCases[i][j].couleur == Couleur::BLANC)
                    @@maGrille[i][j].label = estGris ? "" : "●"
                end
            end
        end
    end

    ##
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
                                        ##

                prochaineCouleur = maCellule.couleur + 1
                if prochaineCouleur == 0
                    prochaineCouleur = Couleur::GRIS
                end

                if( @@maPartie.getMode == Mode::TUTORIEL && prochaineCouleur != Couleur::BLANC && @popover != nil )
                    enleverNbCase()
                end


                if(prochaineCouleur < Couleur::ILE_1 )
                    enleverPortee(nil, nil)

                    if @@maPartie.ajouterCoup( Coup.creer( maCellule  , prochaineCouleur , maCellule.couleur ) )

                        cacherNbErreur
                        handler.changerStatut( @@maPartie.grilleEnCours.tabCases[handler.y][handler.x].couleur , true)
                        enableBtn(@btnUndo)
                        enableBtnIfNot1v1(@btnUndoUndo)
                        disableBtn(@btnRedo)
                        disableBtn(@btnHelpLocation)
                    end

                    #afficherMur2x2

                    if @@maPartie.getMode != Mode::TUTORIEL
                        if  @@maPartie.grilleEnCours.tabCases[handler.y][handler.x].couleur == Couleur::BLANC
                            afficherNbCase(handler.y, handler.x)
                        elsif !@@maPartie.grilleEnCours.tabCases[handler.y][handler.x].estIle?
                            enleverNbCase()
                        end
                    end


                    if(@@perdu)
                        perdreMsg()
                    elsif(@@deco)
                        decoMsg()
                    elsif @@maPartie.partieTerminee? == true
                        grilleSuivante =  @@maPartie.grilleSuivante
                        if(grilleSuivante == nil)
                            finirPartie
                        else
                            afficherNextGrille
                        end
                    end

                    if @@maPartie != nil && @@maPartie.getMode == Mode::TUTORIEL
                        mettreCasesEnRouge()
                    end

                    # Verifier si il y'a un nouveau message
                    # disponible en mode tuto
                    if ( @@maPartie != nil && @@maPartie.getMode == Mode::TUTORIEL && @@maPartie.messageDifferent? )
                        show_standard_message_dialog( @@maPartie.getMessageAide );
                    end

                else
                    if ( @@maPartie.getMode == Mode::TUTORIEL  )
                        if( @@maPartie.ajouterCoup( Coup.creer( maCellule  , prochaineCouleur , maCellule.couleur ) ) && !@porteeAffichee )
                            mettreCasesEnRouge()
                            handler.changerStatut( maCellule.couleur , true )
                            afficherPortee(handler.y, handler.x)
                        else
                            enleverPortee(handler.y, handler.x)
                        end
                        # Verifier si il y'a un nouveau message
                        # disponible en mode tuto
                        if @@maPartie.messageDifferent?
                            show_standard_message_dialog( @@maPartie.getMessageAide );
                        end
                    else
                        if(!@porteeAffichee)
                            afficherPortee(handler.y, handler.x)
                        else
                            enleverPortee(handler.y, handler.x)
                        end
                    end
                end

                ##
                # FOR TUTO
                # SI ON EST EN MODE TUTO ON ACTIVE QUE LES AIDES
                # NECESSAIRE AU MODE DE JEU DE L'AIDE
                if( @@maPartie != nil && @@maPartie.getMode == Mode::TUTORIEL )
                    setBtnStatut(@@maPartie.aideADesactiver() )
                end
            end
        end

        ##
        # Methode de fin de partie victoire
        # Elle affiche et realise les differentes action de
        # sauvevargde
        def finirPartie
            if(@@maPartie != nil)
                if(@popover != nil)
                    @popover.visible = false
                end
                pause
                if(@@maPartie.getMode == Mode::CONTRE_LA_MONTRE)
                    Sauvegardes.getInstance.getSauvegardeScore.ajouterTempsContreLaMontre(@@maPartie.grilleBase.numero, @@maPartie.chrono.time)
                elsif(@@maPartie.getMode == Mode::SURVIE)
                    Sauvegardes.getInstance.getSauvegardeScore.ajouterTempsSurvie(@@maPartie.grilleBase.numero, @@maPartie.getNbGrilleFinis )
                end

                Sauvegardes.getInstance.getSauvegardePartie.supprimerSauvegardePartie(@@maPartie)

                case @@maPartie.getMode
                when Mode::LIBRE
                    msg = @@lg.gt("MESSAGE_DE_VICTOIRE") + Chrono.getTpsFormatPrecis(@@maPartie.chrono.time)
                when Mode::SURVIE
                    msg = @@lg.gt("MESSAGE_VICTOIRE_SURVIE_DEBUT") + @@maPartie.getNbGrilleFinis.to_s + " " +(@@maPartie.getNbGrilleFinis < 2 ? @@lg.gt("GRILLE").downcase : @@lg.gt("GRILLES").downcase)
                when Mode::CONTRE_LA_MONTRE
                    @nbRecompense = @@maPartie.getNbRecompense
                    msg = @@lg.gt("MESSAGE_VICTOIRE_CLM_DEBUT") + Chrono.getTpsFormatPrecis(@@maPartie.chrono.time) + @@lg.gt("MESSAGE_VICTOIRE_CLM_FIN")
                    for i in 0..2
                        if(i<@nbRecompense)
                            msg += "★"
                        else
                            msg += "☆"
                        end
                    end
                when Mode::TUTORIEL
                    msg = @@lg.gt("MESSAGE_FIN_TUTORIEL")
                when Mode::VS
                    msg = @@lg.gt("MESSAGE_FIN_1V1") + Chrono.getTpsFormatPrecis(@@maPartie.chrono.time)
                else
                    msg = @@lg.gt("UNKNOWN")
                end

                show_standard_message_dialog(msg)

                quitter
            end
        end


        btn.signal_connect "enter" do |handler|
            if @@maPartie.chrono.pause == false && !@porteeAffichee
                if @@maPartie.grilleEnCours.tabCases[colonne][line].estIle? || @@maPartie.grilleEnCours.tabCases[handler.y][handler.x].couleur == Couleur::BLANC
                    afficherNbCase(handler.y, handler.x)
                end
            end
        end

        btn.signal_connect "leave" do |handler|
            if @@maPartie.chrono.pause == false && !@porteeAffichee
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

    ##
    # BTN VENT OUVRIR REGLAGE
    private
    def ouvrirReglage
        removeTimout
        @@vraiPause = false #décommenter pour reprendre en sortie de réglage même si pause avant
        cacherNbErreur
        @monCompteurErreur.set_markup("<span size='25000' ></span>")
        Fenetre.deleteChildren;
        @@maPartie.mettrePause;
        FenetreParametre.afficheToi( FenetrePartie );
    end

    ##
    # BTN EVENT UNDO
    private
    def retourArriere
        enleverPortee(nil, nil)
        cacherNbErreur

        statut = @@maPartie.retourArriere

        if(statut != nil)
            enableBtn(@btnRedo)

            @@maGrille[statut[1].positionY][statut[1].positionX].changerStatut( @@maPartie.grilleEnCours.tabCases[statut[1].positionY][statut[1].positionX].couleur, true )
            if statut[0] == false
                disableBtn(@btnUndo);
                disableBtn(@btnUndoUndo);
            end
            disableBtn(@btnHelpLocation)
        else
            if(@@maPartie.peutRetourArriere?)
                enableBtn(@btnUndo)
                enableBtn(@btnUndoUndo)
            else
                disableBtn(@btnUndo)
            end

            if(@@maPartie.peutRetourAvant?)
                enableBtn(@btnRedo)
            else
                disableBtn(@btnRedo)
            end
            enleverNbCase
        end
    end

    ##
    # BTN EVENT 1V1
    private
    def enableBtnIfNot1v1(btn)
        if(@@maPartie.getMode != Mode::VS)
            enableBtn(btn)
        else
            disableBtn(btn)
        end
    end


    ##
    # BTN EVENT REDO
    private
    def retourAvant
        enleverPortee(nil, nil)
        cacherNbErreur
        enableBtn(@btnUndo)

        enableBtnIfNot1v1(@btnUndoUndo)
        disableBtn(@btnHelpLocation)
        statut = @@maPartie.retourAvant

        @@maGrille[statut[1].positionY][statut[1].positionX].changerStatut( @@maPartie.grilleEnCours.tabCases[statut[1].positionY][statut[1].positionX].couleur, true )

        statut[0] == false ? disableBtn(@btnRedo) : 1 ;
    end

    ##
    # BTN EVENT UNDO UNDO
    private
    def retourPositionBonne
        enleverPortee(nil, nil)
        cacherNbErreur
        @@maPartie.revenirPositionBonne
        for i in 0...@@maGrille.size
            for j in 0...@@maGrille[i].size
                @@maGrille[i][j].changerStatut( @@maPartie.grilleEnCours.tabCases[i][j].couleur, true )
            end
        end
        disableBtn(@btnUndo); disableBtn(@btnRedo); disableBtn(@btnUndoUndo); disableBtn(@btnHelpLocation)

        create_popover_malus(Malus::MALUS_POS_BONNE)
        setTimout
    end

    ##
    # BTN EVENT PLAY
    public
    def play
        @@maPartie.reprendrePartie;

        cacherNbErreur
         enableBtnIfNot1v1(@btnPause); @@vraiPause = false; activerBtnApresPause; @frameGrille.name = "fenetreGrille"
        enleverNbCase
        enleverPortee(nil, nil)
        set_modeGris(Sauvegardes.getInstance.getSauvegardeParametre.casesGrises?)
        setTimout
    end

    ##
    # Methode qui permet de specifier
    # et mettre en place un timeout
    # compte a rebours
    def setTimout()
        if(@@maPartie.getMode == Mode::SURVIE)

            removeTimout
            time = @@maPartie.chrono.time
            if(time<=0)
                finirPartie
            else
                @monTimout = GLib::Timeout.add(time*1000) {finirPartie}
            end
        end
    end

    ##
    # methode complemenantaire de setTimeout
    # mais qui a pour effet de le supprimer
    def removeTimout
        if(@monTimout != nil)
            GLib::Source.remove(@monTimout)
            @monTimout = nil
        end
    end

    ##
    # BTN EVENT PAUSE
    private
    def pause
        removeTimout
        cacherNbErreur
        @@maPartie.mettrePause;
        @@vraiPause = true;
        enableBtnIfNot1v1(@btnPlay);
        disableBtn(@btnPause);     disableBtn(@btnHelp); disableBtn(@btnHelpLocation)
        disableBtn(@btnUndoUndo);  disableBtn(@btnClear);
        disableBtn(@btnVerif);     disableBtn(@btnUndo);
        disableBtn(@btnRedo);
        enleverNbCase()
        enleverPortee(nil, nil)
        @frameGrille.name = "fenetreGrilleHide"
    end

    ##
    # BTN EVENT DEMANDER UNE AIDE
    private
    def aide
        #enleverPortee(nil, nil)
        indice = @@maPartie.donneIndice
        if ( indice != nil)
            show_standard_message_dialog(indice[0])
            enableBtnIfNot1v1(@btnHelpLocation)
            create_popover_malus(Malus::MALUS_INDICE)
            setTimout
        end


    end

    ##
    # BTN EVENT AIDE PLUS PRECISE
    private
    def aideLocation
        indice = @@maPartie.donneIndice
        if ( indice != nil)
            @@maGrille[indice[1].positionY][indice[1].positionX].name = "grid-cell-red"
            create_popover_malus(Malus::MALUS_INDICE2)
            setTimout
        end
         disableBtn(@btnHelpLocation)
    end

    ##
    # BTN EVENT REMISE A ZERO
    private
    def raz
        enleverPortee(nil, nil)
        cacherNbErreur
        @@maPartie.raz
        for i in 0...@@maGrille.size
            for j in 0...@@maGrille[i].size
                @@maGrille[i][j].changerStatut(@@maPartie.grilleEnCours.tabCases[i][j].couleur, true)
            end
        end
        #disableBtn(@btnUndo)
        disableBtn(@btnRedo)
        disableBtn(@btnUndoUndo)
        disableBtn(@btnHelpLocation)
        if(@@maPartie.peutRetourArriereReelAhky?)
            enableBtn(@btnUndo)
        else
            disableBtn(@btnUndo)
        end
    end

    ##
    # BTN EVENT VERIFIER LA GRILLE
    private
    def verifier
        #enleverPortee(nil, nil)
        compteurErreur = @@maPartie.verifierErreur(true)

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

        create_popover_malus(Malus::MALUS_VERIFICATION)
        setTimout
    end

    ##
    # BTN EVENT QUITTER LA PARTIE
    private
    def quitter
        pause
        Sauvegardes.getInstance.sauvegarder()
        #cacherNbErreur
        @@maPartie = nil;
        Fenetre.deleteChildren;
        FenetreMenu.afficheToi( FenetrePartie )
    end

    ##
    # BTN EVENEMENT POUR DONNER LES ERREURS
    private
    def donnerErreur
        enleverPortee(nil, nil)
        uneCase = @@maPartie.donnerErreur
        if uneCase.couleur == Couleur::NOIR
            @@maGrille[ uneCase.positionY ][ uneCase.positionX ].name = "grid-cell-red-block"
        else
            @@maGrille[ uneCase.positionY ][ uneCase.positionX ].name = "grid-cell-red"
        end

        create_popover_malus(Malus::MALUS_DONNER_ERREUR)
        setTimout
    end

    ##############################################################################
    ####################### FUNCTION #############################################
    ##############################################################################

    ##
    # methode qui permet de cree une
    # popover specifique au malus
    private
    def create_popover_malus(malus)
        if(@@maPartie.getMode == Mode::SURVIE || @@maPartie.getMode == Mode::CONTRE_LA_MONTRE)
            if( @popoverMalus != nil)
                @popoverMalus.name = "not-visible"
            end
            @popoverMalus = create_popover(@monTimer, Gtk::Label.new((@@maPartie.getMode == Mode::CONTRE_LA_MONTRE ? " + " : " - ") + malus.to_s + "s "), :top)

            @popoverMalus.visible = true

            @popoverMalus.modal = false
            @indiceMalusPopover = 0
        end
    end

    ##
    # Methode qui permet de mettre a jours de chronometre
    public
    def threadChronometre
        Thread.new do
            @indiceRespiration = 0
            while @@maPartie != nil && @monTimer != nil
                @indiceRespiration += 1
                if @indiceRespiration%20 == 0
                    @monTimer.name = "timer"
                elsif @indiceRespiration%20 == 10
                    @monTimer.name = "timer_respire"
                end
                @monTimer.set_markup("<span size='25000' >" + @@maPartie.chrono.getTemps + "</span>")

                if (@indiceMalusPopover >= 0)
                    if(@indiceMalusPopover == 8)
                        @popoverMalus.name = "not-visible"
                        @indiceMalusPopover = -1
                    else
                        @indiceMalusPopover += 1
                    end
                end

                #stars
                if(@@maPartie.getMode == Mode::CONTRE_LA_MONTRE && (@nbRecompense == nil || (@nbRecompense != 0 && @indiceRespiration%5==0)) )
                    @nbRecompense = @@maPartie.getNbRecompense
                    msg = ""
                    for i in 0..2
                        if(i<@nbRecompense)
                            msg += "★"
                        else
                            msg += "☆"
                        end
                    end

                    @labelStars.label = msg
                end

                sleep(0.1)
            end
        end
    end

    ##
    # Methode general qui permet
    # d'afficher un une boite de dialogue
    def show_standard_message_dialog(unMessage)
        @dialog = Gtk::MessageDialog.new(:parent => @@window,
                                        :flags => [:modal, :destroy_with_parent],
                                        :type => :info,
                                        :buttons => :none,
                                        :message => unMessage)
        @dialog.add_button( @@lg.gt("OK") , 0)

        @dialog.run

        @dialog.destroy
    end

    ##
    # CACHER LE NOMBRE D'ERREUR
    private
    def cacherNbErreur
        enleverPortee(nil, nil)
        @monCompteurErreur.name = "hide"
        @btnHelpHelp.name = "hide"
        @btnHelpHelp.set_sensitive(false)
    end

    ##
    # METHODE QUI PERMET DE GERER L ETAT DES
    # DIFFERENTS BOUTONS AU RETOUR D UNE PAUSE
    # OU AU DEBUT D UNE PARTIE SAUVEGARDER
    private
    def activerBtnApresPause()
        if @@maPartie.peutRetourArriere?
            enableBtn(@btnUndo)
            enableBtnIfNot1v1(@btnUndoUndo)
        end
        if @@maPartie.peutRetourAvant?
            enableBtn(@btnRedo)
        end
        enableBtn(@btnClear)
        disableBtn(@btnPlay)
        enableBtnIfNot1v1(@btnHelp)
        enableBtnIfNot1v1(@btnVerif);
    end

    ##
    # METHODE QUI PERMET DE
    # DESACTIVER LE FONCTIONNEMENT D UN BTN
    private
    def disableBtn(btn)
        btn.name = "btnHide"
        btn.set_sensitive(false)
    end

    ##
    # METHODE QUI PERMET DE
    # D"ACTIVER LE FONCTIONNEMENT D UN BTN
    private
    def enableBtn(btn)
        btn.name = "btn-toolbar"
        btn.set_sensitive(true)
    end

    ##
    # Methode generique qui set une margin a un objet
    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end

    ##
    #Methode qui permet de cree un separateur
    #qui sera dans la toolbar
    private
    def creerSeparatorToolbar()
        monSeparateur = Gtk::Separator.new(:horizontal)
        monSeparateur.set_margin_left(11);monSeparateur.set_margin_right(11);monSeparateur.set_margin_top(10);monSeparateur.set_margin_bottom(10)
        return monSeparateur
    end

end




# TAMPORAIRE EN ATTENDANT LA CLASS CELL
## TAMPORAIRE EN ATTENDANT LA CLASS CELL
### TAMPORAIRE EN ATTENDANT LA CLASS CELL
#### TAMPORAIRE EN ATTENDANT LA CLASS CELL
class Cell < Gtk::Button
    attr_reader :x, :y

    ##
    # Setter de la coordonee x
    def set_x(x)
        @x = x
    end

     ##
    # Setter de la coordonee y
    def set_y(y)
        @y = y
    end

    ##
    # Methode qui permet de changer le statut d'une cellule
    def changerStatut(color, forceEnleverRouge)
        if color > Couleur::ILE_9
            if( !forceEnleverRouge && self.name.include?("red") )
                self.name = "grid-cell-ile-small-red"
            else
                self.name = "grid-cell-ile-small"
            end
            self.set_label(color.to_s)
        elsif color >= Couleur::ILE_1
            if( !forceEnleverRouge && self.name.include?("red") )
                self.name = "grid-cell-ile-red"
            else
                self.name = "grid-cell-ile"
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
                self.name = "grid-cell-round-red"
            else
                 self.name = "grid-cell-round"
            end
            if(!Sauvegardes.getInstance.getSauvegardeParametre.casesGrises?)
                self.set_label("●")
            else
                 self.set_label("")
            end
        end
    end
end
