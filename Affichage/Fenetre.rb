require 'gtk3'

# Classe abstraite qui gere l'interface
class Fenetre 
    # titre de la fenetre
    attr_accessor :titre
    # application
    attr_reader :application


    # Methode pour creer une fenetre
    def creer(title)

        @menu = Gtk::Window.new(title)
        @menu.set_default_size(745,671)
        @menu.set_resizable(false)
        
    end

    # Methode qui permet d'ouvrir la fenetre
    def ouvrir()
        @menu.show_all
    end

    # Methode qui permet de fermer la fenetre
    def listenerQuitter()

        @menu.signal_connect('destroy'){
            Gtk.main_quit()
        }
        
    end
end
