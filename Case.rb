class Case

  attr_accessor :couleur, :positionX, :positionY

  def Case.creer( uneCouleur, posX, posY)
    #
    @couleur = uneCouleur
    @positionX = posX
    @positionY = posY

  end


  #donne a couleur de la case
  def getCouleur()
    #return int
    return couleur

  end

  #donne la position X
  def getPositionX()
    #return int
    return positionX

  end

  #donne la position Y
  def getPositionY()
    #return int
    return positionY

  end

  #change la couleur de la case
  def setCouleur( nouvelleCouleur )
    #return void
    couleur = nouvelleCouleur

  end

end
