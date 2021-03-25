require './Fenetre.rb'


# Classe qui gere la fenetre 'A propos'
class FenetreClassement < Fenetre

    def initialize() 
        self
    end

    def self.afficheToi( lastView )
        Fenetre.set_subtitle("Classement")
        Fenetre.add( FenetreClassement.new().creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end

    def creationInterface( lastView )

        box = Gtk::Box.new(:vertical)

        # BACK BUTTON
        btnBoxH = Gtk::ButtonBox.new(:horizontal)
        btnBoxH.layout = :start
        btnBack = Gtk::Button.new(:label => "BACK")
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
        bestscore = Gtk::Label.new()
        bestscore.set_markup("<span weight = 'ultrabold' size = '10000' >Meilleur score: </span>")
        
        
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

