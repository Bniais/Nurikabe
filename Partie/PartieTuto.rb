class PartieTuto < Partie
  private_class_method :new
  attr_accessor :grille, :progression, :senarios
  ##
  #ceer une partie en mode survie
  def PartieTuto.creer(grille)
    new(grille)
  end
  ##
  #Contructeur de PartieTuto
  def initalize()
    super(grille)
  end
  ##
  #Tire lla prochaine grille
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
