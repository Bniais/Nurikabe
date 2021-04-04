class PartieContreLaMontre < PartieMalus
  private_class_method :new

  # Creer un partie contre la montre en prenant en compte les sauvegardes
  def PartieContreLaMontre.creer(grille, parametres, sauvegardes)
    new(grille, parametres, sauvegardes)
  end

  # Constructeur de PartieContreLaMontre
  def initialize(grille, parametres, sauvegardes) 
      super(grille, parametres, sauvegardes)
  end

  # Renvoie le mode Contre la montre
  def getMode
      return Mode::CONTRE_LA_MONTRE
  end

  # Retourne le nombre de récompenses de la partie actuelle
  def getNbRecompense
    @grilleBase.getNbRecompense(@chrono.time)
  end
end
