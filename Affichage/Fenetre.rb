require 'gtk3'
require './../Parametres/Parametre.rb'
require './../Parametres/Langue.rb'
require './../Sauvegarde/Sauvegardes.rb'
require './../Sauvegarde/SauvegardeGrille.rb'

##
# Classe abstraite qui gere l'interface
# DESIGN PATTERN SINGLETON

class Fenetre

    @@window = nil
    @@cssProviderDarkMode = Gtk::CssProvider.new
    @@cssProviderDarkMode.load(path: "style_dark.css")

    @@cssProviderGrayMode = Gtk::CssProvider.new
    @@cssProviderGrayMode.load(path: "style_gray.css")

    @@cssProviderGrayDarkMode = Gtk::CssProvider.new
    @@cssProviderGrayDarkMode.load(path: "style_gray_dark.css")

    @@lg = nil

    ##
    # Méthode d'initialisation
    private
    def initialize()
        @@window = Gtk::Window.new()
        @@window.set_default_size(745,850);     @@window.set_width_request(745);    @@window.set_height_request(850);   @@window.set_resizable(false) #WINDOW PARAMS
        @@window.signal_connect("destroy") { Fenetre.exit } ## EXIT SIGNAL
        @@window.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)

        @@header = Gtk::HeaderBar.new
        @@header.show_close_button = true;      @@header.name = "headerbar" #FOR CSS
        @@header.title = "Nurikabe"     ;       @@header.subtitle = "-"
        @@window.titlebar = @@header #ADD HEADER

        SauvegardeGrille.creer("../Sauvegarde/grilles1.dump")
        Sauvegardes.creer("../Sauvegarde/save.dump")

=begin
{
#TMP TO ADD GRILLES
        ################################ GRILLES 5x5 ################################
        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::ILE_4, 3, 0), Case.creer(Couleur::BLANC, 4, 0)],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::ILE_1, 1, 1), Case.creer(Couleur::NOIR, 2, 1), Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::BLANC, 4, 1)],
            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2)],
            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::ILE_1, 3, 3), Case.creer(Couleur::NOIR, 4, 3)],
            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_2, 1, 4), Case.creer(Couleur::NOIR, 2, 4), Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::ILE_1, 4, 4)]
        ], [45,35,25]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille



        SauvegardeGrille.getInstance.ajouterGrille(Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::BLANC, 0, 0) ,Case.creer(Couleur::ILE_4, 1, 0),Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::ILE_5, 3, 0), Case.creer(Couleur::BLANC, 4, 0)],
            [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1), Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::BLANC, 4, 1)],
            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::ILE_1, 2, 2), Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::BLANC, 4, 2)],
            [Case.creer(Couleur::ILE_4, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::BLANC, 4, 3)],
            [Case.creer(Couleur::BLANC, 0, 4), Case.creer(Couleur::BLANC, 1, 4), Case.creer(Couleur::BLANC, 2, 4), Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4)]
        ], [55,45,35]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille



        SauvegardeGrille.getInstance.ajouterGrille(Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::BLANC, 4, 0)],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::BLANC, 2, 1),Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::BLANC, 4, 1)],
            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::ILE_3, 1, 2), Case.creer(Couleur::NOIR, 2, 2),Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::BLANC, 4, 2)],
            [Case.creer(Couleur::ILE_1, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::ILE_1, 2, 3),Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::BLANC, 4, 3)],
            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::NOIR, 2, 4),Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::ILE_5, 4, 4)]
        ], [45,35,25]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille




        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::ILE_1, 3, 0), Case.creer(Couleur::NOIR, 4, 0)],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::ILE_1, 1, 1), Case.creer(Couleur::NOIR, 2, 1),Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::NOIR, 4, 1)],
            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::BLANC, 2, 2),Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::ILE_1, 4, 2)],
            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::ILE_3, 1, 3), Case.creer(Couleur::BLANC, 2, 3),Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::NOIR, 4, 3)],
            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::NOIR, 2, 4),Case.creer(Couleur::ILE_2, 3, 4), Case.creer(Couleur::BLANC, 4, 4)]
        ], [45,35,25]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille



        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::ILE_1, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0)],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::ILE_3, 1, 1), Case.creer(Couleur::BLANC, 2, 1),Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::NOIR, 4, 1)],
            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2),Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2)],
            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::BLANC, 2, 3),Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::NOIR, 4, 3)],
            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_4, 1, 4), Case.creer(Couleur::NOIR, 2, 4),Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4)]
        ], [55,45,35]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille



        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::ILE_3, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::BLANC, 4, 0)],
            [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::ILE_1, 2, 1),Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::ILE_3, 4, 1)],
            [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2),Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2)],
            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::ILE_1, 2, 3),Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::ILE_2, 4, 3)],
            [Case.creer(Couleur::ILE_1, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::NOIR, 2, 4),Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::BLANC, 4, 4)]
        ], [45,35,25]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille



    ################################ GRILLES 7x7 ################################
        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::ILE_1, 3, 0), Case.creer(Couleur::NOIR, 4, 0), Case.creer(Couleur::NOIR, 5, 0),Case.creer(Couleur::BLANC, 6, 0) ],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1),Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::ILE_1, 4, 1), Case.creer(Couleur::NOIR, 5, 1),Case.creer(Couleur::BLANC, 6, 1)],
            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::ILE_3, 1, 2), Case.creer(Couleur::BLANC, 2, 2),Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2), Case.creer(Couleur::NOIR, 5, 2),Case.creer(Couleur::BLANC, 6, 2)],
            [Case.creer(Couleur::ILE_4, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3),Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::BLANC, 4, 3), Case.creer(Couleur::NOIR, 5, 3),Case.creer(Couleur::ILE_4, 6, 3)],
            [Case.creer(Couleur::BLANC, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::BLANC, 2, 4),Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::BLANC, 4, 4), Case.creer(Couleur::ILE_3, 5, 4),Case.creer(Couleur::NOIR, 6, 4)],
            [Case.creer(Couleur::BLANC, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_2, 2, 5),Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::NOIR, 4, 5), Case.creer(Couleur::NOIR, 5, 5),Case.creer(Couleur::NOIR, 6, 5)],
            [Case.creer(Couleur::BLANC, 0, 6), Case.creer(Couleur::NOIR, 1, 6), Case.creer(Couleur::NOIR, 2, 6),Case.creer(Couleur::ILE_4, 3, 6), Case.creer(Couleur::BLANC, 4, 6), Case.creer(Couleur::BLANC, 5, 6),Case.creer(Couleur::BLANC, 6, 6)]
        ], [120,100,80]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille




        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::ILE_3, 3, 0), Case.creer(Couleur::BLANC, 4, 0), Case.creer(Couleur::BLANC, 5, 0),Case.creer(Couleur::NOIR, 6, 0) ],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::ILE_1, 1, 1), Case.creer(Couleur::NOIR, 2, 1),Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::NOIR, 4, 1), Case.creer(Couleur::NOIR, 5, 1),Case.creer(Couleur::NOIR, 6, 1)],
            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::ILE_5, 2, 2),Case.creer(Couleur::BLANC, 3, 2), Case.creer(Couleur::BLANC, 4, 2), Case.creer(Couleur::BLANC, 5, 2),Case.creer(Couleur::NOIR, 6, 2)],
            [Case.creer(Couleur::ILE_1, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3),Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::NOIR, 4, 3), Case.creer(Couleur::BLANC, 5, 3),Case.creer(Couleur::NOIR, 6, 3)],
            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::ILE_3, 2, 4),Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::BLANC, 4, 4), Case.creer(Couleur::NOIR, 5, 4),Case.creer(Couleur::NOIR, 6, 4)],
            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::ILE_1, 1, 5), Case.creer(Couleur::NOIR, 2, 5),Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::NOIR, 4, 5), Case.creer(Couleur::BLANC, 5, 5),Case.creer(Couleur::NOIR, 6, 5)],
            [Case.creer(Couleur::NOIR, 0, 6), Case.creer(Couleur::NOIR, 1, 6), Case.creer(Couleur::NOIR, 2, 6),Case.creer(Couleur::ILE_4, 3, 6), Case.creer(Couleur::BLANC, 4, 6), Case.creer(Couleur::BLANC, 5, 6),Case.creer(Couleur::NOIR, 6, 6)]
        ], [120,100,80]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille




        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0), Case.creer(Couleur::NOIR, 5, 0), Case.creer(Couleur::NOIR, 6, 0) ],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::NOIR, 2, 1), Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::NOIR, 4, 1), Case.creer(Couleur::ILE_1, 5, 1), Case.creer(Couleur::NOIR, 6, 1)],
            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::BLANC, 3, 2), Case.creer(Couleur::ILE_3, 4, 2), Case.creer(Couleur::NOIR, 5, 2), Case.creer(Couleur::NOIR, 6, 2)],
            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::ILE_3, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::NOIR, 4, 3), Case.creer(Couleur::ILE_3, 5, 3), Case.creer(Couleur::NOIR, 6, 3)],
            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::ILE_2, 2, 4), Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::NOIR, 4, 4), Case.creer(Couleur::BLANC , 5, 4), Case.creer(Couleur::NOIR, 6, 4)],
            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::ILE_1, 1, 5), Case.creer(Couleur::NOIR, 2, 5), Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::NOIR, 4, 5), Case.creer(Couleur::BLANC, 5, 5), Case.creer(Couleur::NOIR, 6, 5)],
            [Case.creer(Couleur::NOIR, 0, 6), Case.creer(Couleur::NOIR, 1, 6), Case.creer(Couleur::NOIR, 2, 6), Case.creer(Couleur::ILE_1, 3, 6), Case.creer(Couleur::NOIR, 4, 6), Case.creer(Couleur::NOIR, 5, 6), Case.creer(Couleur::NOIR, 6, 6)]
        ], [120,100,80]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille




        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0), Case.creer(Couleur::NOIR, 5, 0), Case.creer(Couleur::NOIR, 6, 0) ],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::ILE_2, 2, 1), Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::ILE_1, 4, 1), Case.creer(Couleur::NOIR, 5, 1), Case.creer(Couleur::ILE_3, 6, 1)],
            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::ILE_1, 3, 2), Case.creer(Couleur::NOIR, 4, 2), Case.creer(Couleur::BLANC, 5, 2), Case.creer(Couleur::BLANC, 6, 2)],
            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::NOIR, 4, 3), Case.creer(Couleur::NOIR, 5, 3), Case.creer(Couleur::NOIR, 6, 3)],
            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::BLANC, 1, 4), Case.creer(Couleur::NOIR, 2, 4), Case.creer(Couleur::ILE_1, 3, 4), Case.creer(Couleur::NOIR, 4, 4), Case.creer(Couleur::BLANC, 5, 4), Case.creer(Couleur::NOIR, 6, 4)],
            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::BLANC, 1, 5), Case.creer(Couleur::ILE_4, 2, 5), Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::ILE_3, 4, 5), Case.creer(Couleur::BLANC, 5, 5), Case.creer(Couleur::NOIR, 6, 5)],
            [Case.creer(Couleur::NOIR, 0, 6), Case.creer(Couleur::NOIR, 1, 6), Case.creer(Couleur::NOIR, 2, 6), Case.creer(Couleur::NOIR, 3, 6), Case.creer(Couleur::NOIR, 4, 6), Case.creer(Couleur::NOIR, 5, 6), Case.creer(Couleur::NOIR, 6, 6)]
        ], [120,100,80]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille



        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::NOIR, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0), Case.creer(Couleur::NOIR, 5, 0), Case.creer(Couleur::NOIR, 6, 0) ],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::BLANC, 2, 1), Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::BLANC, 4, 1), Case.creer(Couleur::BLANC, 5, 1), Case.creer(Couleur::NOIR, 6, 1)],
            [Case.creer(Couleur::NOIR, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::ILE_4, 2, 2), Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::BLANC, 4, 2), Case.creer(Couleur::BLANC, 5, 2), Case.creer(Couleur::NOIR, 6, 2)],
            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::BLANC, 4, 3), Case.creer(Couleur::NOIR, 5, 3), Case.creer(Couleur::NOIR, 6, 3)],
            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::ILE_9, 1, 4), Case.creer(Couleur::BLANC, 2, 4), Case.creer(Couleur::BLANC, 3, 4), Case.creer(Couleur::NOIR, 4, 4), Case.creer(Couleur::ILE_1, 5, 4), Case.creer(Couleur::NOIR, 6, 4)],
            [Case.creer(Couleur::ILE_2, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::NOIR, 2, 5), Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::NOIR, 4, 5), Case.creer(Couleur::NOIR, 5, 5), Case.creer(Couleur::NOIR, 6, 5)],
            [Case.creer(Couleur::BLANC, 0, 6), Case.creer(Couleur::NOIR, 1, 6), Case.creer(Couleur::BLANC, 2, 6), Case.creer(Couleur::BLANC, 3, 6), Case.creer(Couleur::ILE_4, 4, 6), Case.creer(Couleur::BLANC, 5, 6), Case.creer(Couleur::NOIR, 6, 6)]
        ], [120,100,80]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille



    ################################ GRILLES 8x8 ################################

        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::ILE_3, 0, 0), Case.creer(Couleur::NOIR, 1, 0), Case.creer(Couleur::BLANC, 2, 0), Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0), Case.creer(Couleur::NOIR, 5, 0), Case.creer(Couleur::ILE_2, 6, 0), Case.creer(Couleur::BLANC, 7, 0)],
            [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::ILE_2, 2, 1), Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::BLANC, 4, 1), Case.creer(Couleur::NOIR, 5, 1), Case.creer(Couleur::NOIR, 6, 1), Case.creer(Couleur::NOIR, 7, 1)],
            [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::BLANC, 4, 2), Case.creer(Couleur::BLANC, 5, 2), Case.creer(Couleur::ILE_6, 6, 2), Case.creer(Couleur::NOIR, 7, 2)],
            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::BLANC, 1, 3), Case.creer(Couleur::ILE_2, 2, 3), Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::BLANC, 4, 3), Case.creer(Couleur::BLANC, 5, 3), Case.creer(Couleur::NOIR, 6, 3), Case.creer(Couleur::BLANC, 7, 3)],
            [Case.creer(Couleur::NOIR, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::NOIR, 2, 4), Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4), Case.creer(Couleur::NOIR, 5, 4), Case.creer(Couleur::NOIR, 6, 4), Case.creer(Couleur::BLANC, 7, 4)],
            [Case.creer(Couleur::NOIR, 0, 5), Case.creer(Couleur::BLANC, 1, 5), Case.creer(Couleur::BLANC, 2, 5), Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::BLANC, 4, 5), Case.creer(Couleur::ILE_2, 5, 5), Case.creer(Couleur::NOIR, 6, 5), Case.creer(Couleur::ILE_3, 7, 5)],
            [Case.creer(Couleur::NOIR, 0, 6), Case.creer(Couleur::ILE_3, 1, 6), Case.creer(Couleur::NOIR, 2, 6), Case.creer(Couleur::NOIR, 3, 6), Case.creer(Couleur::NOIR, 4, 6), Case.creer(Couleur::NOIR, 5, 6), Case.creer(Couleur::ILE_1, 6, 6), Case.creer(Couleur::NOIR, 7, 6)],
            [Case.creer(Couleur::NOIR, 0, 7), Case.creer(Couleur::NOIR, 1, 7), Case.creer(Couleur::BLANC, 2, 7), Case.creer(Couleur::ILE_3, 3, 7), Case.creer(Couleur::BLANC, 4, 7), Case.creer(Couleur::NOIR, 5, 7), Case.creer(Couleur::NOIR, 6, 7), Case.creer(Couleur::NOIR, 7, 7)]
        ], [180,160,120]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille




    ################################ GRILLES 10x10 ################################

        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::BLANC, 0, 0), Case.creer(Couleur::ILE_2, 1, 0), Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::BLANC, 3, 0), Case.creer(Couleur::ILE_2, 4, 0), Case.creer(Couleur::NOIR, 5, 0), Case.creer(Couleur::NOIR, 6, 0), Case.creer(Couleur::NOIR, 7, 0), Case.creer(Couleur::ILE_8, 8, 0), Case.creer(Couleur::BLANC, 9, 0)],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1), Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::NOIR, 4, 1), Case.creer(Couleur::ILE_1, 5, 1), Case.creer(Couleur::NOIR, 6, 1), Case.creer(Couleur::ILE_7, 7, 1), Case.creer(Couleur::NOIR, 8, 1), Case.creer(Couleur::BLANC, 9, 1)],
            [Case.creer(Couleur::ILE_2, 0, 2), Case.creer(Couleur::BLANC, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::BLANC, 3, 2), Case.creer(Couleur::NOIR, 4, 2), Case.creer(Couleur::NOIR, 5, 2), Case.creer(Couleur::NOIR, 6, 2), Case.creer(Couleur::BLANC, 7, 2), Case.creer(Couleur::NOIR, 8, 2), Case.creer(Couleur::BLANC, 9, 2)],
            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::BLANC, 3, 3), Case.creer(Couleur::ILE_3, 4, 3), Case.creer(Couleur::NOIR, 5, 3), Case.creer(Couleur::BLANC, 6, 3), Case.creer(Couleur::BLANC, 7, 3), Case.creer(Couleur::NOIR, 8, 3), Case.creer(Couleur::BLANC, 9, 3)],
            [Case.creer(Couleur::BLANC, 0, 4), Case.creer(Couleur::BLANC, 1, 4), Case.creer(Couleur::NOIR, 2, 4), Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4), Case.creer(Couleur::ILE_5, 5, 4), Case.creer(Couleur::NOIR, 6, 4), Case.creer(Couleur::BLANC, 7, 4), Case.creer(Couleur::NOIR, 8, 4), Case.creer(Couleur::BLANC, 9, 4)],
            [Case.creer(Couleur::BLANC, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::ILE_1, 2, 5), Case.creer(Couleur::NOIR, 3, 5), Case.creer(Couleur::BLANC, 4, 5), Case.creer(Couleur::BLANC, 5, 5), Case.creer(Couleur::NOIR, 6, 5), Case.creer(Couleur::BLANC, 7, 5), Case.creer(Couleur::NOIR, 8, 5), Case.creer(Couleur::BLANC, 9, 5)],
            [Case.creer(Couleur::BLANC, 0, 6), Case.creer(Couleur::NOIR, 1, 6), Case.creer(Couleur::NOIR, 2, 6), Case.creer(Couleur::NOIR, 3, 6), Case.creer(Couleur::NOIR, 4, 6), Case.creer(Couleur::BLANC, 5, 6), Case.creer(Couleur::NOIR, 6, 6), Case.creer(Couleur::BLANC, 7, 6), Case.creer(Couleur::NOIR, 8, 6), Case.creer(Couleur::BLANC, 9, 6)],
            [Case.creer(Couleur::BLANC, 0, 7), Case.creer(Couleur::BLANC, 1, 7), Case.creer(Couleur::BLANC, 2, 7), Case.creer(Couleur::ILE_8, 3, 7), Case.creer(Couleur::NOIR, 4, 7), Case.creer(Couleur::BLANC, 5, 7), Case.creer(Couleur::NOIR, 6, 7), Case.creer(Couleur::NOIR, 7, 7), Case.creer(Couleur::NOIR, 8, 7), Case.creer(Couleur::NOIR, 9, 7)],
            [Case.creer(Couleur::NOIR, 0, 8), Case.creer(Couleur::NOIR, 1, 8), Case.creer(Couleur::NOIR, 2, 8), Case.creer(Couleur::NOIR, 3, 8), Case.creer(Couleur::NOIR, 4, 8), Case.creer(Couleur::NOIR, 5, 8), Case.creer(Couleur::NOIR, 6, 8), Case.creer(Couleur::ILE_2, 7, 8), Case.creer(Couleur::BLANC, 8, 8), Case.creer(Couleur::NOIR, 9, 8)],
            [Case.creer(Couleur::BLANC, 0, 9), Case.creer(Couleur::BLANC, 1, 9), Case.creer(Couleur::BLANC, 2, 9), Case.creer(Couleur::BLANC, 3, 9), Case.creer(Couleur::BLANC, 4, 9), Case.creer(Couleur::ILE_7, 5, 9), Case.creer(Couleur::BLANC, 6, 9), Case.creer(Couleur::NOIR, 7, 9), Case.creer(Couleur::NOIR, 8, 9), Case.creer(Couleur::NOIR, 9, 9 )]
        ], [180,160,120]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille



        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
            [Case.creer(Couleur::ILE_2, 0, 0) ,Case.creer(Couleur::BLANC, 1, 0),Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::ILE_2, 3, 0), Case.creer(Couleur::NOIR, 4, 0), Case.creer(Couleur::ILE_3, 5, 0), Case.creer(Couleur::NOIR, 6, 0), Case.creer(Couleur::ILE_2, 7, 0), Case.creer(Couleur::BLANC, 8, 0), Case.creer(Couleur::NOIR, 9, 0)],
            [Case.creer(Couleur::NOIR, 0, 1), Case.creer(Couleur::NOIR, 1, 1), Case.creer(Couleur::NOIR, 2, 1), Case.creer(Couleur::BLANC, 3, 1), Case.creer(Couleur::NOIR, 4, 1), Case.creer(Couleur::BLANC, 5, 1), Case.creer(Couleur::NOIR, 6, 1), Case.creer(Couleur::NOIR, 7, 1), Case.creer(Couleur::NOIR, 8, 1), Case.creer(Couleur::NOIR, 9, 1)],
            [Case.creer(Couleur::ILE_1, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::BLANC, 2, 2), Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::NOIR, 4, 2), Case.creer(Couleur::BLANC, 5, 2), Case.creer(Couleur::NOIR, 6, 2), Case.creer(Couleur::ILE_2, 7, 2), Case.creer(Couleur::BLANC, 8, 2), Case.creer(Couleur::NOIR, 9, 2)],
            [Case.creer(Couleur::NOIR, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::ILE_2, 2, 3), Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::BLANC, 4, 3), Case.creer(Couleur::NOIR, 5, 3), Case.creer(Couleur::ILE_1, 6, 3), Case.creer(Couleur::NOIR, 7, 3), Case.creer(Couleur::NOIR, 8, 3), Case.creer(Couleur::NOIR, 9, 3)],
            [Case.creer(Couleur::ILE_3, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::NOIR, 2, 4), Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::ILE_2, 4, 4), Case.creer(Couleur::NOIR, 5, 4), Case.creer(Couleur::NOIR, 6, 4), Case.creer(Couleur::NOIR, 7, 4), Case.creer(Couleur::ILE_1, 8, 4), Case.creer(Couleur::NOIR, 9, 4)],
            [Case.creer(Couleur::BLANC, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::BLANC, 2, 5), Case.creer(Couleur::ILE_2, 3, 5), Case.creer(Couleur::NOIR, 4, 5), Case.creer(Couleur::NOIR, 5, 5), Case.creer(Couleur::BLANC, 6, 5), Case.creer(Couleur::BLANC, 7, 5), Case.creer(Couleur::NOIR, 8, 5), Case.creer(Couleur::ILE_2, 9, 5)],
            [Case.creer(Couleur::BLANC, 0, 6), Case.creer(Couleur::NOIR, 1, 6), Case.creer(Couleur::NOIR, 2, 6), Case.creer(Couleur::NOIR, 3, 6), Case.creer(Couleur::BLANC, 4, 6), Case.creer(Couleur::NOIR, 5, 6), Case.creer(Couleur::NOIR, 6, 6), Case.creer(Couleur::ILE_3, 7, 6), Case.creer(Couleur::NOIR, 8, 6), Case.creer(Couleur::BLANC, 9, 6)],
            [Case.creer(Couleur::NOIR, 0, 7), Case.creer(Couleur::ILE_2, 1, 7), Case.creer(Couleur::BLANC, 2, 7), Case.creer(Couleur::NOIR, 3, 7), Case.creer(Couleur::ILE_2, 4, 7), Case.creer(Couleur::NOIR, 5, 7), Case.creer(Couleur::ILE_1, 6, 7), Case.creer(Couleur::NOIR, 7, 7), Case.creer(Couleur::NOIR, 8, 7), Case.creer(Couleur::NOIR, 9, 7)],
            [Case.creer(Couleur::NOIR, 0, 8), Case.creer(Couleur::NOIR, 1, 8), Case.creer(Couleur::NOIR, 2, 8), Case.creer(Couleur::NOIR, 3, 8), Case.creer(Couleur::NOIR, 4, 8), Case.creer(Couleur::NOIR, 5, 8), Case.creer(Couleur::NOIR, 6, 8), Case.creer(Couleur::NOIR, 7, 8), Case.creer(Couleur::ILE_1, 8, 8), Case.creer(Couleur::NOIR, 9, 8)],
            [Case.creer(Couleur::ILE_2, 0, 9), Case.creer(Couleur::BLANC, 1, 9), Case.creer(Couleur::NOIR, 2, 9), Case.creer(Couleur::BLANC, 3, 9), Case.creer(Couleur::BLANC, 4, 9), Case.creer(Couleur::BLANC, 5, 9), Case.creer(Couleur::BLANC, 6, 9), Case.creer(Couleur::ILE_5, 7, 9), Case.creer(Couleur::NOIR, 8, 9), Case.creer(Couleur::NOIR, 9, 9)]
        ], [180,160,120]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille



        SauvegardeGrille.getInstance.ajouterGrille( Grille.creer(SauvegardeGrille.getInstance.getNombreGrille + 1, [
        [Case.creer(Couleur::NOIR, 0, 0) ,Case.creer(Couleur::NOIR, 1, 0),Case.creer(Couleur::NOIR, 2, 0), Case.creer(Couleur::NOIR, 3, 0), Case.creer(Couleur::NOIR, 4, 0), Case.creer(Couleur::NOIR, 5, 0), Case.creer(Couleur::BLANC, 6, 0), Case.creer(Couleur::BLANC, 7, 0), Case.creer(Couleur::NOIR, 8, 0), Case.creer(Couleur::BLANC, 9, 0)],
        [Case.creer(Couleur::BLANC, 0, 1), Case.creer(Couleur::BLANC, 1, 1), Case.creer(Couleur::ILE_10, 2, 1), Case.creer(Couleur::NOIR, 3, 1), Case.creer(Couleur::BLANC, 4, 1), Case.creer(Couleur::NOIR, 5, 1), Case.creer(Couleur::NOIR, 6, 1), Case.creer(Couleur::ILE_3, 7, 1), Case.creer(Couleur::NOIR, 8, 1), Case.creer(Couleur::BLANC, 9, 1)],
        [Case.creer(Couleur::BLANC, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::NOIR, 2, 2), Case.creer(Couleur::ILE_4, 3, 2), Case.creer(Couleur::BLANC, 4, 2), Case.creer(Couleur::NOIR, 5, 2), Case.creer(Couleur::ILE_1, 6, 2), Case.creer(Couleur::NOIR, 7, 2), Case.creer(Couleur::NOIR, 8, 2), Case.creer(Couleur::BLANC, 9, 2)],
        [Case.creer(Couleur::BLANC, 0, 3), Case.creer(Couleur::NOIR, 1, 3), Case.creer(Couleur::ILE_1, 2, 3), Case.creer(Couleur::NOIR, 3, 3), Case.creer(Couleur::BLANC, 4, 3), Case.creer(Couleur::NOIR, 5, 3), Case.creer(Couleur::NOIR, 6, 3), Case.creer(Couleur::ILE_3, 7, 3), Case.creer(Couleur::NOIR, 8, 3), Case.creer(Couleur::BLANC, 9, 3)],
        [Case.creer(Couleur::BLANC, 0, 4), Case.creer(Couleur::NOIR, 1, 4), Case.creer(Couleur::NOIR, 2, 4), Case.creer(Couleur::NOIR, 3, 4), Case.creer(Couleur::NOIR, 4, 4), Case.creer(Couleur::NOIR, 5, 4), Case.creer(Couleur::BLANC, 6, 4), Case.creer(Couleur::BLANC, 7, 4), Case.creer(Couleur::NOIR, 8, 4), Case.creer(Couleur::BLANC, 9, 4)],
        [Case.creer(Couleur::BLANC, 0, 5), Case.creer(Couleur::NOIR, 1, 5), Case.creer(Couleur::BLANC, 2, 5), Case.creer(Couleur::BLANC, 3, 5), Case.creer(Couleur::BLANC, 4, 5), Case.creer(Couleur::NOIR, 5, 5), Case.creer(Couleur::NOIR, 6, 5), Case.creer(Couleur::NOIR, 7, 5), Case.creer(Couleur::NOIR, 8, 5), Case.creer(Couleur::BLANC, 9, 5)],
        [Case.creer(Couleur::BLANC, 0, 6), Case.creer(Couleur::NOIR, 1, 6), Case.creer(Couleur::ILE_4, 2, 6), Case.creer(Couleur::NOIR, 3, 6), Case.creer(Couleur::NOIR, 4, 6), Case.creer(Couleur::NOIR, 5, 6), Case.creer(Couleur::BLANC, 6, 6), Case.creer(Couleur::BLANC, 7, 6), Case.creer(Couleur::BLANC, 8, 6), Case.creer(Couleur::BLANC, 9, 6)],
        [Case.creer(Couleur::BLANC, 0, 7), Case.creer(Couleur::NOIR, 1, 7), Case.creer(Couleur::NOIR, 2, 7), Case.creer(Couleur::ILE_1, 3, 7), Case.creer(Couleur::NOIR, 4, 7), Case.creer(Couleur::BLANC, 5, 7), Case.creer(Couleur::ILE_14, 6, 7), Case.creer(Couleur::NOIR, 7, 7), Case.creer(Couleur::NOIR, 8, 7), Case.creer(Couleur::NOIR, 9, 7)],
        [Case.creer(Couleur::BLANC, 0, 8), Case.creer(Couleur::NOIR, 1, 8), Case.creer(Couleur::ILE_1, 2, 8), Case.creer(Couleur::NOIR, 3, 8), Case.creer(Couleur::BLANC, 4, 8), Case.creer(Couleur::BLANC, 5, 8), Case.creer(Couleur::NOIR, 6, 8), Case.creer(Couleur::ILE_2, 7, 8), Case.creer(Couleur::BLANC, 8, 8), Case.creer(Couleur::NOIR, 9, 8)],
        [Case.creer(Couleur::NOIR, 0, 9), Case.creer(Couleur::NOIR, 1, 9), Case.creer(Couleur::NOIR, 2, 9), Case.creer(Couleur::NOIR, 3, 9), Case.creer(Couleur::NOIR, 4, 9), Case.creer(Couleur::NOIR, 5, 9), Case.creer(Couleur::NOIR, 6, 9), Case.creer(Couleur::NOIR, 7, 9), Case.creer(Couleur::NOIR, 8, 9), Case.creer(Couleur::NOIR, 9, 9)]
        ], [180,160,120]) )

        Sauvegardes.getInstance.getSauvegardeScore.ajouterGrille
}
=end

        SauvegardeGrille.getInstance.sauvegarder( "../Sauvegarde/grilles1.dump" )



        @@lg = Sauvegardes.getInstance.getSauvegardeLangue

        provider = Gtk::CssProvider.new
        provider.load(path: "style.css")
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
        Parametre.initialiseToi

        Fenetre.set_modeSombre( Sauvegardes.getInstance.getSauvegardeParametre.modeSombre? )
    end

    ##
    # Méthode qui permet d'initialiser une seule fois une fenetre
    def self.initialiseToi()
        puts @@window
        if @@window == nil
            new()
        else
            puts "Window allready initalize"
        end
    end


    ##
    # méthode qui permet d'afficher la fenetre
    def self.show_all()
        if @@window == nil
            puts "Fenetre non initaliser"
        else
            @@window.show_all
        end
    end

    ##
    # Méthode qui permet de changer les sous-titre de la fenetre
    def self.set_subtitle(subtitle)
        @@window.titlebar.subtitle  = subtitle
    end

    ##
    # Méthode qui permet d'ajouter un element à la fenetre
    def self.add(obj)
        @@window.add(obj)
    end

    ##
    # Méthode qui permet de supprimer un element de la fenetre
    def self.remove(obj)
        @@window.remove(obj)
    end


    ##
    # Méthode qui permet de supprimer toutes les classes filles sauf la headerbar
    def self.deleteChildren()
        i = 0
        while @@window.children.length > 1
            if( @@window.children[i] == @@window.titlebar )
                i += 1
            end
            @@window.remove( @@window.children[i] )
        end
    end

    ##
    # Méthode qui dispatch le mode sombre
    def self.set_modeSombre(statut)
        provider = Gtk::CssProvider.new
        if statut

            Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderDarkMode, Gtk::StyleProvider::PRIORITY_APPLICATION)

            if(Sauvegardes.getInstance.getSauvegardeParametre.casesGrises?)
                Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayMode)
                Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayDarkMode, Gtk::StyleProvider::PRIORITY_APPLICATION)
            end
        else

            Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderDarkMode)

            if(Sauvegardes.getInstance.getSauvegardeParametre.casesGrises?)
                Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayDarkMode)
                Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayMode, Gtk::StyleProvider::PRIORITY_APPLICATION)
            end
        end
    end

    ##
    # Methode pour le mode gris
    def self.set_modeGris(statut)
        if statut
            if(Sauvegardes.getInstance.getSauvegardeParametre.modeSombre?)
                Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayDarkMode, Gtk::StyleProvider::PRIORITY_APPLICATION)
            else
                Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayMode, Gtk::StyleProvider::PRIORITY_APPLICATION)
            end
        else
            Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayMode)
            Gtk::StyleContext.remove_provider_for_screen(Gdk::Screen.default,@@cssProviderGrayDarkMode)
        end
    end


    ##
    # Méthode pour quitter
    def self.exit()
        # FAIRE DES TRUCS
        socket = Fenetre1v1.getSocket()
        if(socket!= nil)
            socket.puts("dc")
        end
        Sauvegardes.getInstance.sauvegarder(nil)
        Gtk.main_quit
    end

=begin

    # Methode pour creer une fenetre
    def Fenetre.creer(title)
       new(title)
    end

    # Methode privee pour l'initialisation
    def initialize(title)

        @application = Gtk::Window.new(title)
        @application.set_default_size(745,671)
        @application.set_height_request(790)
        @application.set_width_request(745)
        @application.set_resizable(false)
        @application.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
        # HEADERBAR
        @header = Gtk::HeaderBar.new
        @header.show_close_button = true
        @header.name = "headerbar"
        @header.subtitle = "t4est"
        @application.titlebar = @header
        @application.title = title

        listenerQuitter
        provider = Gtk::CssProvider.new
        provider.load(path: "style.css")
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
        @@window = @application
    end

        # Methode qui permet d'ouvrir la fenetre
    def ouvrir()
        @application.show_all
    end

    # Methode qui permet de fermer la fenetre
    def listenerQuitter()
        @application.signal_connect('destroy'){
            Gtk.main_quit()
        }
    end
=end

end

################## INITALISATION DE LA FENETRE ###################################
Fenetre.initialiseToi()
Parametre.initialiseToi()
