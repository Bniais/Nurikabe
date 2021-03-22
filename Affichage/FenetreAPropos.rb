load "Fenetre.rb"
require "gtk3"

# Classe qui gere la fenetre 'A propos'
class FenetreAPropos < Fenetre
    # Constructeur de la fenetre A Propos
    def initialize(uneFenetre)
        @maFenetre = uneFenetre
    end

    # methode initialize dans methode creeToi
    # def creeToi(uneFenetre)
    #     new(uneFenetre)
    # end

    def afficheToi()
        # BOX VERTICAL
        vbox = Gtk::VBox.new(false, 3)

        headBar = Gtk::HeaderBar.new()
        headBar.set_title("Nurikabe")
        headBar.set_subtitle("A propos")
        headBar.set_show_close_button(true)
        vbox.add(headBar)
        # BACK BTN
        btnBack = Gtk::Button.new("Retour")
        btnBack.set_margin(5)
        btnBack.set_margin_right(0)
        puts btnBack.alignment()
        vbox.pack_start(btnBack)

        # TextView
        scroll = Gtk::ScrolledWindow.new( )
        scroll.set_height_request( 623 )

        textBuff = Gtk::TextBuffer.new()
        textView = Gtk::TextView.new( textBuff )
        textView.set_editable(false)
        scroll.add( textView )

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
window = Gtk::Window.new()
window.set_margin(0)
window.set_border_width(0)
window.set_size_request(740, 715)
window.set_border_width(10)

fenetre = FenetreAPropos.creer("A propos")
fenetre.afficheToi()


Gtk.main
