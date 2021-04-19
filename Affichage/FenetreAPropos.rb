require_relative './Fenetre.rb'

##
# Classe qui gère la création de l'interface de la fenêtre 'A propos'
# Herite de la classe Fenetre
class FenetreAPropos < Fenetre

    ##
    # Methode pour l'initialisation
    def initialize()
        self
    end

    ##
    # Fait s'afficher la fenêtre à propos
    def self.afficheToi( lastView )
        Fenetre.set_subtitle( @@lg.gt("A_PROPOS") )
        Fenetre.add( FenetreAPropos.new().creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end

    ##
    # Crée l'interface de la fenêtre à propos
    def creationInterface( lastView )

        box = Gtk::Box.new(:vertical)

        #Bouton retour
        btnBoxH = Gtk::ButtonBox.new(:horizontal)
        btnBoxH.layout = :start
        btnBack = Gtk::Button.new(:label => @@lg.gt("RETOUR"))
        btnBack.name = "btnBack"
        btnBack.signal_connect("clicked") { Fenetre.remove(box) ; lastView.afficheToi( nil ) ; }
        lastView == nil ? btnBack.set_sensitive(false) : btnBack.set_sensitive(true)
        setmargin(btnBack,5,5,5,0)
        btnBoxH.add(btnBack)
        box.add(btnBoxH)

        #Separateur
        box.add( Gtk::Separator.new(:vertical) )

        #Texte à propos
        texte = Gtk::Label.new( @@lg.gt("APROPOSCONTENT") )
        texte.justify = Gtk::Justification::CENTER
        setmargin(texte, 0, 0, 10, 10)



        box.add(texte)

        return box
    end

    ##
    # Met des marges à un objet
    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return nil
    end
end
