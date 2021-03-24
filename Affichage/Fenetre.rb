require 'gtk3'

# Classe abstraite qui gere l'interface
class Fenetre
    # titre de la fenetre
    attr_accessor :titre
    # application
    attr_reader :application

    private_class_method :new

    # Methode pour creer une fenetre
    def Fenetre.creer(title)
       new(title)
    end

    def Fenetre.deleteChildren()
        childs = @@window.children
        for i in 0...childs.length
            if childs.at(0) != @header
                @@window.remove( childs.at(0) )
            end
        end
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
end