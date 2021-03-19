load "Fenetre.rb"
require "gtk3"

Gtk.init

# Classe qui gere la fenetre du menu
class FenetreMenu < Fenetre

    # Methode privee pour l'initialisation
   def initialize(title)
        super(title)
        @viewOne = creerViewOne()
        @viewTwo = creerViewTwo(false)
        @viewThree = creerViewThree(false)
    end

    # Methode qui permet de quitter l'application
    def detruire()
        puts "Fin de l'application"
        Gtk.main_quit()
    end

    # Methode d'affichage
    def afficheToi()
        # creation de la box principale
        @mainBox = Gtk::Box.new(:vertical, 10)

       # creation du label pour le titre
        titre = Gtk::Label.new("Nurikabe")
        @mainBox.pack_start(titre, :expand => true, :fill => true)

        # ajout des 3 vues à la fenêtre
        @mainBox.pack_start(@viewOne, :expand => true, :fill => true)
        @mainBox.pack_start(@viewTwo, :expand => true, :fill => true)
        @mainBox.pack_start(@viewThree, :expand => true, :fill => true)

        # quitter quand la fenetre est detruite
        @application.signal_connect("destroy") { detruire() }

        @application.add(@mainBox)
        self.ouvrir()

        # cacher les vues 2 et 3 par defaut
        @viewTwo.hide()
        @viewThree.hide()
    end

    # Methode qui permet de creer la vue 1
    def creerViewOne()
        box = Gtk::Box.new(:vertical, 10)
        # creation de la grille avec les boutons de modes
        modes = Gtk::Grid.new()
        # creation des boutons de mode de jeu
        btnLibre = Gtk::Button.new(:label => "Libre")
        btnContre = Gtk::Button.new(:label => "Contre-la-montre")
        btnSurvie = Gtk::Button.new(:label => "Survie")

        # gestion des évènements
        btnLibre.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end
        btnContre.signal_connect("clicked") do
            puts "click contre-la-montre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end
        btnSurvie.signal_connect("clicked") do
            puts "click survie"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end

        # attachement des boutons de mode de jeu
        modes.attach(btnLibre, 0, 0, 1, 1)
        modes.attach(btnContre, 1, 0, 1, 1)
        modes.attach(btnSurvie, 2, 0, 1, 1)
        modes.set_column_homogeneous(true)
        box.pack_start(modes, :expand => true, :fill => true)

        # ajout du bouton de classement
        box.pack_start(Gtk::Button.new(:label => "Classement"), :expand => true, :fill => true)

        # ajout des boutons du bas
        ajouterBtnBas(box)
        return box
    end

    # Methode qui permet de creer la vue 2
    def creerViewTwo(bool)
        box = Gtk::Box.new(:vertical, 10)
        # creation de la grille avec les boutons de modes
        niveaux = Gtk::Grid.new()
        # creation des boutons de choix de niveaux
        btnFacile = Gtk::Button.new(:label => "Facile")
        btnMoyen = Gtk::Button.new(:label => "Moyen")
        btnDifficile = Gtk::Button.new(:label => "Difficile")
        btnRetour = Gtk::Button.new(:label => "Retour")

        # gestion des évènements
        btnFacile.signal_connect("clicked") do
            puts "click facile"
            @viewTwo.set_visible(false)
            @viewThree.set_visible(true)
        end
        btnMoyen.signal_connect("clicked") do
            puts "click moyen"
            @viewTwo.set_visible(false)
            @viewThree.set_visible(true)
        end
        btnDifficile.signal_connect("clicked") do
            puts "click difficile"
            @viewTwo.set_visible(false)
            @viewThree.set_visible(true)
        end
        btnRetour.signal_connect("clicked") do
            puts "retour clique"
            @viewTwo.set_visible(false)
            @viewOne.set_visible(true)
        end

        # attachement des boutons de choix de niveaux
        niveaux.attach(btnFacile, 0, 0, 1, 1)
        niveaux.attach(btnMoyen, 1, 0, 1, 1)
        niveaux.attach(btnDifficile, 2, 0, 1, 1)
        niveaux.attach(btnRetour, 3, 0, 1, 1)
        niveaux.set_column_homogeneous(true)
        box.pack_start(niveaux, :expand => true, :fill => true)

        # ajout du bouton de classement
        box.pack_start(Gtk::Button.new(:label => "Classement"), :expand => true, :fill => true)

        # ajout des boutons du bas
        ajouterBtnBas(box)
        box.hide()
        return box
    end

    # Methode qui permet de creer la vue 3
    def creerViewThree(bool)
        box = Gtk::Box.new(:vertical, 10)
        # creation de la grille avec les boutons de modes
        btnLancement = Gtk::Button.new(:label => "Lancer une partie")
        box.pack_start(btnLancement, :expand => true, :fill => true)

        # ajout du bouton de classement
        box.pack_start(Gtk::Button.new(:label => "Classement"), :expand => true, :fill => true)

        # ajout des boutons du bas
        ajouterBtnBas(box)
        box.set_visible(bool)
        return box
    end

    # Methode qui permet d'ajouter les boutons 'parametres', 'a propos' et 'quitter'
    def ajouterBtnBas(box)
        grilleBas = Gtk::Grid.new()
        # creation des boutons
        btnParam = Gtk::Button.new(:label => "Paramètres")
        btnAPropos = Gtk::Button.new(:label => "A propos")
        btnQuit = Gtk::Button.new(:label => "Quitter")
        btnQuit.signal_connect("clicked"){ detruire() }
        # attachement des boutons
        grilleBas.attach(btnParam, 0, 0, 1, 1)
        grilleBas.attach(btnAPropos, 1, 0, 1, 1)
        grilleBas.attach(btnQuit, 2, 0, 1, 1)
        grilleBas.set_column_homogeneous(true)
        box.pack_start(grilleBas, :expand => true, :fill => true)
    end

    # Methode qui renvoie le mode choisi par l'utilisateur
    def listenerChoixMode()
        #
    end

    # Methode qui renvoie le niveau de difficulte choisi par l'utilisateur
    def listenerChoixDifficulte()
        #
    end

    # Methode qui renvoie la grille choisie par l'utilisateur
    def listenerChoixGrille()
        #
    end

    # Methode qui permet d'ouvrir la fenetre des parametres
    def listenerOuvrirOption()

    end

    # Methode qui permet d'ouvrir la fenetre 'A propos'
    def listenerOuvrirAPropos()

    end

    # Methode qui permet de quitter la fenetre de menu
    def listenerQuitter()

    end
end



##################### CODE DE TEST DE LA CLASSE #####################

fenetreMenu = FenetreMenu.new("Nurikabe")
fenetreMenu.afficheToi()


Gtk.main