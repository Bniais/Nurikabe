load "Fenetre.rb"
load "FenetreAPropos.rb"
require "gtk3"

# Classe qui gere la fenetre du menu
class FenetreMenu < Fenetre
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
        #
    end

    # Methode qui permet d'ouvrir la fenetre 'A propos'
    def listenerOuvrirAPropos()
        window = Gtk::Window.new("First example")
        window.set_size_request(740, 715)
        window.set_border_width(10)
        @APropos.creeToi(window)
        @APropos.afficheToi()
    end

    # Methode qui permet de quitter la fenetre de menu
    def listenerQuitter()
        #
    end
end

#Test ouverture fenetre à propos
Gtk.init

bonjour.creer("Menu principal")

bonjour.listenerOuvrirAPropos()

Gtk.main