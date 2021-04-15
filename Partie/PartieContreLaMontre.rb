##
# Classe qui représente le mode de jeu Contre la montre
class PartieContreLaMontre < PartieMalus
  private_class_method :new
  ##
  # Creer un partie contre la montre en prenant en compte les sauvegardes
  def PartieContreLaMontre.creer(grille)
    new(grille)
  end
  ##
  # Constructeur de PartieContreLaMontre
  def initialize(grille) 
      super(grille)
  end
  ##
  # Renvoie le mode Contre la montre
  def getMode
      return Mode::CONTRE_LA_MONTRE
  end
  ##
  # Retourne le nombre de récompenses de la partie actuelle
  def getNbRecompense
    @grilleBase.getNbRecompense(@chrono.time)
  end
end
