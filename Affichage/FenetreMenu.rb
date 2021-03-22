load "Fenetre.rb"
load "../Partie/Mode.rb"
load "../Partie/Difficulte.rb"
require "gtk3"

Gtk.init

# Classe qui gere la fenetre du menu
class FenetreMenu < Fenetre

    # Methode privee pour l'initialisation
   def initialize(title)
        super(title)
        @viewOne = creerViewOne()
        @viewContreLaMontre = creerViewContreLaMontre()
        @viewSurvie = creerViewSurvie()
        @fenetreAPropos = creerViewAPropos()
        @mode = nil
        @difficulte = nil
    end

    # Methode qui permet de quitter l'application
    def detruire()
        puts "Fin de l'application"
        Gtk.main_quit()
    end

    # Methode d'affichage
    def afficheToi()
        # creation de la box principale
        @mainBox = Gtk::Box.new(:vertical, 0)

       # creation du label pour le titre
        titre = Gtk::Label.new()
        titre.set_markup("<span weight = 'ultrabold' size = '100000' >Nurikabe</span>")
        setmargin(titre,0,0,70,70)
        @mainBox.pack_start(titre)

        # ajout des 3 vues à la fenêtre
        @mainBox.pack_start(@viewOne)
        @mainBox.pack_start(@viewContreLaMontre)
        @mainBox.pack_start(@viewSurvie)

        # quitter quand la fenetre est detruite
        @application.signal_connect("destroy") { detruire() }

        @application.add(@mainBox)
        self.ouvrir()

        # cacher les vues contre-la-montre et survie par defaut
        @viewContreLaMontre.hide()
        @viewSurvie.hide()
        @fenetreAPropos.hide()
    end

    # Methode qui permet de creer la vue 1
    def creerViewOne()
        box = Gtk::Box.new(:vertical, 10)

        # creation de la grille avec les boutons de modes
        modes = Gtk::Grid.new()

        # creation des boutons de mode de jeu
        btnLibre = Gtk::Button.new()
        setBold(btnLibre,"Libre")
        setmargin(btnLibre,0,15,70,70)

        btnContre = Gtk::Button.new()
        setBold(btnContre,"Contre-la-montre")
        setmargin(btnContre,0,15,70,70)

        btnSurvie = Gtk::Button.new()
        setBold(btnSurvie,"Survie")
        setmargin(btnSurvie,0,15,70,70)

        btnTuto = Gtk::Button.new()
        setBold(btnTuto,"Tutoriel")
        setmargin(btnTuto,0,15,70,70)

        # gestion des évènements
        btnLibre.signal_connect("clicked") do
            puts "click libre"
            @mode = Mode::LIBRE
        end
        btnContre.signal_connect("clicked") do
            puts "click contre-la-montre"
            @viewOne.set_visible(false)
            @viewContreLaMontre.set_visible(true)
            @mode = Mode::CONTRE_LA_MONTRE
        end
        btnSurvie.signal_connect("clicked") do
            puts "click survie"
            @viewOne.set_visible(false)
            @viewSurvie.set_visible(true)
            @mode = Mode::SURVIE
        end
        btnTuto.signal_connect("clicked") do
            puts "click tuto"
            @mode = Mode::TUTORIEL
        end

        # attachement des boutons de mode de jeu
        modes.attach(btnLibre, 0, 0, 1, 1)
        modes.attach(btnContre, 0, 1, 1, 1)
        modes.attach(btnSurvie, 0, 2, 1, 1)
        modes.attach(btnTuto, 0, 3, 1, 1)
        modes.set_column_homogeneous(true)
        box.pack_start(modes)


        # ajout des boutons du bas
        ajouterBtnBas(box)
        return box
    end

    # Methode qui permet de creer la vue pour les choix contre-la-montre
    def creerViewContreLaMontre()
        box = Gtk::Box.new(:vertical, 10)

        # creation de la grille avec les boutons de modes
        modes = Gtk::Grid.new()

        # creation des boutons de mode de jeu
        btnLibre = Gtk::Button.new()
        setBold(btnLibre,"Libre")
        setmargin(btnLibre,0,15,70,70)

        btnContre = Gtk::Button.new()
        setBold(btnContre,"Contre-la-montre")
        setmargin(btnContre,0,15,70,70)

        gridContreLaMontre = Gtk::Grid.new()
        # creation des boutons de choix de niveaux
        btnFacile = Gtk::Button.new()
        setBold(btnFacile,"Facile")
        setmargin(btnFacile,0,15,70,15)
        btnFacile.set_width_request(215)

        btnMoyen = Gtk::Button.new()
        setBold(btnMoyen,"Moyen")
        setmargin(btnMoyen,0,15,15,15)
        btnMoyen.set_width_request(215)

        btnDifficile = Gtk::Button.new()
        setBold(btnDifficile,"Difficile")
        setmargin(btnDifficile,0,15,15,70)
        btnDifficile.set_width_request(215)

        # attachement des boutons de choix de niveaux
        gridContreLaMontre.attach(btnFacile,    0, 0, 1, 1)
        gridContreLaMontre.attach(btnMoyen,     1, 0, 1, 1)
        gridContreLaMontre.attach(btnDifficile, 2, 0, 1, 1)

        btnSurvie = Gtk::Button.new()
        setBold(btnSurvie,"Survie")
        setmargin(btnSurvie,0,15,70,70)

        btnTuto = Gtk::Button.new()
        setBold(btnTuto,"Tutoriel")
        setmargin(btnTuto,0,15,70,70)

        # gestion des évènements
        btnLibre.signal_connect("clicked") do
            puts "click libre"
            @mode = Mode::LIBRE
        end
        btnContre.signal_connect("clicked") do
            puts "click contre-la-montre"
            @view.set_visible(false)
            @viewContreLaMontre.set_visible(true)
            @mode = Mode::CONTRE_LA_MONTRE
        end
        btnSurvie.signal_connect("clicked") do
            puts "click survie"
            @viewContreLaMontre.set_visible(false)
            @viewSurvie.set_visible(true)
            @mode = Mode::SURVIE
        end
        btnTuto.signal_connect("clicked") do
            puts "click tuto"
            @mode = Mode::TUTORIEL
        end

        # attachement des boutons de mode de jeu
        modes.attach(btnLibre, 0, 0, 1, 1)
        modes.attach(gridContreLaMontre, 0, 1, 1, 1)
        modes.attach(btnSurvie, 0, 2, 1, 1)
        modes.attach(btnTuto, 0, 3, 1, 1)
        modes.set_column_homogeneous(true)

        box.pack_start(modes)

        ajouterBtnBas(box)
        return box
    end

    # Methode qui permet de creer la vue pour les choix survie
    def creerViewSurvie()
        box = Gtk::Box.new(:vertical, 10)

        # creation de la grille avec les boutons de modes
        modes = Gtk::Grid.new()

        # creation des boutons de mode de jeu
        btnLibre = Gtk::Button.new()
        setBold(btnLibre,"Libre")
        setmargin(btnLibre,0,15,70,70)

        btnContre = Gtk::Button.new()
        setBold(btnContre,"Contre-la-montre")
        setmargin(btnContre,0,15,70,70)

        gridSurvie = Gtk::Grid.new()
        # creation des boutons de choix de niveaux
        btnFacile = Gtk::Button.new()
        setBold(btnFacile,"Facile")
        setmargin(btnFacile,0,15,70,15)
        btnFacile.set_width_request(215)

        btnMoyen = Gtk::Button.new()
        setBold(btnMoyen,"Moyen")
        setmargin(btnMoyen,0,15,15,15)
        btnMoyen.set_width_request(215)

        btnDifficile = Gtk::Button.new()
        setBold(btnDifficile,"Difficile")
        setmargin(btnDifficile,0,15,15,70)
        btnDifficile.set_width_request(215)

        # attachement des boutons de choix de niveaux
        gridSurvie.attach(btnFacile,    0, 0, 1, 1)
        gridSurvie.attach(btnMoyen,     1, 0, 1, 1)
        gridSurvie.attach(btnDifficile, 2, 0, 1, 1)

    #    gridSurvie.set_row_homogeneous(true)
     #   gridSurvie.set_column_homogeneous(true)

        btnContre = Gtk::Button.new()
        setBold(btnContre,"Contre-la-montre")
        setmargin(btnContre,0,15,70,70)

        btnTuto = Gtk::Button.new()
        setBold(btnTuto,"Tutoriel")
        setmargin(btnTuto,0,15,70,70)

        # gestion des évènements
        btnLibre.signal_connect("clicked") do
            puts "click libre"
            @mode = Mode::LIBRE
        end
        btnContre.signal_connect("clicked") do
            puts "click contre-la-montre"
            @viewSurvie.set_visible(false)
            @viewContreLaMontre.set_visible(true)
            @mode = Mode::CONTRE_LA_MONTRE
        end
        btnTuto.signal_connect("clicked") do
            puts "click tuto"
            @mode = Mode::TUTORIEL
        end

        #  ligne - colonne
        # attachement des boutons de mode de jeu
        modes.attach(btnLibre, 0, 0, 1, 1)
        modes.attach(btnContre, 0, 1, 1, 1)
        modes.attach(gridSurvie, 0, 2, 1, 1)
        modes.attach(btnTuto, 0, 3, 1, 1)
        modes.set_column_homogeneous(true)
        box.pack_start(modes, :expand => true, :fill => true)

        ajouterBtnBas(box)
        return box
    end

    # Methode qui permet d'ajouter les boutons 'parametres', 'a propos' et 'quitter'
    def ajouterBtnBas(box)
        btnClassement = Gtk::Button.new(:label => "Classement")
        btnClassement.set_height_request(60)
        setmargin(btnClassement,15,15,70,70)

        # AJOUT SEPARATEUR
        monSeparateur = Gtk::Separator.new(:horizontal)
        setmargin(monSeparateur,0,0,80,80)
        box.pack_start( monSeparateur )

        box.pack_start(btnClassement)

        # AJOUT SEPARATEUR
        monSeparateur = Gtk::Separator.new(:horizontal)
        setmargin(monSeparateur,0,0,80,80)
        box.pack_start( monSeparateur )

        grilleBas = Gtk::Grid.new()
        setmargin(grilleBas,15,0,70,70)

        # creation des boutons
        btnParam = Gtk::Button.new(:label => "Paramètres")
        btnParam.set_height_request(60)
        btnAPropos = Gtk::Button.new(:label => "A propos")
        labelBtnQuit = Gtk::Label.new()

        labelBtnQuit.set_markup("<span foreground='#a4a400000000' >Quitter</span>");
        btnQuit = Gtk::Button.new()
        btnQuit.add(labelBtnQuit)
        btnQuit.signal_connect("clicked"){ detruire() }

        # attachement des boutons
        grilleBas.attach(btnParam, 0, 0, 1, 1)
        grilleBas.attach(btnAPropos, 1, 0, 1, 1)
        grilleBas.attach(btnQuit, 2, 0, 1, 1)

        grilleBas.set_column_homogeneous(true)
        box.pack_start(grilleBas, :expand => true, :fill => true)
    end

    # Methode qui renvoie le mode choisi par l'utilisateur
    def getMode()
        return @mode
    end

    # Methode qui renvoie le niveau de difficulte choisi par l'utilisateur
    def getDifficulte()
        return @difficulte
    end

    # Methode qui renvoie la grille choisie par l'utilisateur
    def listenerChoixGrille()
        #
    end

    # Methode qui permet d'ouvrir la fenetre des parametres
    def listenerOuvrirOption()

    end

    # Methode qui permet d'ouvrir la fenetre 'A propos'
    def creerViewAPropos()
        @fenetreAPropos.afficheToi()
    end

    # Methode qui permet de quitter la fenetre de menu
    def listenerQuitter()

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
end



##################### CODE DE TEST DE LA CLASSE #####################

fenetreMenu = FenetreMenu.creer("Nurikabe")
fenetreMenu.afficheToi()


Gtk.main