
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
            end
        end
    end

end



# Classe qui gere la fenetre 'A propos'
class FenetrePartie < Fenetre

    @@maPartie = nil
    @@maGrille = nil
    @@vraiPause = false
    @@perdu = false
    @@deco = false
    def initialize()
        self
    end

    def self.metSousTitre
        Fenetre.set_subtitle( @@maPartie.getMode == Mode::LIBRE ? @@lg.gt("PARTIE_LIBRE") :
                              @@maPartie.getMode == Mode::CONTRE_LA_MONTRE ? @@lg.gt("PARTIE_CLM") :
                              @@maPartie.getMode == Mode::SURVIE ? @@lg.gt("PARTIE_SURVIE") :
                              @@maPartie.getMode == Mode::VS ? @@lg.gt("PARTIE_1V1") :
                              @@maPartie.getMode == Mode::TUTORIEL ? @@lg.gt("PARTIE_TUTORIEL") : @@lg.gt("UNKNOWN"))
    end

    def self.afficheToi(lastView)
        self.afficheToiSelec(lastView, nil)
    end

    # Lancer une nouvelle partie avec un mode specifique ? A FAIRE
    def self.afficheToiSelec( lastView, unePartie )
        @@perdu = false
        @@deco = false
        if(unePartie != nil)
            @@maPartie = unePartie
            @@maGrille = Array.new(@@maPartie.grilleEnCours.tabCases.size) {Array.new(@@maPartie.grilleEnCours.tabCases.size,false)}
            if(@@maPartie.getMode != Mode::VS)
                Sauvegardes.getInstance.getSauvegardePartie.ajouterSauvegardePartie(@@maPartie)
            end
        end

        self.metSousTitre
        @@maFenetrePartie = FenetrePartie.new()
       
        Fenetre.add( @@maFenetrePartie.creationInterface( lastView ) )
        Fenetre.show_all

        @@maPartie.reprendrePartie
        @@maFenetrePartie.play


        @@maFenetrePartie.threadChronometre
        puts self
        return self
    end

    def self.getInstance
        return @@maFenetrePartie
    end

    ## Charger une partie specifique presente dans la sauvegarde
    def self.afficheToiChargerPartie( lastView , loadAtIndice )
        @@perdu = false
        @@deco = false
        @@maPartie = Sauvegardes.getInstance.getSauvegardePartie.getPartie( loadAtIndice )
        @@maGrille = Array.new(@@maPartie.grilleEnCours.tabCases.size) {Array.new(@@maPartie.grilleEnCours.tabCases.size,false)}

        self.metSousTitre
        @@maFenetrePartie = FenetrePartie.new()
        Fenetre.add( @@maFenetrePartie.creationInterface( lastView ) )
        Fenetre.show_all


        @@maFenetrePartie.threadChronometre
        @@maFenetrePartie.play
        return self
    end


    def self.getPartie
        return @@maPartie
    end

    ################################################################
    ################## CREATION DE L INTERFACE #####################
    ################################################################

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

    def afficherNextGrille
        Fenetre.remove(@box)
        FenetrePartie.afficheToiSelec( FenetreMenu, @@maPartie )
    end

    def perdre(tpsEnemi)
        @@perdu = true
        @tpsEnemi = tpsEnemi
    end

    def deco
        @@deco = true
    end

    def setAvancementEnemy(avancement)
        puts avancement
        puts avancement.to_f
        @progressEnemy.fraction = avancement.to_f
    end

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

    def decoMsg
        puts "deco msg"
        if(@@maPartie != nil)
            if(@popover != nil)
                @popover.visible = false
            end
            pause
            
            show_standard_message_dialog(@@lg.gt("DECO_MSG"))

            quitter
        end
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
        btnSetting = creeBouttonToolbar("document-properties")
        @btnUndo = creeBouttonToolbar("undo");             @btnRedo = creeBouttonToolbar("redo")
        @btnUndoUndo = creeBouttonToolbar("start");@btnPlay = creeBouttonToolbar("player_play");
        @btnPause = creeBouttonToolbar("player_pause");    @btnHelp = creeBouttonToolbar("help"); @btnHelpLocation = creeBouttonToolbar("hint");
        @btnClear = creeBouttonToolbar("gtk-clear");       @btnVerif = creeBouttonToolbar("gtk-apply")
        btnQuit = creeBouttonToolbar("gtk-quit")
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
        enableBtnIfNot1v1(btnSetting)
        enableBtnIfNot1v1(@btnHelp)


        #Gestion des evenemeents
        btnSetting.signal_connect("clicked")    { ouvrirReglage  } # LANCER LES REGLAGLES
        @btnUndo.signal_connect("clicked")      { retourArriere } # RETOURNER EN ARRIERE
        @btnRedo.signal_connect("clicked")      { retourAvant } # RETOURNER EN AVANT
        @btnUndoUndo.signal_connect("clicked")  {  retourPositionBonne } # RETOURNER A LA DERNIERE POSITION BONNE
        @btnPlay.signal_connect("clicked")      { play  } # METTRE LE JEU EN PLAY
        @btnPause.signal_connect("clicked")     { pause } # METTRE LE JEU EN PAUSE
        @btnHelp.signal_connect("clicked")      { aide } # DEMANDER DE L AIDER
        @btnHelpLocation.signal_connect("clicked") { aideLocation }
        @btnClear.signal_connect("clicked")     { raz } # REMISE A ZERO DE LA GRILLE
        @btnVerif.signal_connect("clicked")     { verifier } # VERFIER LA GRILLE
        btnQuit.signal_connect("clicked")       { 
            if @@maPartie.getMode == Mode::VS
                socket = Fenetre1v1.getSocket
                if(socket != nil)
                    socket.puts "dc"
                else
                    puts "aieFP"
                end
            end
            quitter
            
          } # QUITTER LA PARTIE


        # attachement des boutons de mode de jeu
        box.add(btnSetting);    box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnUndo);       box.add(@btnRedo)
        box.add(@btnUndoUndo);
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnPlay);       box.add(@btnPause)
        box.add(creerSeparatorToolbar)  # SEPARATOR
        box.add(@btnHelp); box.add(@btnHelpLocation);
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
        if(Sauvegardes.getInstance.getSauvegardeParametre.compteurIlot)
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
    end

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
                                @@maGrille[i][j].name = "grid-cell-portee-ile-ile"                          
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

    def enleverPortee(x, y)
        if(@porteeAffichee && Sauvegardes.getInstance.getSauvegardeParametre.affichagePortee)
            @porteeAffichee = false
            enleverNbCase
            if(x!=nil)
                afficherNbCase(x,y)
            end
        end
    end


    def create_popover(parent, child, pos)
        popover = Gtk::Popover.new(parent)
        popover.position = pos
        popover.add(child)
        child.margin = 6
        child.show
        popover
     end


    def set_modeGris(estGris)
        for i in 0...@@maGrille.size
            for j in 0...@@maGrille[i].size
                if(@@maPartie.grilleEnCours.tabCases[i][j].couleur == Couleur::BLANC)
                    @@maGrille[i][j].label = estGris ? "" : "●"
                end
            end
        end
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


                    if  @@maPartie.grilleEnCours.tabCases[handler.y][handler.x].couleur == Couleur::BLANC
                        afficherNbCase(handler.y, handler.x)
                    elsif !@@maPartie.grilleEnCours.tabCases[handler.y][handler.x].estIle?
                        enleverNbCase()
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



                else
                    if(!@porteeAffichee)
                        afficherPortee(handler.y, handler.x)
                    else
                        enleverPortee(handler.y, handler.x)
                    end
                end

            end
        end

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
                    nbRecompense = @@maPartie.getNbRecompense
                    msg = @@lg.gt("MESSAGE_VICTOIRE_CLM_DEBUT") + Chrono.getTpsFormatPrecis(@@maPartie.chrono.time) + @@lg.gt("MESSAGE_VICTOIRE_CLM_FIN")
                    for i in 0..2
                        if(i<nbRecompense)
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

    # EVENT OUVRIR REGLAGE
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

    # EVENT UNDO
    private
    def retourArriere
        enleverPortee(nil, nil)
        cacherNbErreur
        enableBtn(@btnRedo)
        statut = @@maPartie.retourArriere
        @@maGrille[statut[1].positionY][statut[1].positionX].changerStatut( @@maPartie.grilleEnCours.tabCases[statut[1].positionY][statut[1].positionX].couleur, true )
        if statut[0] == false
             disableBtn(@btnUndo);
             disableBtn(@btnUndoUndo);
        end
        disableBtn(@btnHelpLocation)
    end

    private 
    def enableBtnIfNot1v1(btn)
        if(@@maPartie.getMode != Mode::VS)
            enableBtn(btn)
        else
            disableBtn(btn)
        end
    end
    

    # EVENT REDO
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

    # EVENT UNDO UNDO
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

    # EVENT PLAY
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

    def removeTimout
        if(@monTimout != nil)
            GLib::Source.remove(@monTimout)
            @monTimout = nil
        end
    end
    # EVENT PAUSE
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

    # EVENT DEMANDER UNE AIDE
    private
    def aide
        #enleverPortee(nil, nil)
        indice = @@maPartie.donneIndice
        if ( indice != nil)
            show_standard_message_dialog(Indice::MESSAGES[indice[0]])
            enableBtnIfNot1v1(@btnHelpLocation)
            create_popover_malus(Malus::MALUS_INDICE)
            setTimout
        end


    end

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

    # EVENT REMISE A ZERO
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
        disableBtn(@btnUndo)
        disableBtn(@btnRedo)
        disableBtn(@btnUndoUndo)
        disableBtn(@btnHelpLocation)
    end

    # EVENT VERIFIER LA GRILLE
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

    # EVENT QUITTER LA PARTIE
    private
    def quitter
        pause
        Sauvegardes.getInstance.sauvegarder(nil)
        #cacherNbErreur
        @@maPartie = nil;
        Fenetre.deleteChildren;
        FenetreMenu.afficheToi( FenetrePartie )
    end

    # EVENEMENT POUR DONNER LES ERREURS
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

    ## Methode qui permet de mettre a jours de chronometre
    public
    def threadChronometre
        Thread.new do
            @indiceRespiration = 0
            while @@maPartie != nil
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
                if(@@maPartie.getMode == Mode::CONTRE_LA_MONTRE && @indiceRespiration%5==0)
                    nbRecompense = @@maPartie.getNbRecompense
                    msg = ""
                    for i in 0..2
                        if(i<nbRecompense)
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

    ## CACHER LE NOMBRE D'ERREUR
    private
    def cacherNbErreur
        enleverPortee(nil, nil)
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
        return obj
    end

    #Methode qui permet de cree un separateur
    #qui sera dans la toolbar
    private
    def creerSeparatorToolbar()
        monSeparateur = Gtk::Separator.new(:horizontal)
        monSeparateur.set_margin_left(11);monSeparateur.set_margin_right(11);monSeparateur.set_margin_top(10);monSeparateur.set_margin_bottom(10)
        return monSeparateur
    end

end