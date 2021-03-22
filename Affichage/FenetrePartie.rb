load "Fenetre.rb"

# Classe qui gere la fenetre pendant la partie
class FenetrePartie < Fenetre
    # grille de la partie actuelle
    attr_accessor :grille
    # ensembles des sons (effets sonores) de la partie
    attr_accessor :son
    # parametres personnalises par l'utilisateur
    attr_accessor :parametre


    # Methode qui permet de creer une nouvelle partie
    def creer()
         # creation de la box principale
         @mainBox = Gtk::Box.new(:vertical, 10)

         # creation du label pour le titre
          titre = Gtk::Label.new("Partie libre")
          @mainBox.pack_start(titre, :expand => true, :fill => true)

          # ajout des 3 vues à la fenêtre
          @mainBox.pack_start(@viewOne, :expand => true, :fill => true)
          #@mainBox.pack_start(@viewTwo, :expand => true, :fill => true)
          #@mainBox.pack_start(@viewThree, :expand => true, :fill => true)

          # quitter quand la fenetre est detruite
          @application.signal_connect("destroy") { detruire() }

          @application.add(@mainBox)
          self.ouvrir()

          # cacher les vues 2 et 3 par defaut
          #@viewTwo.hide()
          #@viewThree.hide()
    end

    # Methode qui permet d'initialiser la grille de la fenetre
    def initialize(title)
        super(title)
        @viewOne = creerViewOne()
        #@viewTwo = creerViewTwo(false)
        #@viewThree = creerViewThree(false)

    end





    def creerViewOne()

        box = Gtk::Box.new(:vertical, 10)
        # creation de la grille avec les boutons de controle
        controle = Gtk::Grid.new()



        controle.margin = 15

        #controle.margin-bottom =


        # creation des boutons de mode de jeu
        btnPause = Gtk::Button.new(:label => "Pause")
        btnRetour = Gtk::Button.new(:label => "Retour")
        btnReinit = Gtk::Button.new(:label => "REinit")
        btnAide = Gtk::Button.new(:label => "Aide")
        btnInfo = Gtk::Button.new(:label => "Into")
        btnParam = Gtk::Button.new(:label => "Param")


        # creation du label pour le titre
        titre = Gtk::Label.new("Partie libre")

        # gestion des évènements
        btnPause.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end

        btnRetour.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end

        # gestion des évènements
        btnReinit.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end


        # gestion des évènements
        btnAide.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end


        # gestion des évènements
        btnInfo.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end



        # gestion des évènements
        btnParam.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end

        # attachement des boutons de mode de jeu
        controle.attach(btnPause, 0, 0, 1, 1)
        controle.attach(btnRetour, 1, 0, 1, 1)
        controle.attach(btnReinit, 2, 0, 1, 1)
        controle.attach(btnAide, 3, 0, 1, 1)
        controle.attach(btnInfo, 4, 0, 1, 1)
        controle.attach(btnParam, 5, 0, 1, 1)



        controle.set_column_homogeneous(true)
        box.pack_start(controle, :expand => true, :fill => true)


        # ajout des boutons du bas
        #ajouterBtnBas(box)
        return box
    end



    def creerViewTwo()
        box = Gtk::Box.new(:vertical, 10)
        # creation de la grille avec les boutons de controle
        controle = Gtk::Grid.new()



        # creation des boutons de mode de jeu

        for a in 0..9
            for b in 0..9
                btngrille = Gtk::Button.new(:label => "#{a} #{b}")


         btnPause.signal_connect("clicked") do
             puts "click libre"
             @viewOne.set_visible(false)
             @viewTwo.set_visible(true)
         end


        # gestion des évènements
        btnPause.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end

        btnRetour.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end

        # gestion des évènements
        btnReinit.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end


        # gestion des évènements
        btnAide.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end


        # gestion des évènements
        btnInfo.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end



        # gestion des évènements
        btnParam.signal_connect("clicked") do
            puts "click libre"
            @viewOne.set_visible(false)
            @viewTwo.set_visible(true)
        end

        # attachement des boutons de mode de jeu
        controle.attach(btnPause, 0, 0, 1, 1)
        controle.attach(btnRetour, 1, 0, 1, 1)
        controle.attach(btnReinit, 2, 0, 1, 1)
        controle.attach(btnAide, 3, 0, 1, 1)
        controle.attach(btnInfo, 4, 0, 1, 1)
        controle.attach(btnParam, 5, 0, 1, 1)



        controle.set_column_homogeneous(true)
        box.pack_start(controle, :expand => true, :fill => true)

        # ajout du bouton de classement
        box.pack_start(Gtk::Button.new(:label => "Classement"), :expand => true, :fill => true)

        # ajout des boutons du bas
        #ajouterBtnBas(box)
        return box
    end
















    # Methode qui permet de mettre a jour le chrono
    def rafraichirTemps()
        #
    end

    # Methode qui permet de mettre a jour l'affichage d'une case donnee
    def changerEtatCase()
        #
    end

    # Methode ..................
    def listenerBoutonCase()
        #
    end

    # Methode pour revenir en arriere (coup precedent)
    def listenerBoutonPrecedent()
        #
    end

    # Methode pour revenir au coup suivant (apres un retour en arriere, un coup suivant est sauvegarde)
    def listenerBoutonSuivant()
        #
    end

    # Methode qui permet de remettre a zero la grille
    def listenerBoutonRemiseAZero()
        #
    end

    # Methode qui permet de mettre en pause la partie
    def listenerBoutonPause()
        #
    end

    # Methode qui permet de quitter la partie
    def listenerQuitterPartie()
        #
    end

    # Methode qui permet de fermer la fenetre de jeu
    def listenerQuitter()
        @application.signal_connect('destroy'){
            Gtk.main_quit()
        }
    end
end


##################### CODE DE TEST DE LA CLASSE #####################

fenetrePartie= FenetrePartie.creer("Nurikabe")
fenetrePartie.creer()


Gtk.main5
