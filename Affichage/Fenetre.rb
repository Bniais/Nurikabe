require 'gtk3'
require './../Parametres/Parametre.rb'

# Classe abstraite qui gere l'interface
# DESIGN PATTERN SINGLETON
class Fenetre

    @@window = nil 
    @@cssProviderDarkMode = Gtk::CssProvider.new; @@cssProviderDarkMode.load(path: "style_dark.css")

    ## METHODE D'INITIALISATION
    private
    def initialize()
        @@window = Gtk::Window.new()
        @@window.set_default_size(745,850);     @@window.set_width_request(745);    @@window.set_height_request(850);   @@window.set_resizable(false) #WINDOW PARAMS
        @@window.signal_connect("destroy") { Fenetre.exit } ## EXIT SIGNAL     
        @@window.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)

        @@header = Gtk::HeaderBar.new
        @@header.show_close_button = true;      @@header.name = "headerbar" #FOR CSS
        @@header.title = "Nurikabe"     ;       @@header.subtitle = "-"
        @@window.titlebar = @@header #ADD HEADER

        provider = Gtk::CssProvider.new
        provider.load(path: "style.css")
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
        Parametre.initialiseToi
        Fenetre.set_modeSombre(Parametre.getInstance.modeSombre?)
    end

    ## INITALISE UNE SEUL FOIS UNE FENETRE
    def self.initialiseToi()
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

    ## SUPPRIMER UN ELEMENT A LE FENETRE
    def self.remove(obj)
        @@window.remove(obj)
    end

    
    ## DELETE ALL CHILD EXCEPT HEADERBAR
    def self.deleteChildren()
        i = 0
        while @@window.children.length > 1
            if( @@window.children[i] == @@window.titlebar )
                i += 1
            end
            @@window.remove( @@window.children[i] )
        end
    end

    def self.set_modeSombre(statut)
        provider = Gtk::CssProvider.new
        if statut 
            Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderDarkMode, Gtk::StyleProvider::PRIORITY_APPLICATION)
        else
            Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderDarkMode)
        end
    end

    ## SE QUITTER
    def self.exit()
        # FAIRE DES TRUCS 
        Gtk.main_quit
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

################## INITALISATION DE LA FENETRE ###################################
Fenetre.initialiseToi()
Parametre.initialiseToi()