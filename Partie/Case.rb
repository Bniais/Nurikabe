load 'Couleur.rb'

class Case

  attr_accessor :couleur, :positionX, :positionY

  def Case.creer(uneCouleur, posX, posY)
      #
      new(uneCouleur,posX,posY)

  end

  def initialize(uneCouleur,posX,posY)

      @couleur = uneCouleur
      @positionX = posX
      @positionY = posY
      
  end


  private_class_method :new

  #change la couleur de la case
  def setCouleur( nouvelleCouleur )
    #return void
    @couleur = nouvelleCouleur

  end

  # dit si la case est une ile
  def estIle?()

    #return bool

    if couleur >= Couleur::ILE_1
      return true
    else
      return false
    end
  end

end
/