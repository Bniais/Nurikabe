require './Fenetre.rb'


# Classe qui gere la fenetre 'A propos'
class FenetreAPropos < Fenetre

    def initialize() 
        self
    end

    def self.afficheToi( lastView )
        Fenetre.set_subtitle( @@lg.gt("APROPOS") )
        Fenetre.add( FenetreAPropos.new().creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end

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
        textBuff = Gtk::TextBuffer.new()
        textBuff.text = @@lg.gt("APROPOSCONTENT")
        textView = Gtk::TextView.new(textBuff)
        textView.name = "text"
        textView.set_editable(false)
        textView.set_wrap_mode(Gtk::WrapMode::WORD)
        textView.justification = Gtk::Justification::CENTER
        # textView.set_width_request(700)
        #setmargin(textView,80,15,70,70)

        scroll = Gtk::ScrolledWindow.new();
        scroll.set_size_request(200, 700)
        # setmargin(scroll,80,15,70,70)
        scroll.add_with_viewport(textView);

        box.add(scroll)

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

