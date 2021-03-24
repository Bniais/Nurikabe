
# Classe qui gere la fenetre des parametres
class FenetreParametre
    # sauvegarde des parametres
    attr_reader :sauvegardeParametre

    attr_accessor :view

    private_class_method :new

    def FenetreParametre.creer(menuPrincipal)
        new(menuPrincipal)
    end

    def initialize(menuPrincipal)
        @menuPrincipal = menuPrincipal
        @view = creerViewParametre()
        puts "View parametres initialise"
    end

    def creerViewParametre()
        box = Gtk::Box.new(:vertical, 10)
        box.set_width_request(745)

        grille = Gtk::Grid.new()

        labelBtnRetour = Gtk::Label.new()
        labelBtnRetour.set_markup("<span foreground='#a4a400000000' >Retour</span>");
        # creation du bouton de retour
        @btnRetour = Gtk::Button.new()
        @btnRetour.add(labelBtnRetour)
        setmargin(@btnRetour,20,15,70,70)
        @btnRetour.set_height_request(40)

        @btnRetour.signal_connect("clicked") do
            @menuPrincipal.changerVue(@menuPrincipal.indexCourant, FenetreMenu::MENU)
        end

        grille.attach(@btnRetour, 0, 0, 1, 1)

        # creation du menu
        menu = Gtk::Box.new(:vertical, 0)
        tabLabels = ['Jeu', 'Utilisateur', 'Interface', 'Audio']
        listeBtn = Array.new()
        x = 0

        # creation des boutons du menu
        for y in 0..7
                if(y%2 == 0)
                    listeBtn << Gtk::Button.new(:label => tabLabels.at(x))
                    # setmargin(listeBtn.at(x), 0, 1, 0, 70)
                    listeBtn.at(x).set_height_request(50)
                    listeBtn.at(x).set_width_request(150)
                    menu.pack_start(listeBtn.at(x))
                    x = x + 1
                else
                    separateur = Gtk::Separator.new(:horizontal)
                    menu.pack_start(separateur)
                end
        end

        # attach(widget, left, top, width, height)
        grille.attach(menu, 0, 1, 1, 1)

        textBuff = Gtk::TextBuffer.new()
        textBuff.text = "affichage a venir"

        textView = Gtk::TextView.new()
        textView.set_buffer(textBuff)
        textView.set_editable(false)
        textView.set_wrap_mode(Gtk::WrapMode::WORD)
        # textView.set_width_request(700)
        # setmargin(textView,80,15,70,70)
        grille.attach(textView, 1, 1, 1, 1)

        box.pack_start(grille)

        return box
    end

     def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return nil
    end

    # Methode qui permet de mettre en gras un label
    def setBold(btn, nom)
        label = Gtk::Label.new()
        label.set_markup("<span weight = 'ultrabold'>"+nom+"</span>")
        btn.add(label)
        btn.set_height_request(70)
    end

    # Methode qui permet de creer une nouvelle sauvegarde de parametres
    def creer(parametres)
        #
    end

    # Methode qui renvoie l'option choisi par l'utilisateur pour les cases grises
    def listenerSwitchCaseGrise()
        #
    end

    # Methode qui renvoie l'option choisi par l'utilisateur pour le compteur des ilots
    def listenerSwitchCompteurIlot()
        #
    end

    # Methode qui renvoie l'option choisi par l'utilisateur pour l'affichage de la portee
    def listenerSwitchAfficherPortee()
        #
    end

    # Methode qui renvoie l'option choisi par l'utilisateur pour le comportement du clic a la souris
    def listenerComportementSouris()
        #
    end

    # Methode qui renvoie la langue choisie par l'utilisateur
    def listenerChangerLangue()
        #
    end

    # Methode qui renvoie la valeur du volume choisie par l'utilisateur
    def listenerChangerVolume()
        #
    end

    # Methode qui permet d'aller a l'onglet 'Jeu'
    def listenerOngletJeu()
        #
    end

    # Methode qui permet d'aller a l'onglet 'Interface'
    def listenerOngletInterface()
        #
    end

    # Methode qui permet d'aller a l'onglet 'Audio'
    def listenerOngletAudio()
        #
    end

    # Methode.............
    def listenerRetourArriere()
        #
    end
end