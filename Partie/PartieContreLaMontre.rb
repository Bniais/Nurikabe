##
# Classe qui représente le mode de jeu Contre la montre
# Est une partieMalus
class PartieContreLaMontre < PartieMalus
  private_class_method :new

  ##
  # Constructeur de PartieContreLaMontre
  def PartieContreLaMontre.creer(grille)
    new(grille)
  end

  ##
  # Initialise la partie sans changement par rapport à une partie malus (et donc libre)
  def initialize(grille)
      super(grille)
  end

  ##
  # Renvoie le mode Contre la montre
  def getMode
      return Mode::CONTRE_LA_MONTRE
  end

  ##
  # Retourne le nombre de récompenses avec le temps actuel
  def getNbRecompense
    @grilleBase.getNbRecompense(@chrono.time)
  end
end
