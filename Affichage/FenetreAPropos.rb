load "Fenetre.rb"
require "gtk3"

# Classe qui gere la fenetre 'A propos'
class FenetreAPropos < Fenetre


    # Constructeur de la fenetre A Propos
    def initialize(uneFenetre)
        @maFenetre = uneFenetre
    end
    
    # methode initialize dans methode creeToi
    def creeToi(uneFenetre)
        new(uneFenetre)
    end

    def afficheToi()
        # BOX VERTICAL
        vbox = Gtk::VBox.new(false, 2)
        # BACK BTN
        btnBack = Gtk::Button.new("Salut")
        btnBack.set_alignment(0.0,0.0)
        vbox.pack_start(btnBack)

        # TextView
        scroll = Gtk::ScrolledWindow.new( )
        scroll.set_height_request( 623 )
        scroll.add( Gtk::TextView.new() )
        vbox.pack_start(scroll)

        # ADD VBOX
        @maFenetre.add(vbox)
        @maFenetre.signal_connect("delete-event") { |_widget| Gtk.main_quit }
        @maFenetre.show_all()
    end

    # Methode qui permet de revenir a la fenetre precedente
    def listenerRetourArriere()
        #
    end

end



## CODE DE TEST DE LA CLASS
window = Gtk::Window.new("First example")
window.set_size_request(740, 715)
window.set_border_width(10)

fenetre = FenetreAPropos.new(window)
fenetre.afficheToi()



Gtk.main