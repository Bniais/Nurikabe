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
        bestscore = Gtk::Label.new("Meilleur score: ")
        box.add(bestscore)

        menu = Gtk::Grid.new()
        refresh = Gtk::Button.new("Actualiser")
        choixGrille = Gtk::ComboBoxText.new()
        choixGrille.append_text("Survie")
        choixGrille.append_text("Contre-la-montre")
        choixGrille.append_text("Grille #F11") # Ajouter les différentes grilles du mode Libre
        menu.attach(refresh,0,0,2,1)
        menu.attach(choixGrille,2,0,1,1)

        box.add(menu)

        affScores = Gtk::Grid.new()
        textBuff = Gtk::TextBuffer.new()
        textBuff.text = "1337" # Ici le score du joueur
        score = Gtk::TextView.new(textBuff)
        affScores.attach(score,0,0,1,1)

        box.add(affScores)


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

