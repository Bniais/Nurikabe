require './Fenetre.rb'


# Classe qui gere la fenetre 'A propos'
class FenetreAPropos < Fenetre

    def initialize() 
        self
    end

    def self.afficheToi( lastView )
        Fenetre.set_subtitle("A Propos")
        Fenetre.add( FenetreAPropos.new().creationInterface( lastView ) )
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
        textBuff = Gtk::TextBuffer.new()
        textBuff.text = "Le Nurikabe (d'un esprit du folklore japonais) est un puzzle japonais dans le style du sudoku.
      Ce jeu, quelquefois appelé 'îlot dans le courant', est un puzzle à résolution binaire. On peut décider, pour chaque cellule, si elle est blanche ou noire en fonction de certaines règles.
      Le Nurikabe est un monstre de la mythologie japonaise. Il apparaît la nuit, bloquant le passage aux personnes. Ces derniers temps, il est représenté comme un mur avec des jambes, mais sa réelle forme est un chien à trois yeux ayant les oreilles tombantes. "

        textView = Gtk::TextView.new( textBuff )
        textView.set_editable(false)
        textView.set_wrap_mode(Gtk::WrapMode::WORD)
        textView.set_width_request(700)
        setmargin(textView,80,15,70,70)
        box.add(textView)

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

