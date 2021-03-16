class PartieTuto < Partie
  private_class_method :new
  attr_accessor :grille, :progression, :senarios

  #ceer une partie en mode survie
  def PartieTuto.creer()
    new()
  end

  #Tire lla prochaine grille
  def grilleSuivante()
    #return grille
  end

  #retourn en avant
  def retourAvant()
    #return void
  end
end
