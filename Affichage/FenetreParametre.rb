require_relative './Fenetre.rb'
require_relative '../Sauvegarde/SauvegardeGrille.rb'

##
# Classe qui gere l'affichage de la fenetre des parametres
#
# Herite de la classe abstraite Fenetre
class FenetreParametre < Fenetre

    ##
    # Methode privee pour l'initialisation
    def initialize()
        self
    end

    ##
    # Methode qui permet d'afficher la fenetre des parametres
    def self.afficheToi( lastView )

        Fenetre.add( FenetreParametre.new().creationInterface( lastView, false) )
        Fenetre.show_all
        @@unePartie = nil
        return self

    end

    ##
    # Methode qui gere l'affichage des parametres
    def creationInterface(lastView, fromLangue)
        Fenetre.set_subtitle(@@lg.gt("PARAMETRES"))
        @lastView = lastView
        @box = Gtk::Box.new(:vertical)

        # BACK BUTTON
        btnBoxH = Gtk::ButtonBox.new(:horizontal)
        btnBoxH.layout = :start
        btnBack = Gtk::Button.new(:label => @@lg.gt("RETOUR"))
        btnBack.name = "btnBack"
        btnBack.signal_connect("clicked") { Fenetre.remove(@box) ; @lastView.afficheToi( nil ) ; }
        btnBack.set_sensitive(true)
        setmargin(btnBack,5,5,5,0)
        btnBoxH.add(btnBack)
        @box.add(btnBoxH) #ADD

        # SEPARATOR
        @box.add( Gtk::Separator.new(:vertical) ) #ADD

        # VUE PRINCIPAL
        @box.add( creationStack(fromLangue) ) #ADD
        return @box
    end

    ##
    # Methode qui permet de creer une pile pour la gestion des differentes vues
    # des parametres :
    # * Jeu,
    # * Utilisateur,
    # * Interface,
    # * Audio.
    private
    def creationStack(fromLangue)
        box = Gtk::Box.new(:horizontal)
        sidebar = Gtk::StackSidebar.new
        sidebar.set_width_request(160)
        sidebar.set_height_request(705)

        sidebar.name = "sidebar"
        box.pack_start(sidebar, :expand => false, :fill => false, :padding => 0)

        stack = Gtk::Stack.new
        stack.transition_type = :slide_up_down

        sidebar.stack = stack

        widget = Gtk::Separator.new(:vertical)
        box.pack_start(widget, :expand => false, :fill => false, :padding => 0)

        box.pack_start(stack, :expand => true, :fill => true, :padding => 0)

        pages = [@@lg.gt("JEU"),@@lg.gt("UTILISATEUR"),@@lg.gt("INTERFACE"),@@lg.gt("AUDIO")]

        # Jeu
        title = @@lg.gt("JEU")
        vueJeu = creationVueJeu
        stack.add_named(vueJeu, title) # ADD NAMED CHILDREN
        stack.child_set_property(vueJeu, "title", title) # SET A TITLE TO A CHILDREN

        # Utilisateur
        title = @@lg.gt("UTILISATEUR")
        vueUtilisateur = creationVueUtilisateur
        stack.add_named(vueUtilisateur, title)
        stack.child_set_property(vueUtilisateur, "title", title)

        # Interface
        title = @@lg.gt("INTERFACE")
        vueInterface = creationVueInterface
        stack.add_named(vueInterface, title)
        stack.child_set_property(vueInterface, "title", title)

         # Regles
        title = @@lg.gt("REGLES")
        vueRegles = creationVueRegle
        stack.add_named(vueRegles, title)
        stack.child_set_property(vueRegles, "title", title)


        if fromLangue
             vueInterface.show
            stack.visible_child = vueInterface
        end

        stack.signal_connect("notify::visible-child"){
            @btnDeleteSave.set_sensitive(true)
            @btnResetParams.set_sensitive(true)
            if(stack.visible_child == vueRegles)
                @timer = GLib::Timeout.add(300) {
                    @popover1.modal = false
                    @popover2.modal = false
                    @popover3.modal = false

                    @popover1.set_sensitive(false)
                    @popover2.set_sensitive(false)
                    @popover3.set_sensitive(false)



                    @popover3.popup
                    @popover2.popup
                    @popover1.popup

                    @popover1.visible = true
                    @popover2.visible = true
                    @popover3.visible = true


                    GLib::Source.remove(@timer)
                }
            else
                @popover1.visible = false
                @popover2.visible = false
                @popover3.visible = false
                @popover1.popdown
                @popover2.popdown
                @popover3.popdown

            end
        }

        stack.set_visible_child(vueRegles)

        return box
    end

    ##
    # Methode qui creer la vue 'jeu'
    private
    def creationVueJeu
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>" + @@lg.gt("JEU") + "</span>")
        setmargin(title,15,10,0,0)

        box.add(title) #ADD

        # AIDE COMPTEUR D'ILOT
        @switchCompteurIlot = Gtk::Switch.new()
        @switchCompteurIlot.halign = :start
        @switchCompteurIlot.set_active( Sauvegardes.getInstance.getSauvegardeParametre.compteurIlots? )
        @switchCompteurIlot.signal_connect('notify::active') { |s|  Sauvegardes.getInstance.getSauvegardeParametre.set_compteurIlots(s.active?) }
        box.add( creationBoxVerticalPourVue(@@lg.gt("COMPTEURILOTS") + " :" , @switchCompteurIlot) ) #ADD

        # AIDE AFFICHAGE PORTEE
        @switchAffichagePortee = Gtk::Switch.new()
        @switchAffichagePortee.halign = :start
        @switchAffichagePortee.set_active( Sauvegardes.getInstance.getSauvegardeParametre.affichagePortee? )
        @switchAffichagePortee.signal_connect('notify::active') { |s| Sauvegardes.getInstance.getSauvegardeParametre.set_affichagePortee(s.active?) }
        box.add( creationBoxVerticalPourVue(@@lg.gt("AFFICHERPORTER") + " :" , @switchAffichagePortee) ) #ADD

        return box
    end

    ##
    # Methode qui creer la vue 'utilisateur'
    private
    def creationVueUtilisateur
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>"+ @@lg.gt("UTILISATEUR") +"</span>")
        setmargin(title,15,10,0,0)
        box.add(title) # ADD

        @btnDeleteSave = Gtk::Button.new(:label => @@lg.gt("SUPPRIMER_SAUVEGARDE_PARTIE_EN_COURS"))
        @btnDeleteSave.name = "btnQuitter"
        @btnDeleteSave.signal_connect("clicked") {
            Sauvegardes.getInstance.getSauvegardePartie.resetAll(FenetrePartie.getPartie)
            Sauvegardes.getInstance.sauvegarder()
            @btnDeleteSave.set_sensitive(false)
        }

        box.add( setmargin(@btnDeleteSave,5,5,65,65) ) #ADD

        @btnResetParams = Gtk::Button.new(:label => @@lg.gt("RESET_PARAMETRE"))
        @btnResetParams.name = "btnQuitter"
        @btnResetParams.signal_connect("clicked") {
            Sauvegardes.getInstance.getSauvegardeParametre.resetAll
            Sauvegardes.getInstance.sauvegarder()
            @switchDarkMode.set_active(false)
            @switchCompteurIlot.set_active(true)
            @switchCaseGrises.set_active(false)
            @switchAffichagePortee.set_active(true)
            @btnResetParams.set_sensitive(false)
        }
        box.add(setmargin(@btnResetParams,5,5,65,65))

        return box
    end


    ##
    # Methode qui creer la vue 'interface'
    private
    def creationVueInterface
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>"+@@lg.gt("INTERFACE")+"</span>")
        setmargin(title,15,10,0,0)

        box.add(title) #ADD

        # DARK MORD
        @switchDarkMode = Gtk::Switch.new()
        @switchDarkMode.halign = :start
        @switchDarkMode.set_active( Sauvegardes.getInstance.getSauvegardeParametre.modeSombre? )
        @switchDarkMode.signal_connect('notify::active') { |s| Sauvegardes.getInstance.getSauvegardeParametre.setModeSombre(s.active?) }
        box.add( creationBoxVerticalPourVue(@@lg.gt("MODESOMBRE") + " :" , @switchDarkMode) ) #ADD

        # AIDE CASES GRISES
        @switchCaseGrises = Gtk::Switch.new()
        @switchCaseGrises.halign = :start
        @switchCaseGrises.set_active( Sauvegardes.getInstance.getSauvegardeParametre.casesGrises? )
        @switchCaseGrises.signal_connect('notify::active') { |s|
            Sauvegardes.getInstance.getSauvegardeParametre.set_casesGrises(s.active?)
        }
        box.add( creationBoxVerticalPourVue( @@lg.gt("CASESGRISES") + " :" , @switchCaseGrises) ) #ADD

        # CHOOSE LANGUE
        combo = Gtk::ComboBoxText.new()
        combo.wrap_width = 3
        combo.halign = :fill
        for i in 0...Sauvegardes.getInstance.getSauvegardeLangue.langues.size
            combo.append("FR_fr", Sauvegardes.getInstance.getSauvegardeLangue.langues[i])
        end
        combo.set_active(Sauvegardes.getInstance.getSauvegardeLangue.langueActuelle)
        box.add( creationBoxVerticalPourVue(@@lg.gt("CHOISIRLANGUE") + " :" , combo) ) #ADD

        combo.signal_connect("changed"){
            Sauvegardes.getInstance.getSauvegardeLangue.utiliserLangue(combo.active)
            Fenetre.remove(@box)
            Fenetre.add( creationInterface( @lastView, true) )
            Fenetre.show_all
        }

        return box
    end


    ##
    # SIGNAL CONNECT DE INTERFACE : MODE SOMBRE
    private
    def switchModeSombre(s)
        Fenetre.setModeSombre(s.active?)
    end


    ##
    # Permet de creer un element nom + objet
    private
    def creationBoxVerticalPourVue( title, obj )
        box = Gtk::Box.new(:horizontal,20)
        box.set_homogeneous(true)
        setmargin(box,5,5,70,70)
        label = Gtk::Label.new(title )
        label.halign = :end
        box.add( label )#ADD
        box.add( obj )#ADD
        return box
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

    ##
    # Methode qui creer la vue 'règles'
    private
    def creationVueRegle
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>"+@@lg.gt("REGLES")+"</span>")
        setmargin(title,15,10,0,0)

        box.add(title) #ADD

        box.add(creeGrilleImmuable)



        return box
    end

    ##
    # Créé et retourne une grille
    private
    def creeGrilleImmuable()
        # Frame exterieur pour que les rebord et la meme epaisseur
        maFrame = Gtk::Frame.new()
        maFrame.name = "fenetreGrille"
        maFrame.set_margin_left(50); maFrame.set_margin_right(50); maFrame.set_margin_top(85)

        # grid pour placer la grille de jeu dedans
        @maGrilleRegle = Gtk::Grid.new()
        @maGrilleRegle.set_height_request(671-140-140);   @maGrilleRegle.set_width_request(671-140-140)
        @maGrilleRegle.set_row_homogeneous(true);     @maGrilleRegle.set_column_homogeneous(true)

        @maGrilleRegleBacked = SauvegardeGrille.getInstance.getGrilleAt(2).tabCases
        # boucle pour cree la fenetre de jeu
        for ligne in 0...@maGrilleRegleBacked.size
            for colonne in 0...@maGrilleRegleBacked.size
                cell =  creeCelluleGrilleImmuable(ligne,colonne, @maGrilleRegleBacked[colonne][ligne].couleur, @maGrilleRegleBacked)
                if( ligne>2 && colonne >2)
                    if(cell.name.include?("Blanc"))
                        cell.name = "buttonBlancSurligne"
                    else
                        cell.name = "buttonNoirSurligne"
                    end
                elsif( ligne<2 && colonne <2)
                    if(cell.name.include?("Ile"))
                        cell.name = "buttonIleNb"
                        @popover1 = create_popover(cell, Gtk::Label.new(@@lg.gt("MSG_REGLE_ILE")), :top)
                    else
                        cell.name = "buttonBlancNb"
                    end
                end



                @maGrilleRegle.attach( cell , ligne,colonne,1,1)

                if(ligne == 1 && colonne == 3)
                    @popover2 = create_popover( cell, Gtk::Label.new(@@lg.gt("MSG_REGLE_MUR")), :bottom)
                end

                if(ligne == 4 && colonne == 4)
                    @popover3 = create_popover(cell, Gtk::Label.new(@@lg.gt("MSG_REGLE_2x2")), :bottom)
                end
            end
        end
        maFrame.add(@maGrilleRegle)

        return maFrame
    end

    ##
    # Creer un pop-over
    private
    def create_popover(parent, child, pos)
        popover = Gtk::Popover.new(parent)
        popover.position = pos
        popover.add(child)
        child.margin = 6
        child.show
        popover
     end

    ##
    # Methode qui permet de cree
    # une cellule destiner a la grille
    private
    def creeCelluleGrilleImmuable(line,colonne,color, grille)
        btn = Gtk::Button.new()
        btn.set_height_request(5)
        btn.set_width_request(5)

        color = grille[colonne][line].couleur
        if color >= Couleur::ILE_1
            btn.name = "buttonIle"
            btn.set_label(color.to_s)
        elsif color == Couleur::NOIR
            btn.name = "buttonNoir"
            btn.set_label("")
        elsif color == Couleur::GRIS
            btn.name = "buttonGris"
        elsif color == Couleur::BLANC
            btn.name = "buttonBlanc"
            if(!Sauvegardes.getInstance.getSauvegardeParametre.casesGrises?)
                btn.set_label("●")
            else
                btn.set_label("")
            end
        end

        return btn
    end
end