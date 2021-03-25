require './Fenetre.rb'
require './FenetreParametre.rb'

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
        tabLabels = ['Libre', 'Contre-la-montre', 'Survie', 'Tutoriel']
        listeBtn = Array.new()
    
        # creation des boutons de mode de jeu
        for x in 0..3
          listeBtn << Gtk::Button.new()
          setBold(listeBtn.at(x), tabLabels.at(x))
          box.add( setmargin(listeBtn.at(x), 0, 15, 70, 70) )
        end
        # gestion des évènements des boutons
        listeBtn[0].signal_connect('clicked') { puts 'click libre' }
        listeBtn[1].signal_connect('clicked') { puts 'click contre-la-montre' }
        listeBtn[2].signal_connect('clicked') { puts 'click survie' }
        listeBtn[3].signal_connect('clicked') { puts 'click tuto' }
    
        # AJOUT SEPARATEUR
        separateur = Gtk::Separator.new(:horizontal)  
        box.add( setmargin(separateur, 0, 0, 80, 80) ) #ADD

        # ajout des boutons du bas
        btnClassement = Gtk::Button.new(label: 'Classement')
        btnClassement.set_height_request(60)
        box.add( setmargin(btnClassement, 15, 15, 70, 70) ) #ADD

        # AJOUT SEPARATEUR
        separateur = Gtk::Separator.new(:horizontal)  
        box.add( setmargin(separateur, 0, 0, 80, 80) ) #ADD

        # TRIPLE BOUTON EN BAS
        hBox = Gtk::Box.new(:horizontal)
        hBox.set_homogeneous(true)

        btnParam = Gtk::Button.new(label: 'Paramètres')
        btnParam.set_height_request(60)
        btnParam.signal_connect('clicked') { Fenetre.remove(box); FenetreParametre.afficheToi( FenetreMenu ) }
        hBox.add(btnParam)#ADD

        btnAPropos = Gtk::Button.new(label: 'A propos')
        hBox.add(btnAPropos)#ADD

        labelBtnQuit = Gtk::Label.new
        labelBtnQuit.set_markup("<span foreground='#a4a400000000' >Quitter</span>")
        
        btnQuit = Gtk::Button.new
        btnQuit.add(labelBtnQuit)
        hBox.add(btnQuit)#ADD

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


end

FenetreMenu.afficheToi( FenetreMenu )
Fenetre.show_all()

Gtk.main