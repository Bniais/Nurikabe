require './Fenetre.rb'

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
        puts "fini"
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

       
        if fromLangue
            puts "from"
             vueInterface.show
            stack.visible_child = vueInterface
        end

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
    # SIGNAL CONNECT DE JEU : AIDE CASES GRISES
    private
    def switchAideCasesGrises(s)
        puts s
    end

    ##
    # SIGNAL CONNECT DE JEU : AIDE COMPTEUR ILOT
    private
    def switchAideCompteurIlot(s)
        puts s
    end

    ##
    # SIGNAL CONNECT DE JEU : AIDE AFFICHAGE PORTEE
    private
    def switchAideAffichagePortee(s)
        puts s
    end

    ##
    # SIGNAL CONNECT DE JEU : AIDE MURS 2x2
    private
    def switchAideMurs2x2(s)
        puts s
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

        btnDeleteSave = Gtk::Button.new(:label => @@lg.gt("SUPPRIMER_SAUVEGARDE_PARTIE_EN_COURS"))
        btnDeleteSave.name = "btnQuitter"
        btnDeleteSave.signal_connect("clicked") {
            Sauvegardes.getInstance.getSauvegardePartie.resetAll(FenetrePartie.getPartie)
            Sauvegardes.getInstance.sauvegarder(nil)
        }

        box.add( setmargin(btnDeleteSave,5,5,65,65) ) #ADD

        btnResetParams = Gtk::Button.new(:label => @@lg.gt("RESET_PARAMETRE"))
        btnResetParams.name = "btnQuitter"
        btnResetParams.signal_connect("clicked") {
            Sauvegardes.getInstance.getSauvegardeParametre.resetAll
            Sauvegardes.getInstance.sauvegarder(nil)
            @switchDarkMode.set_active(false)
            @switch2x2.set_active(false)
            @switchCompteurIlot.set_active(true)
            @switchCaseGrises.set_active(false)
            @switchAffichagePortee.set_active(true)
        }
        box.add(setmargin(btnResetParams,5,5,65,65))

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
        @switchDarkMode.signal_connect('notify::active') { |s| Sauvegardes.getInstance.getSauvegardeParametre.set_modeSombre(s.active?) }
        box.add( creationBoxVerticalPourVue(@@lg.gt("MODESOMBRE") + " :" , @switchDarkMode) ) #ADD

        # AIDE CASES GRISES
        @switchCaseGrises = Gtk::Switch.new()
        @switchCaseGrises.halign = :start
        @switchCaseGrises.set_active( Sauvegardes.getInstance.getSauvegardeParametre.casesGrises? )
        @switchCaseGrises.signal_connect('notify::active') { |s| Sauvegardes.getInstance.getSauvegardeParametre.set_casesGrises(s.active?) }
        box.add( creationBoxVerticalPourVue( @@lg.gt("CASESGRISES") + " :" , @switchCaseGrises) ) #ADD

        # CHOOSE LANGUE
        combo = Gtk::ComboBoxText.new()
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
        Fenetre.set_modeSombre(s.active?)
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

end

=begin
FenetreParametre.afficheToi( FenetreParame tre )
Fenetre.show_all()

Gtk.main
=end
