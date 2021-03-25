require 'gtk3'

# Classe abstraite qui gere l'interface
class Fenetre

    @@window = nil 

    ## METHODE D'INITIALISATION
    private
    def initialize()
        @@window = Gtk::Window.new()
        @@window.set_default_size(745,671);     @@window.set_width_request(745);    @@window.set_height_request(790);   @@window.set_resizable(false) #WINDOW PARAMS
        @@window.signal_connect("destroy") { Gtk.main_quit } ## EXIT SIGNAL     #@@window.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)

        @@header = Gtk::HeaderBar.new
        @@header.show_close_button = true;      @@header.name = "headerbar" #FOR CSS
        @@header.title = "Nurikabe"     ;       @@header.subtitle = "-"
        @@window.titlebar = @@header #ADD HEADER
        puts "Initalisation terminer"
    end

    ## INITALISE UNE SEUL FOIS UNE FENETRE
    def self.initaliseToi()
        puts @@window
        if @@window == nil 
            new()
        else
            puts "Window allready initalize"
        end
    end


    ## SHOW ALL SUR WINDOW
    def self.show_all()
        if @@window == nil 
            puts "Fenetre non initaliser"
        else
            @@window.show_all
        end 
    end

    ## CHANGER LE SOUS TITRE DE LA FENETRE
    def self.set_subtitle(subtitle)
        @@window.titlebar.subtitle  = subtitle
    end

    ## AJOUTER UN ELEMENT A LE FENETRE
    def self.add(obj)
        @@window.add(obj)
    end

    ## DELETE ALL CHILD EXCEPT HEADERBAR
    def self.deleteChildren()
        childs = @@window.children
        for i in 0...childs.length
            if childs.at(0) != @@window.titlebar 
                @@window.remove( childs.at(0) )
            end
        end
    end

=begin

    # Methode pour creer une fenetre
    def Fenetre.creer(title)
       new(title)
    end

    # Methode privee pour l'initialisation
    def initialize(title)

        @application = Gtk::Window.new(title)
        @application.set_default_size(745,671)
        @application.set_height_request(790)
        @application.set_width_request(745)
        @application.set_resizable(false)
        @application.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
        # HEADERBAR
        @header = Gtk::HeaderBar.new
        @header.show_close_button = true
        @header.name = "headerbar"
        @header.subtitle = "t4est"
        @application.titlebar = @header
        @application.title = title

        listenerQuitter
        provider = Gtk::CssProvider.new
        provider.load(path: "style.css")
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
        @@window = @application
    end

        # Methode qui permet d'ouvrir la fenetre
    def ouvrir()
        @application.show_all
    end

    # Methode qui permet de fermer la fenetre
    def listenerQuitter()
        @application.signal_connect('destroy'){
            Gtk.main_quit()
        }
    end
=end

end



#####################################################

