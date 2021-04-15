require_relative 'Couleur.rb'
##
# Classe qui représente une case d'une grille
class Case

  ##
  # Variables d'instance de Case :
  # @couleur => type de la case
  # @positionX => Coordonnée X de la case
  # @positionY => Coordonnée Y de la case
  attr_accessor :couleur, :positionX, :positionY

  ##
  # Crée une case avec une couleur et sa position sur la grille
  def Case.creer(uneCouleur, posX, posY)
    new(uneCouleur,posX,posY)
  end

  ##
  #Constructeur de la case
  def initialize(uneCouleur,posX,posY)
      @couleur = uneCouleur
      @positionX = posX
      @positionY = posY
  end


  private_class_method :new

  ##
  #Change la couleur de la case
  def setCouleur( nouvelleCouleur )
    @couleur = nouvelleCouleur
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
