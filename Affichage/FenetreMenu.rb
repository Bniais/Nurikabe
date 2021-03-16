load "Fenetre.rb"
require "gtk3"


# Classe qui gere la fenetre du menu
class FenetreMenu < Fenetre
    @maFenetre = nil
    # Constructeur de la class FenetreMenu
    def initialize(window)
        
       @maFenetre = window
    end

    # Methode qui permet de quitter l'application
    def onDestroy()
        puts "Fin de l'application"
        Gtk.main_quit()
    end

    # Methode d'affichage
    def afficheToi()
        builder = Gtk::Builder.new()
        builder.add_from_file('Template_2.glade')
        builder.connect_signals{ |handler| method(handler) }
        
        @stack = Gtk::Stack.new()
        @stack.set_transition_type( 0 )

        @view_one = builder.get_object('FenetreMenu1')
        @view_two = builder.get_object('FenetreMenu2')
        @view_three = builder.get_object('FenetreMenu3')

       @view_one.set_visible(true)

        # @stack.add_named(@view_one, "view one" )
        # @stack.add_named(@view_two, "view two" )
        # @stack.add_named(@view_three, "view three" )

        @maFenetre = builder.get_object('FenetreMenu1')
        # @maFenetre.add(@stack)
        @maFenetre.show()
    end
    
    def activation()
        @view_one.set_visible(false)
        @view_two.set_visible(true)
        # puts  @stack.visible_child(  )
       # @stack.set_visible_child(@view_two)
        # puts  @stack.visible_child(  )
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



## CODE DE TEST DE LA CLASS
Gtk.init

window = Gtk::Window.new()
window.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
fenetreMenu = FenetreMenu.new(window)
fenetreMenu.afficheToi()

# quitter quand la fenetre est detruite
window.signal_connect("destroy") { onDestroy() }

Gtk.main