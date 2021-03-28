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
        textBuff.text = "
        Le Nurikabe (ぬりかべ) est un puzzle japonais dans le style du sudoku. Ce jeu, quelquefois appelé « ilot dans le courant », est un puzzle à résolution binaire.

        On peut décider, pour chaque cellule, si elle est blanche ou noir en fonction de règles bien précises. Le puzzle se résout sur une grille rectangulaire de cellules, dont certaines contiennent des nombres. Deux cellules sont connectées si elles sont adjacentes verticalement ou horizontalement, mais pas en diagonale. Les cellules blanches constituent les îlots alors que les cellules noires connectées constituent le fleuve. Le joueur marque d'un point les cellules sans numéro dont il est sûr qu'elles appartiennent à un îlot. 
        
                             -----------------------------------------

        Le mot Nurikabe signifie « Peindre le mur » en japonais. Cela vient en réalité d’un un démon (yokai) de la folklore japonaise. 
        
        Sa 1ère apparition dans une peinture remonterait à ce tableau de Tourin Kanou en 1802. Selon la légende, ce Yokai apparaît la nuit, bloquant le passage aux personnes qui souhaitent travers. Impossible de le contourner ni par la gauche, ni par la droite, ni de l’escalader. Le secret pour le faire disparaît est de frapper deux fois le sol à l’aide d’un bâton. 
        
        Il existe deux représentations de celui ci. La représentation sous forme d’un chien à trois yeux et ayant les oreilles tombantes est la plus ancienne. La deuxième représenta est celle d’un mur avec des jambes (et quelques fois un visage).
                
      "
        textView = Gtk::TextView.new(textBuff)
        textView.name = "text"
        textView.set_editable(false)
        textView.set_wrap_mode(Gtk::WrapMode::WORD)
        textView.justification = Gtk::Justification::LEFT
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

