# frozen_string_literal: true

load 'Fenetre.rb'
load '../Partie/Mode.rb'
load '../Partie/Difficulte.rb'
load 'FenetreAPropos.rb'
load 'FenetreParametre.rb'

require 'gtk3'

Gtk.init

# Classe qui gere la fenetre du menu
class FenetreMenu < Fenetre

  attr_reader :indexCourant
  attr_accessor :views

  MENU = 0
  CONTRE_LA_MONTRE = 1
  SURVIE = 2
  APROPOS = 3
  PARAMETRE = 4

  # Methode privee pour l'initialisation
  def initialize(title)
    super(title)
    @views = Array.new()
    @indexCourant = MENU

    @views << creerViewMenuPrincipal()
    @views << creerViewContreLaMontre()
    @views << creerViewSurvie()

    fpropos = FenetreAPropos.creer(self)
    fparam = FenetreParametre.creer(self)

    @views << fpropos.view # vue a propos
    @views << fparam.view # vue des parametres

    @mode = nil
    @difficulte = nil
  end

  # Methode qui permet de changer de vue
  def changerVue(ancienne, nouvelle)
    @views.at(ancienne).set_visible(false)
    @views.at(nouvelle).set_visible(true)
    @indexCourant = nouvelle
  end

  # Methode d'affichage
  def afficher()
    # creation de la box principale
    @mainBox = Gtk::Box.new(:vertical, 0)

    # ajout des vues à la fenêtre
    (0..4).each do |i|
      @mainBox.pack_start(@views[i])
    end

    # quitter quand la fenetre est detruite
    @application.signal_connect('destroy') { detruire }

    # ajout de la box princiaple a la fenetre
    @application.add(@mainBox)
    self.ouvrir()

    # cacher les vues par defaut
    (1..4).each do |i|
      @views[i].hide()
    end

  end

  # Methode qui permet de creer la vue 1
  def creerViewMenuPrincipal()
    box = Gtk::Box.new(:vertical, 10)

    # creation du label pour le titre
    titre = Gtk::Label.new()
    titre.set_markup("<span weight = 'ultrabold' size = '100000' >Nurikabe</span>")
    setmargin(titre, 0, 0, 70, 70)
    box.pack_start(titre)

    # creation de la grille avec les boutons de modes
    modes = Gtk::Grid.new()

    # creation des boutons de mode de jeu
    btnLibre = Gtk::Button.new()
    setBold(btnLibre, 'Libre')
    setmargin(btnLibre, 0, 15, 70, 70)

    btnContre = Gtk::Button.new()
    setBold(btnContre, 'Contre-la-montre')
    setmargin(btnContre, 0, 15, 70, 70)

    btnSurvie = Gtk::Button.new
    setBold(btnSurvie, 'Survie')
    setmargin(btnSurvie, 0, 15, 70, 70)

    btnTuto = Gtk::Button.new
    setBold(btnTuto, 'Tutoriel')
    setmargin(btnTuto, 0, 15, 70, 70)

    # gestion des évènements
    btnLibre.signal_connect('clicked') do
      puts 'click libre'
      @mode = Mode::LIBRE
    end
    btnContre.signal_connect('clicked') do
      puts 'click contre-la-montre'
      changerVue(@indexCourant, CONTRE_LA_MONTRE)
      @mode = Mode::CONTRE_LA_MONTRE
    end
    btnSurvie.signal_connect('clicked') do
      puts 'click survie'
      changerVue(@indexCourant, SURVIE)
      @mode = Mode::SURVIE
    end
    btnTuto.signal_connect('clicked') do
      puts 'click tuto'
      @mode = Mode::TUTORIEL
    end

    # attachement des boutons de mode de jeu
    modes.attach(btnLibre,  0, 0, 1, 1)
    modes.attach(btnContre, 0, 1, 1, 1)
    modes.attach(btnSurvie, 0, 2, 1, 1)
    modes.attach(btnTuto,   0, 3, 1, 1)
    modes.set_column_homogeneous(true)
    box.pack_start(modes)

    # ajout des boutons du bas
    ajouterBtnBas(box)
    box
  end

  # Methode qui permet de creer la vue pour les choix contre-la-montre
  def creerViewContreLaMontre()
    box = Gtk::Box.new(:vertical, 10)

    # creation du label pour le titre
    titre = Gtk::Label.new()
    titre.set_markup("<span weight = 'ultrabold' size = '100000' >Nurikabe</span>")
    setmargin(titre, 0, 0, 70, 70)
    box.pack_start(titre)

    # creation de la grille avec les boutons de modes
    modes = Gtk::Grid.new()

    # creation des boutons de mode de jeu
    btnLibre = Gtk::Button.new()
    setBold(btnLibre, 'Libre')
    setmargin(btnLibre, 0, 15, 70, 70)

    btnContre = Gtk::Button.new()
    setBold(btnContre, 'Contre-la-montre')
    setmargin(btnContre, 0, 15, 70, 70)

    gridContreLaMontre = Gtk::Grid.new()
    # creation des boutons de choix de niveaux
    btnFacile = Gtk::Button.new()
    setBold(btnFacile, 'Facile')
    setmargin(btnFacile, 0, 15, 70, 15)
    btnFacile.set_width_request(215)

    btnMoyen = Gtk::Button.new()
    setBold(btnMoyen, 'Moyen')
    setmargin(btnMoyen, 0, 15, 15, 15)
    btnMoyen.set_width_request(215)

    btnDifficile = Gtk::Button.new()
    setBold(btnDifficile, 'Difficile')
    setmargin(btnDifficile, 0, 15, 15, 70)
    btnDifficile.set_width_request(215)

    # attachement des boutons de choix de niveaux
    gridContreLaMontre.attach(btnFacile,    0, 0, 1, 1)
    gridContreLaMontre.attach(btnMoyen,     1, 0, 1, 1)
    gridContreLaMontre.attach(btnDifficile, 2, 0, 1, 1)

    btnSurvie = Gtk::Button.new()
    setBold(btnSurvie, 'Survie')
    setmargin(btnSurvie, 0, 15, 70, 70)

    btnTuto = Gtk::Button.new()
    setBold(btnTuto, 'Tutoriel')
    setmargin(btnTuto, 0, 15, 70, 70)

    # gestion des évènements
    btnLibre.signal_connect('clicked') do
      puts 'click libre'
      @mode = Mode::LIBRE
    end
    btnContre.signal_connect('clicked') do
      puts 'click contre-la-montre'
      changerVue(@indexCourant, CONTRE_LA_MONTRE)
      @mode = Mode::CONTRE_LA_MONTRE
    end
    btnSurvie.signal_connect('clicked') do
      puts 'click survie'
      changerVue(@indexCourant, SURVIE)
      @mode = Mode::SURVIE
    end
    btnTuto.signal_connect('clicked') do
      puts 'click tuto'
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
    box
  end

  # Methode qui permet de creer la vue pour les choix survie
  def creerViewSurvie()
    box = Gtk::Box.new(:vertical, 10)

    # creation du label pour le titre
    titre = Gtk::Label.new()
    titre.set_markup("<span weight = 'ultrabold' size = '100000' >Nurikabe</span>")
    setmargin(titre, 0, 0, 70, 70)
    box.pack_start(titre)

    # creation de la grille avec les boutons de modes
    modes = Gtk::Grid.new()

    # creation des boutons de mode de jeu
    btnLibre = Gtk::Button.new()
    setBold(btnLibre, 'Libre')
    setmargin(btnLibre, 0, 15, 70, 70)

    btnContre = Gtk::Button.new()
    setBold(btnContre, 'Contre-la-montre')
    setmargin(btnContre, 0, 15, 70, 70)

    gridSurvie = Gtk::Grid.new()
    # creation des boutons de choix de niveaux
    btnFacile = Gtk::Button.new()
    setBold(btnFacile, 'Facile')
    setmargin(btnFacile, 0, 15, 70, 15)
    btnFacile.set_width_request(215)

    btnMoyen = Gtk::Button.new()
    setBold(btnMoyen, 'Moyen')
    setmargin(btnMoyen, 0, 15, 15, 15)
    btnMoyen.set_width_request(215)

    btnDifficile = Gtk::Button.new()
    setBold(btnDifficile, 'Difficile')
    setmargin(btnDifficile, 0, 15, 15, 70)
    btnDifficile.set_width_request(215)

    # attachement des boutons de choix de niveaux
    gridSurvie.attach(btnFacile,    0, 0, 1, 1)
    gridSurvie.attach(btnMoyen,     1, 0, 1, 1)
    gridSurvie.attach(btnDifficile, 2, 0, 1, 1)

    btnContre = Gtk::Button.new()
    setBold(btnContre, 'Contre-la-montre')
    setmargin(btnContre, 0, 15, 70, 70)

    btnTuto = Gtk::Button.new()
    setBold(btnTuto, 'Tutoriel')
    setmargin(btnTuto, 0, 15, 70, 70)

    # gestion des évènements
    btnLibre.signal_connect('clicked') do
      puts 'click libre'
      @mode = Mode::LIBRE
    end
    btnContre.signal_connect('clicked') do
      puts 'click contre-la-montre'
      changerVue(@indexCourant, CONTRE_LA_MONTRE)
      @mode = Mode::CONTRE_LA_MONTRE
    end
    btnTuto.signal_connect('clicked') do
      puts 'click tuto'
      @mode = Mode::TUTORIEL
    end

    #  ligne - colonne
    # attachement des boutons de mode de jeu
    modes.attach(btnLibre, 0, 0, 1, 1)
    modes.attach(btnContre, 0, 1, 1, 1)
    modes.attach(gridSurvie, 0, 2, 1, 1)
    modes.attach(btnTuto, 0, 3, 1, 1)
    modes.set_column_homogeneous(true)
    box.pack_start(modes, expand: true, fill: true)

    ajouterBtnBas(box)
    box
  end

  # Methode qui permet d'ajouter les boutons 'parametres', 'a propos' et 'quitter'
  def ajouterBtnBas(box)
    btnClassement = Gtk::Button.new(label: 'Classement')
    btnClassement.set_height_request(60)
    setmargin(btnClassement, 15, 15, 70, 70)

    # AJOUT SEPARATEUR
    separateur = Gtk::Separator.new(:horizontal)
    setmargin(separateur, 0, 0, 80, 80)
    box.pack_start(separateur)

    box.pack_start(btnClassement)

    # AJOUT SEPARATEUR
    separateur = Gtk::Separator.new(:horizontal)
    setmargin(separateur, 0, 0, 80, 80)
    box.pack_start(separateur)

    grilleBas = Gtk::Grid.new
    setmargin(grilleBas, 15, 0, 70, 70)

    # creation des boutons
    btnParam = Gtk::Button.new(label: 'Paramètres')
    btnParam.set_height_request(60)
    btnAPropos = Gtk::Button.new(label: 'A propos')

    btnAPropos.signal_connect('clicked') do
      puts 'click a Propos'
      changerVue(@indexCourant, APROPOS)
    end

    btnParam.signal_connect('clicked') do
      puts 'click a Propos'
      changerVue(@indexCourant, PARAMETRE)
    end

    labelBtnQuit = Gtk::Label.new

    labelBtnQuit.set_markup("<span foreground='#a4a400000000' >Quitter</span>")
    btnQuit = Gtk::Button.new
    btnQuit.add(labelBtnQuit)
    btnQuit.signal_connect('clicked') { detruire() }

    # attachement des boutons
    grilleBas.attach(btnParam, 0, 0, 1, 1)
    grilleBas.attach(btnAPropos, 1, 0, 1, 1)
    grilleBas.attach(btnQuit, 2, 0, 1, 1)

    grilleBas.set_column_homogeneous(true)
    box.pack_start(grilleBas, expand: true, fill: true)
  end

  # Methode qui renvoie le mode choisi par l'utilisateur
  def getMode
    @mode
  end

  # Methode qui renvoie le niveau de difficulte choisi par l'utilisateur
  def getDifficulte
    @difficulte
  end

  # Methode qui renvoie la grille choisie par l'utilisateur
  def listenerChoixGrille
  #
  end

  # Methode qui permet d'ouvrir la fenetre des parametres
  def listenerOuvrirOption
    #
  end

  # Methode qui permet de quitter la fenetre de menu
  def listenerQuitter
  #
  end

  def setmargin(obj, top, bottom, left, right)
    obj.set_margin_top(top)
    obj.set_margin_bottom(bottom)
    obj.set_margin_left(left)
    obj.set_margin_right(right)
    nil
  end

  # Methode qui permet de mettre en gras un label
  def setBold(btn, nom)
    label = Gtk::Label.new
    label.set_markup("<span weight = 'ultrabold'>#{nom}</span>")
    btn.add(label)
    btn.set_height_request(70)
  end
end

##################### CODE DE TEST DE LA CLASSE #####################

fenetreMenu = FenetreMenu.creer('Nurikabe')
fenetreMenu.afficher()

Gtk.main
