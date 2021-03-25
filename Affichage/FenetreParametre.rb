require './Fenetre.rb'

class FenetreParametre < Fenetre


    def initialize()
        self
    end

    def self.initaliseToi()
        new()
    end

    def afficheToi()
        Fenetre.deleteChildren
        Fenetre.add( creationInterface )
        Fenetre.show_all
        return self
    end

    def creationInterface()
        box = Gtk::Box.new(:vertical)

        # BACK BUTTON
        btnBoxH = Gtk::ButtonBox.new(:horizontal)
        btnBoxH.layout = :start
        btnBack = Gtk::Button.new(:label => "BACK")
        setmargin(btnBack,5,5,5,0)
        btnBoxH.add(btnBack)
        box.add(btnBoxH) #ADD
        
        # SEPARATOR
        box.add( Gtk::Separator.new(:vertical) ) #ADD

        # VUE PRINCIPAL
        box.add( creationStack ) #ADD    

        return box
    end

    def creationStack
        box = Gtk::Box.new(:horizontal)
        sidebar = Gtk::StackSidebar.new
        sidebar.set_width_request(160)
        sidebar.set_height_request(650)
        sidebar.name = "sidebar"
        box.pack_start(sidebar, :expand => false, :fill => false, :padding => 0)

        stack = Gtk::Stack.new
        stack.transition_type = :slide_up_down
        sidebar.stack = stack

        widget = Gtk::Separator.new(:vertical)
        box.pack_start(widget, :expand => false, :fill => false, :padding => 0)

        box.pack_start(stack, :expand => true, :fill => true, :padding => 0)

        pages = ["Jeu","Utilisateur","Interface","Audio"]

        # Jeu
        title = "Jeu"
        vueJeu = creationVueJeu
        stack.add_named(vueJeu, title) # ADD NAMED CHILDREN
        stack.child_set_property(vueJeu, "title", title) # SET A TITLE TO A CHILDREN

        # Utilisateur
        title = "Utilisateur"
        vueUtilisateur = creationVueUtilisateur
        stack.add_named(vueUtilisateur, title)
        stack.child_set_property(vueUtilisateur, "title", title)   
       
        # Interface
        title = "Interface"
        vueInterface = creationVueInterface
        stack.add_named(vueInterface, title)
        stack.child_set_property(vueInterface, "title", title)   

        # AUDIO
        title = "Audio"
        vueAudio = creationVueAudio
        stack.add_named(vueAudio, title)
        stack.child_set_property(vueAudio, "title", title)
        return box
    end

    ###### JEU 
    def creationVueJeu
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>Jeu</span>")
        setmargin(title,15,10,0,0)

        box.add(title) #ADD

        # AIDE CASES GRISES
        switch = Gtk::Switch.new()
        switch.halign = :start
        switch.signal_connect('notify::active') { |s| switchAideCasesGrises(s) }
        box.add( creationBoxVerticalPourVue("Cases grises :" , switch) ) #ADD
        
        # AIDE COMPTEUR D'ILOT
        switch = Gtk::Switch.new()
        switch.halign = :start
        switch.signal_connect('notify::active') { |s| switchAideCompteurIlot(s) }
        box.add( creationBoxVerticalPourVue("Compteur d'ilot :" , switch) ) #ADD

        # AIDE AFFICHAGE PORTEE
        switch = Gtk::Switch.new()
        switch.halign = :start
        switch.signal_connect('notify::active') { |s| switchAideAffichagePortee(s) }
        box.add( creationBoxVerticalPourVue("Affichage portee :" , switch) ) #ADD

        # AIDE MURS 2x2
        switch = Gtk::Switch.new()
        switch.halign = :start
        switch.signal_connect('notify::active') { |s| switchAideMurs2x2(s) }
        box.add( creationBoxVerticalPourVue("Murs 2x2 :" , switch) ) #ADD
        return box
    end
    ### SIGNAL CONNECTS DE JEU
    # AIDE CASES GRISES
    def switchAideCasesGrises(s)
        puts s
    end 
    # AIDE COMPTEUR ILOT
    def switchAideCompteurIlot(s)
        puts s
    end 
    # AIDE AFFICHAGE PORTEE
    def switchAideAffichagePortee(s)
        puts s
    end 
    # AIDE MURS 2x2
    def switchAideMurs2x2(s)
        puts s
    end 

    ###### UTILISATEUR 
    def creationVueUtilisateur
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>Utilisateur</span>")
        setmargin(title,15,10,0,0)
        box.add(title)
        return box
    end
    ### SIGNAL CONNECTS DE UTILISATEUR

    ###### INTERFACE 
    def creationVueInterface
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>Interface</span>")
        setmargin(title,15,10,0,0)

        box.add(title) #ADD

        # DARK MORD
        switch = Gtk::Switch.new()
        switch.halign = :start
        switch.signal_connect('notify::active') { |s| switchModeSombre(s) }
        box.add( creationBoxVerticalPourVue("Mode sombre :" , switch) ) #ADD

        # CHOOSE LANGUE
        combo = Gtk::ComboBoxText.new()
        combo.halign = :fill
        combo.append("FR_fr","Francais")
        combo.set_active(0)
        box.add( creationBoxVerticalPourVue("Choisir une langue :" , combo) ) #ADD
        
        # IMPORT LANGUE
        picker = Gtk::FileChooserButton.new("Pick a file", :open)
        picker.halign = :fill
        picker.local_only = true
        box.add( creationBoxVerticalPourVue("Importer une langue :" , picker) ) #ADD

        return box
    end
    ### SIGNAL CONNECTS DE INTERFACE
    # MODE SOMBRE
    def switchModeSombre(s)
        provider = Gtk::CssProvider.new
        if s.active? 
            provider.load(path: "style_dark.css")
        else
            provider.load(path: "style.css") 
        end
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
    end

    ###### AUDIO 
    def creationVueAudio
        box = Gtk::Box.new(:vertical)
        title = Gtk::Label.new()
        title.set_markup("<span size='25000'>Audio</span>")
        setmargin(title,15,10,0,0)
        box.add(title)
        return box
    end
    ### SIGNAL CONNECTS DE AUDIO




    # Permet de creer un element nom + objet
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

    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return nil
    end

end


Fenetre.initaliseToi()

maFenetreParametre = FenetreParametre.initaliseToi
maFenetreParametre.afficheToi
Fenetre.set_subtitle("Parametre")


Fenetre.show_all()

Gtk.main