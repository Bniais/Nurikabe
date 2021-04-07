class PartieTuto < Partie
  private_class_method :new
  attr_accessor :grille, :progression, :senarios
  ##
  #Creer une partie en mode survie
  def PartieTuto.creer(grille)
    new(grille)
  end
  ##
  #Constructeur de PartieTuto
  def initalize()
    super(grille)
  end
  ##
  #Tire la prochaine grille
  def grilleSuivante()
    return nil
    #redef
  end
  ##
  #Retourne le mode Tutoriel
  def getMode()
    return Mode::TUTORIEL
  end
end
