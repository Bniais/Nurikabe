require './Fenetre.rb'

class FenetreParametre < Fenetre

   
    
    def initialize()    
        self
    end

    def self.afficheToi( lastView )
        Fenetre.set_subtitle(@@lg.gt("PARAMETRES"))
        Fenetre.add( FenetreParametre.new().creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end

    
    def creationInterface( lastView)
        box = Gtk::Box.new(:vertical)

        # BACK BUTTON
        btnBoxH = Gtk::ButtonBox.new(:horizontal)
        btnBoxH.layout = :start
        btnBack = Gtk::Button.new(:label => @@lg.gt("RETOUR"))
        btnBack.name = "btnBack"
        btnBack.signal_connect("clicked") { Fenetre.remove(box) ; lastView.afficheToi( nil ) ; }
        lastView == nil ? btnBack.set_sensitive(false) : btnBack.set_sensitive(true)
        setmargin(btnBack,5,5,5,0)
        btnBoxH.add(btnBack)
        box.add(btnBoxH) #ADD
        
        # SEPARATOR
        box.add( Gtk::Separator.new(:vertical) ) #ADD

        # VUE PRINCIPAL
        box.add( creationStack ) #ADD    

        return box
    end

    private
    def creationStack
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

        # AUDIO
        title = @@lg.gt("AUDIO")
        vueAudio = creationVueAudio
        stack.add_named(vueAudio, title)
        stack.child_set_property(vueAudio, "title", title)
        return box
    end

    ###### JEU 
    private
    def creationVueJeu
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>" + @@lg.gt("JEU") + "</span>")
        setmargin(title,15,10,0,0)

        box.add(title) #ADD

        # AIDE CASES GRISES
        switch = Gtk::Switch.new()
        switch.halign = :start
        switch.set_active( Sauvegardes.getInstance.getSauvegardeParametre.casesGrises? )
        switch.signal_connect('notify::active') { |s| Sauvegardes.getInstance.getSauvegardeParametre.set_casesGrises(s.active?) }
        box.add( creationBoxVerticalPourVue( @@lg.gt("CASESGRISES") + " :" , switch) ) #ADD
        
        # AIDE COMPTEUR D'ILOT
        switch = Gtk::Switch.new()
        switch.halign = :start
        switch.set_active( Sauvegardes.getInstance.getSauvegardeParametre.compteurIlots? )
        switch.signal_connect('notify::active') { |s|  Sauvegardes.getInstance.getSauvegardeParametre.set_compteurIlots(s.active?) }
        box.add( creationBoxVerticalPourVue(@@lg.gt("COMPTEURILOTS") + " :" , switch) ) #ADD

        # AIDE AFFICHAGE PORTEE
        switch = Gtk::Switch.new()
        switch.halign = :start
        switch.set_active( Sauvegardes.getInstance.getSauvegardeParametre.affichagePortee? )
        switch.signal_connect('notify::active') { |s| Sauvegardes.getInstance.getSauvegardeParametre.set_affichagePortee(s.active?) }
        box.add( creationBoxVerticalPourVue(@@lg.gt("AFFICHERPORTER") + " :" , switch) ) #ADD

        # AIDE MURS 2x2
        switch = Gtk::Switch.new()
        switch.halign = :start
        switch.set_active( Sauvegardes.getInstance.getSauvegardeParametre.mur2x2? )
        switch.signal_connect('notify::active') { |s| Sauvegardes.getInstance.getSauvegardeParametre.set_mur2x2(s.active?) }
        box.add( creationBoxVerticalPourVue(@@lg.gt("MURS2x2") + " :" , switch) ) #ADD
        return box
    end
    ### SIGNAL CONNECTS DE JEU
    # AIDE CASES GRISES
    private
    def switchAideCasesGrises(s)
        puts s
    end 
    # AIDE COMPTEUR ILOT
    private
    def switchAideCompteurIlot(s)
        puts s
    end 
    # AIDE AFFICHAGE PORTEE
    private
    def switchAideAffichagePortee(s)
        puts s
    end 
    # AIDE MURS 2x2
    private
    def switchAideMurs2x2(s)
        puts s
    end 

    ###### UTILISATEUR 
    private
    def creationVueUtilisateur
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>"+ @@lg.gt("UTILISATEUR") +"</span>")
        setmargin(title,15,10,0,0)
        box.add(title)
        return box
    end
    ### SIGNAL CONNECTS DE UTILISATEUR

    ###### INTERFACE 
    private
    def creationVueInterface
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>"+@@lg.gt("INTERFACE")+"</span>")
        setmargin(title,15,10,0,0)

        box.add(title) #ADD

        # DARK MORD
        switch = Gtk::Switch.new()
        switch.halign = :start
        switch.set_active( Sauvegardes.getInstance.getSauvegardeParametre.modeSombre? )
        switch.signal_connect('notify::active') { |s| Sauvegardes.getInstance.getSauvegardeParametre.set_modeSombre(s.active?) }
        box.add( creationBoxVerticalPourVue(@@lg.gt("MODESOMBRE") + " :" , switch) ) #ADD

        # CHOOSE LANGUE
        combo = Gtk::ComboBoxText.new()
        combo.halign = :fill
        combo.append("FR_fr","Francais")
        combo.set_active(0)
        box.add( creationBoxVerticalPourVue(@@lg.gt("CHOISIRLANGUE") + " :" , combo) ) #ADD
        
        # IMPORT LANGUE
        picker = Gtk::FileChooserButton.new(@@lg.gt("CHOISIRFICHIER"), :open)
        picker.halign = :fill
        picker.local_only = true
        box.add( creationBoxVerticalPourVue(@@lg.gt("IMPORTERLANGUE") + " :" , picker) ) #ADD

        return box
    end
    
    ### SIGNAL CONNECTS DE INTERFACE
    # MODE SOMBRE
    private
    def switchModeSombre(s)
        Fenetre.set_modeSombre(s.active?)
    end

    ###### AUDIO 
    private
    def creationVueAudio
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>" + @@lg.gt("AUDIO") + "</span>")
        setmargin(title,15,10,0,0)
        box.add(title)
        return box
    end
    ### SIGNAL CONNECTS DE AUDIO




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

    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return nil
    end

end

=begin
FenetreParametre.afficheToi( FenetreParame tre )
Fenetre.show_all()

Gtk.main
=end