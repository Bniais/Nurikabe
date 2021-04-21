require_relative 'Couleur.rb'

##
# Classe qui représente une case d'une grille
class Case

  
  private_class_method :new

  ##
  # Coordonnée X de la case
  attr_reader :positionX
  
  ##
  # Coordonnée Y de la case
  attr_reader :positionY

  ##
  # Type de la case
  attr_accessor :couleur

  ##
  # Constructeur de case avec une couleur et sa position sur la grille
  def Case.creer(uneCouleur, posX, posY)
    new(uneCouleur,posX,posY)
  end

  ##
  # Initialise la case avec une position et une couleur
  def initialize(uneCouleur,posX,posY)
      @couleur = uneCouleur
      @positionX = posX
      @positionY = posY
  end

  ##
  # Retourne vrai si la case est une ile, faux sinon
  def estIle?()
    if couleur >= Couleur::ILE_1
      return true
    else
      return false
    end
  end

end
