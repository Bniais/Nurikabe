class PartieContreLaMontre < PartieMalus
  private_class_method :new

  #ceer un partie contre la montre
  def PartieContreLaMontre.creer(grille, parametres, sauvegardes)
    new(grille, parametres, sauvegardes)
  end

  def initialize(grille, parametres, sauvegardes) #Créer une nouvelle partie
      super(grille, parametres, sauvegardes)
  end

  def getMode
      return Mode::CONTRE_LA_MONTRE
  end

  def getNbRecompense
    @grilleBase.getNbRecompense(@chrono.time)
  end
end
