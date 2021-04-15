##
# Classe qui représente un coup du joueur
class Coup
  private_class_method :new

  ##
  # Variables d'instance :
  # @case => Case ciblée par le joueur
  # @couleur => nouvelle couleur de la case
  # @couleurBase => ancienne couleur de la case
  attr_reader :case, :couleur, :couleurBase

  ##
  # Constructeur de la class Coup
  # methode qui permet d'appeler
  # new sous un autre nom
  def Coup.creer(case_, couleur, couleurBase)
    new(case_, couleur, couleurBase)
  end

  ##
  #Constructeur de Coup
  def initialize(case_, couleur, couleurBase)
    @case, @couleur, @couleurBase = case_, couleur, couleurBase
  end
end
