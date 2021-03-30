require './Fenetre.rb'
require './FenetreParametre.rb'
require './FenetreAPropos.rb'
require './FenetreClassement.rb'
require './FenetrePartie.rb'

class FenetreMenu < Fenetre


    def initialize()
        self
    end

    def self.afficheToi( _ ) # IGNORE LAST VIEW
        Fenetre.set_subtitle("Menu")
        Fenetre.add( FenetreMenu.new().creationInterface() )
        Fenetre.show_all
        return self
    end

    def creationInterface()
        box = Gtk::Box.new(:vertical, 10)
    
        # creation du label pour le titre + ajout à la box
        titre = Gtk::Label.new()
        titre.set_markup("<span weight = 'ultrabold' size = '90000' >Nurikabe</span>")
        box.add( setmargin(titre, 0, 0, 70, 70) )
        

        # creation de la grille avec les boutons de modes
        tabLabels = [ @@lg.gt("LIBRE") , @@lg.gt("CONTRELAMONTRE"), @@lg.gt("SURVIE"), @@lg.gt("TUTORIEL")]
        listeBtn = Array.new()
    
        # creation des boutons de mode de jeu
        for x in 0..3
          listeBtn << Gtk::Button.new()
          setBold(listeBtn.at(x), tabLabels.at(x))
          box.add( setmargin(listeBtn.at(x), 0, 15, 70, 70) )
        end
        # gestion des évènements des boutons
        listeBtn[0].signal_connect('clicked') { Fenetre.remove(box); FenetrePartie.afficheToi( FenetreMenu ) }

        listeBtn[1].signal_connect('clicked') { |btn|
            creationHBoxDifficulte(box,2,btn,3,listeBtn[2])
        }
        listeBtn[2].signal_connect('clicked') { |btn|
            creationHBoxDifficulte(box,3,btn,2,listeBtn[1])    
        }
        listeBtn[3].signal_connect('clicked') { Fenetre.remove(box); FenetrePartie.afficheToi( FenetreMenu ) }
    
        # AJOUT SEPARATEUR
        separateur = Gtk::Separator.new(:horizontal)  
        box.add( setmargin(separateur, 0, 0, 80, 80) ) #ADD

        # ajout des boutons du bas
        btnClassement = Gtk::Button.new(label: @@lg.gt("CLASSEMENT"))
        btnClassement.set_height_request(60)
        btnClassement.signal_connect('clicked') { Fenetre.remove(box); FenetreClassement.afficheToi( FenetreMenu ) }
        box.add( setmargin(btnClassement, 15, 15, 70, 70) ) #ADD

        # AJOUT SEPARATEUR
        separateur = Gtk::Separator.new(:horizontal)  
        box.add( setmargin(separateur, 0, 0, 80, 80) ) #ADD

        # TRIPLE BOUTON EN BAS
        hBox = Gtk::Box.new(:horizontal)
        hBox.set_homogeneous(true)

        btnParam = Gtk::Button.new(label: @@lg.gt("PARAMETRES"))
        setmargin(btnParam,0,0,0,5 )
        btnParam.set_height_request(60)
        btnParam.signal_connect('clicked') { Fenetre.remove(box); FenetreParametre.afficheToi( FenetreMenu ) }
        hBox.add(btnParam)#ADD

        btnAPropos = Gtk::Button.new(label: @@lg.gt("APROPOS"))
        setmargin(btnAPropos,0,0,0,5 )
        btnAPropos.signal_connect('clicked') { Fenetre.remove(box); FenetreAPropos.afficheToi( FenetreMenu ) }
        hBox.add(btnAPropos)#ADD

        btnQuitter = Gtk::Button.new(label: @@lg.gt("QUITTER"))
        btnQuitter.name = "btnQuitter"
        setmargin(btnQuitter,0,0,0,5 )
        btnQuitter.signal_connect("clicked") { Fenetre.exit }
        hBox.add(btnQuitter)#ADD

        box.add( setmargin(hBox, 15, 0, 70, 70) ) #ADD

        @bbox = box
        return box
      end

    # Methode qui permet de gerer les marges d'un objet
    def setmargin(obj, top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end

      # Methode qui permet de mettre en gras un label
    def setBold(btn, nom)
        label = Gtk::Label.new
        label.set_markup("<span weight = 'ultrabold'>#{nom}</span>")
        btn.add(label)
        btn.set_height_request(70)
    end


    def creationHBoxDifficulte( box, position , remove , positionOtherDifficulty , btnOtherMode )

        if box.children[positionOtherDifficulty] != btnOtherMode
            box.remove( box.children[positionOtherDifficulty] )
            box.add(btnOtherMode)
            box.reorder_child(btnOtherMode, positionOtherDifficulty)
        end

        box.remove(remove) #DELETE

        hBox = Gtk::Box.new(:horizontal)
        hBox.set_height_request(70); hBox.set_homogeneous(true)
        hBox.add ( setmargin( Gtk::Button.new(),0,0,0,5 ) )
        hBox.add ( setmargin( Gtk::Button.new(),0,0,0,5 ) )
        hBox.add ( Gtk::Button.new() )

        hBox.children[0].signal_connect("clicked"){ Fenetre.remove(box); FenetrePartie.afficheToi( FenetreMenu ) }
        hBox.children[1].signal_connect("clicked"){ Fenetre.remove(box); FenetrePartie.afficheToi( FenetreMenu ) }
        hBox.children[2].signal_connect("clicked"){ Fenetre.remove(box); FenetrePartie.afficheToi( FenetreMenu ) }

        setBold( hBox.children[0] , @@lg.gt("LIBRE") )
        setBold( hBox.children[1] , @@lg.gt("MOYEN") )
        setBold( hBox.children[2] , @@lg.gt("DIFFICILE") )

        box.add( setmargin(hBox,0,15,70,70) ) #ADD
        box.reorder_child( hBox , position  ) #REORDER
        Fenetre.show_all
    end
end

FenetreMenu.afficheToi( FenetreMenu )
Fenetre.show_all()

Gtk.main