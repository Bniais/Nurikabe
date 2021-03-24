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

  # Constantes utilisees pour les changements de vue
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

    # ajout des vues à la fenetre
    (0..4).each do |i|
      @mainBox.pack_start(@views[i])
    end

    # quitter quand la fenetre est detruite
    @application.signal_connect('destroy') { detruire }

    # ajout de la box princiaple a la fenetre
    @application.add(@mainBox)
    self.ouvrir()

    # cacher toutes les vues sauf celle du menu principal
    (1..4).each do |i|
      @views[i].hide()
    end
  end

  # Methode qui permet de creer la vue 1
  def creerViewMenuPrincipal()
    box = Gtk::Box.new(:vertical, 10)

    # creation du label pour le titre + ajout à la box
    titre = Gtk::Label.new()
    titre.set_markup("<span weight = 'ultrabold' size = '100000' >Nurikabe</span>")
    setmargin(titre, 0, 0, 70, 70)
    box.pack_start(titre)

    # creation de la grille avec les boutons de modes
    modes = Gtk::Grid.new()
    tabLabels = ['Libre', 'Contre-la-montre', 'Survie', 'Tutoriel']
    listeBtn = Array.new()

    # creation des boutons de mode de jeu + attachement à la grille
    for x in 0..3
      listeBtn << Gtk::Button.new()
      setBold(listeBtn.at(x), tabLabels.at(x))
      setmargin(listeBtn.at(x), 0, 15, 70, 70)
      modes.attach(listeBtn.at(x),  0, x, 1, 1)
    end

    modes.set_column_homogeneous(true)
    # ajout de la grille de boutons à la box
    box.pack_start(modes)

    # gestion des évènements des boutons
    listeBtn[0].signal_connect('clicked') do
      puts 'click libre'
      @mode = Mode::LIBRE
    end
    listeBtn[1].signal_connect('clicked') do
      puts 'click contre-la-montre'
      changerVue(@indexCourant, CONTRE_LA_MONTRE)
      @mode = Mode::CONTRE_LA_MONTRE
    end
    listeBtn[2].signal_connect('clicked') do
      puts 'click survie'
      changerVue(@indexCourant, SURVIE)
      @mode = Mode::SURVIE
    end
    listeBtn[3].signal_connect('clicked') do
      puts 'click tuto'
      @mode = Mode::TUTORIEL
    end

    # ajout des boutons du bas
    ajouterBtnBas(box)
    return box
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
    tabLabels = ['Libre', 'Survie', 'Tutoriel']
    listeBtn = Array.new()

    # creation des boutons de mode de jeu
    for x in 0..2
      listeBtn << Gtk::Button.new()
      setBold(listeBtn.at(x), tabLabels.at(x))
      setmargin(listeBtn.at(x), 0, 15, 70, 70)
    end

    # gestion des évènements
    listeBtn[0].signal_connect('clicked') do
      puts 'click libre'
      @mode = Mode::LIBRE
    end
    listeBtn[1].signal_connect('clicked') do
      puts 'click survie'
      changerVue(@indexCourant, SURVIE)
      @mode = Mode::SURVIE
    end
    listeBtn[2].signal_connect('clicked') do
      puts 'click tuto'
      @mode = Mode::TUTORIEL
    end

    # creation de la grille des boutons de niveau pour le mode Contre-la-montre
    gridContreLaMontre = Gtk::Grid.new()
    tabLabelsNiv = ['Facile', 'Moyen', 'Difficile']
    listeBtnNiv = Array.new()

    # creation des boutons de niveaux + attachement
    for x in 0..2
      listeBtnNiv << Gtk::Button.new()
      setBold(listeBtnNiv.at(x), tabLabelsNiv.at(x))
      setmargin(listeBtnNiv.at(x), 0, 15, 70, 15)
      listeBtnNiv.at(x).set_width_request(180)
      gridContreLaMontre.attach(listeBtnNiv.at(x), x, 0, 1, 1)
    end

    # gestion des evenements
    listeBtnNiv[0].signal_connect('clicked') do
      puts 'click facile'
      @difficulte = Difficulte::FACILE
    end
    listeBtnNiv[1].signal_connect('clicked') do
      puts 'click moyen'
      @difficulte = Difficulte::MOYEN
    end
    listeBtnNiv[2].signal_connect('clicked') do
      puts 'click difficile'
      @difficulte = Difficulte::DIFFICILE
    end

    # attachement des boutons de mode de jeu
    modes.attach(listeBtn[0], 0, 0, 1, 1)
    modes.attach(gridContreLaMontre, 0, 1, 1, 1)
    modes.attach(listeBtn[1], 0, 2, 1, 1)
    modes.attach(listeBtn[2], 0, 3, 1, 1)
    modes.set_column_homogeneous(true)

    box.pack_start(modes)

    ajouterBtnBas(box)
    return box
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

    tabLabels = ['Libre', 'Contre-la-montre', 'Tutoriel']
    listeBtn = Array.new()

    # creation des boutons de mode de jeu
    for x in 0..2
      listeBtn << Gtk::Button.new()
      setBold(listeBtn.at(x), tabLabels.at(x))
      setmargin(listeBtn.at(x), 0, 15, 70, 70)
    end

    # gestion des évènements
    listeBtn[0].signal_connect('clicked') do
      puts 'click libre'
      @mode = Mode::LIBRE
    end
    listeBtn[1].signal_connect('clicked') do
      puts 'click contre-la-montre'
      changerVue(@indexCourant, CONTRE_LA_MONTRE)
      @mode = Mode::CONTRE_LA_MONTRE
    end
    listeBtn[2].signal_connect('clicked') do
      puts 'click tuto'
      @mode = Mode::TUTORIEL
    end

    # creation de la grille des niveaux
    gridSurvie = Gtk::Grid.new()
    tabLabelsNiv = ['Facile', 'Moyen', 'Difficile']
    listeBtnNiv = Array.new()

    # creation des boutons de niveaux + attachement
    for x in 0..2
      listeBtnNiv << Gtk::Button.new()
      setBold(listeBtnNiv.at(x), tabLabelsNiv.at(x))
      setmargin(listeBtnNiv.at(x), 0, 15, 70, 15)
      listeBtnNiv.at(x).set_width_request(180)
      gridSurvie.attach(listeBtnNiv.at(x), x, 0, 1, 1)
    end

    # gestion des evenements
    listeBtnNiv[0].signal_connect('clicked') do
      puts 'click facile'
      @difficulte = Difficulte::FACILE
    end
    listeBtnNiv[1].signal_connect('clicked') do
      puts 'click moyen'
      @difficulte = Difficulte::MOYEN
    end
    listeBtnNiv[2].signal_connect('clicked') do
      puts 'click difficile'
      @difficulte = Difficulte::DIFFICILE
    end

    # attachement des boutons de mode de jeu
    modes.attach(listeBtn[0], 0, 0, 1, 1)
    modes.attach(listeBtn[1], 0, 1, 1, 1)
    modes.attach(gridSurvie, 0, 2, 1, 1)
    modes.attach(listeBtn[2], 0, 3, 1, 1)

    modes.set_column_homogeneous(true)
    box.pack_start(modes, expand: true, fill: true)

    ajouterBtnBas(box)
    return box
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
  # def listenerChoixGrille
  # #
  # end
  #
  # # Methode qui permet d'ouvrir la fenetre des parametres
  # def listenerOuvrirOption
  #   #
  # end
  #
  # # Methode qui permet de quitter la fenetre de menu
  # def listenerQuitter
  # #
  # end

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

##################### CODE DE TEST DE LA CLASSE #####################

fenetreMenu = FenetreMenu.creer('Nurikabe')
fenetreMenu.afficher()

Gtk.main
