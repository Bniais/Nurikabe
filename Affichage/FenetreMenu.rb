require './Fenetre.rb'
require './FenetreParametre.rb'
require './FenetreAPropos.rb'
require './FenetreClassement.rb'
require './FenetrePartie.rb'
require './Fenetre1v1.rb'
require './FenetreSelection.rb'
require "./../Partie/PartieSurvie.rb"
require "./../Partie/PartieTuto.rb"
require "./../Partie/PartieContreLaMontre.rb"

##
# Classe qui gere l'affichage de la fenetre du menu
#
# Herite de la classe abstraite Fenetre
class FenetreMenu < Fenetre

    ##
    # Methode privee pour l'initialisation
    def initialize()
        self
    end

    ##
    # Methode qui permet d'afficher la fenetre du menu
    def self.afficheToi( _ ) # IGNORE LAST VIEW
        Fenetre.set_subtitle(@@lg.gt("MENU"))
        Fenetre.add( FenetreMenu.new().creationInterface() )
        Fenetre.show_all
        return self
    end

    ##
    # Methode qui permet d'afficher une boite de dialogue
    def show_standard_message_dialog(unMessage)
        @dialog = Gtk::MessageDialog.new(:parent => @@window,
                                        :flags => [:modal, :destroy_with_parent],
                                        :type => :info,
                                        :buttons => :none,
                                        :message => unMessage)
        @dialog.add_button( @@lg.gt("OUI") , 0)
        @dialog.add_button( @@lg.gt("NON") , 1)
        response = @dialog.run
        @dialog.destroy
        return response
    end

    ##
    # Methode qui gere et cree l'affichage du menu
    def creationInterface()
        box = Gtk::Box.new(:vertical, 10)

        # creation du label pour le titre + ajout à la box
        titre = Gtk::Label.new()
        titre.set_markup("<span weight = 'ultrabold' size = '90000' >Nurikabe</span>")
        box.add( setmargin(titre, 0, 0, 70, 70) )

        # creation des boutons
        btnLibre = Gtk::Button.new()
        setBold(btnLibre, @@lg.gt("LIBRE") )
        box.add( setmargin( btnLibre , 0, 15, 70, 70) )

        btnContreLaMontre = Gtk::Button.new()
        setBold(btnContreLaMontre, @@lg.gt("CONTRELAMONTRE") )
        box.add( setmargin( btnContreLaMontre , 0, 15, 70, 70) )


        btnSurvie = Gtk::Button.new()
        setBold(btnSurvie, @@lg.gt("SURVIE") )
        box.add( setmargin( btnSurvie , 0, 15, 70, 70) )

        btn1v1 = Gtk::Button.new()
        setBold(btn1v1, @@lg.gt("1V1") )
        box.add( setmargin( btn1v1 , 0, 15, 70, 70) )


        btnTutoriel = Gtk::Button.new()
        setBold(btnTutoriel, @@lg.gt("TUTORIEL") )
        box.add( setmargin( btnTutoriel , 0, 10, 70, 70) )


        # gestion des évènements des boutons
        btnLibre.signal_connect('clicked') {
            Fenetre.remove(box); FenetreSelection.afficheToi( FenetreMenu )
        }

        btnContreLaMontre.signal_connect('clicked') { |btn|

            # affichage d'un pop up si une sauvegarde existe
            indice = Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieSauvegarderContreLaMontre
            if(indice != -1)
                if (show_standard_message_dialog(@@lg.gt("REPRENDRE_SAUVEGARDE")) == 0)
                    Fenetre.remove(box);
                    FenetrePartie.afficheToiChargerPartie(FenetreMenu ,  indice)
                else
                    Sauvegardes.getInstance.getSauvegardePartie.supprimerSauvegardePartie(Sauvegardes.getInstance.getSauvegardePartie.getPartie(indice))
                end
            end
            creationHBoxCLM(box,2,btn,3,btnSurvie)
        }
        btnSurvie.signal_connect('clicked') { |btn|
            #popup si sauvegarde
            indice = Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieSauvegarderSurvie
            if(indice != -1)
                if (show_standard_message_dialog(@@lg.gt("REPRENDRE_SAUVEGARDE")) == 0)
                    Fenetre.remove(box);
                    FenetrePartie.afficheToiChargerPartie(FenetreMenu ,  indice)
                else
                    Sauvegardes.getInstance.getSauvegardePartie.supprimerSauvegardePartie(Sauvegardes.getInstance.getSauvegardePartie.getPartie(indice))
                end
            end
            creationHBoxSurvie(box,3,btn,2,btnContreLaMontre)
        }

        btn1v1.signal_connect("clicked"){
            Fenetre.remove(box);
            Fenetre1v1.afficheToi(FenetreMenu)
        }

        btnTutoriel.signal_connect('clicked') {
            Fenetre.remove(box);
            FenetrePartie.afficheToiSelec(FenetreMenu, PartieTuto.creer(SauvegardeGrille.getInstance.getGrilleAt(rand(1..SauvegardeGrille.getInstance.getNombreGrille))) )
        }

        # AJOUT SEPARATEUR
        separateur = Gtk::Separator.new(:horizontal)
        box.add( setmargin(separateur, 0, 0, 80, 80) ) #ADD

        # ajout des boutons du bas
        btnClassement = Gtk::Button.new(label: @@lg.gt("CLASSEMENT"))
        btnClassement.set_height_request(60)
        btnClassement.signal_connect('clicked') { Fenetre.remove(box); FenetreClassement.afficheToi( FenetreMenu ) }
        box.add( setmargin(btnClassement, 10, 10, 70, 70) ) #ADD

        # AJOUT SEPARATEUR
        separateur = Gtk::Separator.new(:horizontal)
        box.add( setmargin(separateur, 0, 0, 80, 80) ) #ADD

        # TRIPLE BOUTON EN BAS
        hBox = Gtk::Box.new(:horizontal)
        hBox.set_homogeneous(true)

        btnParam = Gtk::Button.new(label: @@lg.gt("PARAMETRES"))
        setmargin(btnParam,0,0,0,5 )
        btnParam.set_height_request(50)
        btnParam.signal_connect('clicked') { Fenetre.remove(box); FenetreParametre.afficheToi( FenetreMenu ) }
        hBox.add(btnParam)#ADD

        btnAPropos = Gtk::Button.new(label: @@lg.gt("A_PROPOS"))
        setmargin(btnAPropos,0,0,0,5 )
        btnAPropos.signal_connect('clicked') { Fenetre.remove(box); FenetreAPropos.afficheToi( FenetreMenu ) }
        hBox.add(btnAPropos)#ADD

        btnQuitter = Gtk::Button.new(label: @@lg.gt("QUITTER"))
        btnQuitter.name = "btnQuitter"
        setmargin(btnQuitter,0,0,0,5 )
        btnQuitter.signal_connect("clicked") { Fenetre.exit }
        hBox.add(btnQuitter)#ADD

        box.add( setmargin(hBox, 10, 0, 70, 70) ) #ADD

        @bbox = box
        return box
      end

    ##
    # Methode qui permet de creer une boite de dialogue pour reprendre une partie en cours
    def creationHboxResumeGame( btn , mode , mainBox )
        box = Gtk::Box.new(:horizontal)
        btn.set_width_request(360)
        btn.set_margin_right(10)
        box.add(btn)
        btnResume = Gtk::Button.new(:label => @@lg.gt("REPRENDRE"));
        btnResume.set_width_request(180)
        btnResume.name = "resumeGame"

        if mode == Mode::LIBRE
            btnResume.signal_connect("clicked") {
                puts Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieSauvegarderLibre.size.to_s + "size"
                if Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieSauvegarderLibre.size > 1
                    box.remove(btnResume)
                    comboBox = Gtk::ComboBoxText.new
                    comboBox.set_width_request(180)
                    for i in 0...Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieSauvegarderLibre.size
                        comboBox.append( "visible" , i.to_s )
                    end
                    comboBox.signal_connect("changed") { |cb| Fenetre.remove(mainBox); FenetrePartie.afficheToiChargerPartie( FenetreMenu , Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieSauvegarderLibre[cb.active] )    }
                    box.add( comboBox )
                    Fenetre.show_all()
                else
                    Fenetre.remove(mainBox); FenetrePartie.afficheToiChargerPartie( FenetreMenu , Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieSauvegarderLibre[0] )
                end
            }
        elsif mode == Mode::SURVIE
            btnResume.signal_connect("clicked") { Fenetre.remove(mainBox); FenetrePartie.afficheToiChargerPartie(FenetreMenu , Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieSauvegarderSurvie ) }
        elsif mode == Mode::CONTRE_LA_MONTRE
            btnResume.signal_connect("clicked") { Fenetre.remove(mainBox); FenetrePartie.afficheToiChargerPartie(FenetreMenu , Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieSauvegarderContreLaMontre ) }
        elsif mode == Mode::TUTORIEL
            btnResume.signal_connect("clicked") { Fenetre.remove(mainBox); FenetrePartie.afficheToiChargerPartie(FenetreMenu , Sauvegardes.getInstance.getSauvegardePartie.getIndicePartieSauvegarderTutoriel ) }
        end

        box.add(btnResume)
        return setmargin(box, 0, 15, 70, 70);
    end

    ##
    # Methode qui permet de gerer les marges d'un objet
    def setmargin(obj, top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end

    ##
    # Methode qui permet de mettre en gras un label
    def setBold(btn, nom)
        label = Gtk::Label.new
        label.set_markup("<span weight = 'ultrabold'>#{nom}</span>")
        btn.add(label)
        btn.set_height_request(60)
    end

    ##
    # Methode qui permet de modifier l'affichage des bouton lorsque
    # l'utilisateur clique sur le bouton 'survie'.
    #
    # Le bouton se divise en 3 boutons ('facile', 'moyen' et 'difficile')
    def creationHBoxSurvie( box, position , remove , positionOtherDifficulty , btnOtherMode )

        if box.children[positionOtherDifficulty] != btnOtherMode
            box.remove( box.children[positionOtherDifficulty] )
            box.add(btnOtherMode)
            box.reorder_child(btnOtherMode, positionOtherDifficulty)
        end

        box.remove(remove) #DELETE

        hBox = Gtk::Box.new(:horizontal)
        hBox.set_height_request(60); hBox.set_homogeneous(true)
        hBox.add ( setmargin( Gtk::Button.new(),0,0,0,5 ) )
        hBox.add ( setmargin( Gtk::Button.new(),0,0,0,5 ) )
        hBox.add ( Gtk::Button.new() )

        # gestion des evenements des boutons de choix de niveau
        hBox.children[0].signal_connect("clicked"){
            Fenetre.remove(box);

            nbGrille = SauvegardeGrille.getInstance.getNombreGrille
            indiceRand = rand(1..(nbGrille/3)) #TOTEST si 1/3
            FenetrePartie.afficheToiSelec(FenetreMenu, PartieSurvie.creer(SauvegardeGrille.getInstance.getGrilleAt(indiceRand)))
        }
        hBox.children[1].signal_connect("clicked"){
            Fenetre.remove(box);

            nbGrille = SauvegardeGrille.getInstance.getNombreGrille
            indiceRand = rand((1+nbGrille/3)..(2*nbGrille/3))#TOTEST si 1/3
            FenetrePartie.afficheToiSelec(FenetreMenu, PartieSurvie.creer(SauvegardeGrille.getInstance.getGrilleAt(indiceRand)))
        }

        hBox.children[2].signal_connect("clicked"){
            Fenetre.remove(box);

            nbGrille = SauvegardeGrille.getInstance.getNombreGrille
            indiceRand = rand((1+2*nbGrille/3)..nbGrille)#TOTEST si 1/3
            FenetrePartie.afficheToiSelec(FenetreMenu, PartieSurvie.creer(SauvegardeGrille.getInstance.getGrilleAt(indiceRand)))
        }

        setBold( hBox.children[0] , @@lg.gt("FACILE") )
        setBold( hBox.children[1] , @@lg.gt("MOYEN") )
        setBold( hBox.children[2] , @@lg.gt("DIFFICILE") )

        box.add( setmargin(hBox,0,15,70,70) ) #ADD
        box.reorder_child( hBox , position  ) #REORDER
        Fenetre.show_all
    end

    ##
    # Methode qui permet de modifier l'affichage des bouton lorsque
    # l'utilisateur clique sur le bouton 'contre-la-montre'.
    #
    # Le bouton se divise en 3 boutons ('facile', 'moyen' et 'difficile')
    def creationHBoxCLM( box, position , remove , positionOtherDifficulty , btnOtherMode )

        if box.children[positionOtherDifficulty] != btnOtherMode
            box.remove( box.children[positionOtherDifficulty] )
            box.add(btnOtherMode)
            box.reorder_child(btnOtherMode, positionOtherDifficulty)
        end

        box.remove(remove) #DELETE

        hBox = Gtk::Box.new(:horizontal)
        hBox.set_height_request(60); hBox.set_homogeneous(true)
        hBox.add ( setmargin( Gtk::Button.new(),0,0,0,5 ) )
        hBox.add ( setmargin( Gtk::Button.new(),0,0,0,5 ) )
        hBox.add ( Gtk::Button.new() )

        # gestion des evenements des boutons de choix de niveau
        hBox.children[0].signal_connect("clicked"){
            Fenetre.remove(box);

            nbGrille = SauvegardeGrille.getInstance.getNombreGrille
            indiceRand = rand(1..(nbGrille/3))
            FenetrePartie.afficheToiSelec(FenetreMenu, PartieContreLaMontre.creer(SauvegardeGrille.getInstance.getGrilleAt(indiceRand)))
        }
        hBox.children[1].signal_connect("clicked"){
            Fenetre.remove(box);

            nbGrille = SauvegardeGrille.getInstance.getNombreGrille
            indiceRand = rand((1+nbGrille/3)..(2*nbGrille/3))
            FenetrePartie.afficheToiSelec(FenetreMenu, PartieContreLaMontre.creer(SauvegardeGrille.getInstance.getGrilleAt(indiceRand)))
        }

        hBox.children[2].signal_connect("clicked"){
            Fenetre.remove(box);

            nbGrille = SauvegardeGrille.getInstance.getNombreGrille
            indiceRand = rand((1+2*nbGrille/3)..nbGrille)
            FenetrePartie.afficheToiSelec(FenetreMenu, PartieContreLaMontre.creer(SauvegardeGrille.getInstance.getGrilleAt(indiceRand)))
        }

        setBold( hBox.children[0] , @@lg.gt("FACILE") )
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
