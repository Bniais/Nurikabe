require 'gtk3'
require_relative '../Parametres/Parametre.rb'
require_relative '../Parametres/Langue.rb'
require_relative '../Sauvegarde/Sauvegardes.rb'
require_relative '../Sauvegarde/SauvegardeGrille.rb'
require_relative '../Sauvegarde/StockageGrille.rb'

##
# Classe abstraite qui gere l'interface
# DESIGN PATTERN SINGLETON
class Fenetre
    ##
    # fenetre du jeu
    @@window = nil

    ##
    # header de la fenetre
    @@header

    ##
    # css du mode sombre
    @@cssProviderDarkMode = Gtk::CssProvider.new
    @@cssProviderDarkMode.load(path: "style_dark.css")

    ##
    # css du mode gris
    @@cssProviderGrayMode = Gtk::CssProvider.new
    @@cssProviderGrayMode.load(path: "style_gray.css")

    @@cssProviderGrayDarkMode = Gtk::CssProvider.new
    @@cssProviderGrayDarkMode.load(path: "style_gray_dark.css")

    ##
    # variable pour stocker la langue choisie par l'utilisateur
    @@lg = nil

    ##
    # Méthode d'initialisation
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

        SauvegardeGrille.creer()
        Sauvegardes.creer()

        StockageGrille.creerGrilles()
        SauvegardeGrille.getInstance.sauvegarder()

        @@lg = Sauvegardes.getInstance.getSauvegardeLangue

        provider = Gtk::CssProvider.new
        provider.load(path: "style.css")
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
        Parametre.initialiseToi

        Fenetre.set_modeSombre( Sauvegardes.getInstance.getSauvegardeParametre.modeSombre? )
    end

    ##
    # Méthode qui permet d'initialiser une seule fois une fenetre
    def self.initialiseToi()
        puts @@window
        if @@window == nil
            new()
        else
            puts "Window allready initalize"
        end
    end


    ##
    # méthode qui permet d'afficher la fenetre
    def self.show_all()
        if @@window == nil
            puts "Fenetre non initaliser"
        else
            @@window.show_all
        end
    end

    ##
    # Méthode qui permet de changer les sous-titre de la fenetre
    def self.set_subtitle(subtitle)
        @@window.titlebar.subtitle  = subtitle
    end

    ##
    # Méthode qui permet d'ajouter un element à la fenetre
    def self.add(obj)
        @@window.add(obj)
    end

    ##
    # Méthode qui permet de supprimer un element de la fenetre
    def self.remove(obj)
        @@window.remove(obj)
    end


    ##
    # Méthode qui permet de supprimer toutes les classes filles sauf la headerbar
    def self.deleteChildren()
        i = 0
        while @@window.children.length > 1
            if( @@window.children[i] == @@window.titlebar )
                i += 1
            end
            @@window.remove( @@window.children[i] )
        end
    end

    ##
    # Méthode qui dispatch le mode sombre
    def self.set_modeSombre(statut)
        provider = Gtk::CssProvider.new
        if statut

            Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderDarkMode, Gtk::StyleProvider::PRIORITY_APPLICATION)

            if(Sauvegardes.getInstance.getSauvegardeParametre.casesGrises?)
                Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayMode)
                Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayDarkMode, Gtk::StyleProvider::PRIORITY_APPLICATION)
            end
        else

            Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderDarkMode)

            if(Sauvegardes.getInstance.getSauvegardeParametre.casesGrises?)
                Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayDarkMode)
                Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayMode, Gtk::StyleProvider::PRIORITY_APPLICATION)
            end
        end
    end

    ##
    # Methode pour le mode gris
    def self.set_modeGris(statut)
        if statut
            if(Sauvegardes.getInstance.getSauvegardeParametre.modeSombre?)
                Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayDarkMode, Gtk::StyleProvider::PRIORITY_APPLICATION)
            else
                Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayMode, Gtk::StyleProvider::PRIORITY_APPLICATION)
            end
        else
            Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayMode)
            Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayDarkMode)
        end
    end


    ##
    # Méthode pour quitter
    def self.exit()
        # FAIRE DES TRUCS
        socket = Fenetre1v1.getSocket()
        if(socket!= nil)
            socket.puts("dc")
        end
        Sauvegardes.getInstance.sauvegarder()
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
