require './Fenetre.rb'

##
# Classe qui gere la fenetre 'A propos'
#
# Herite de la classe abstraite Fenetre
class FenetreAPropos < Fenetre

    ##
    # Methode privee pour l'initialisation
    def initialize()
        self
    end

    ##
    # Methode qui permet a la fenetre de s'afficher
    def self.afficheToi( lastView )
        Fenetre.set_subtitle( @@lg.gt("A_PROPOS") )
        Fenetre.add( FenetreAPropos.new().creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end

    ##
    # Methode qui permet de creer l'interface
    def creationInterface( lastView )

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
        # EDIT HERE
        # ADD CONTENT HERE IN BOX
=begin
        textBuff = Gtk::TextBuffer.new()
        textBuff.text = @@lg.gt("APROPOSCONTENT")
        textView = Gtk::TextView.new(textBuff)
        textView.name = "text"
        textView.set_editable(false)
        textView.overwrite = false
        textView.set_wrap_mode(Gtk::WrapMode::WORD)
        textView.justification = Gtk::Justification::CENTER
         textView.set_width_request(700)
         textView.toggle_overwrite

=end

        texte = Gtk::Label.new( @@lg.gt("APROPOSCONTENT") )
        texte.justify = Gtk::Justification::CENTER
        setmargin(texte, 0, 0, 10, 10)



        box.add(texte)

        return box
    end

    ##
    # Methode qui permet de gerer les marges d'un objet donne
    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return nil
    end
end
