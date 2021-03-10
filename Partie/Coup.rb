class Coup < Partie
  private_class_method :new

  attr_accessor :case, :couleur, :couleurBase

  def creer(case_, couleur, couleurBase)
    new(case_, couleur, couleurBase)
  end

  def initialize(case_, couleur, couleurBase)
    @case, @couleur, @couleurBase = case_, couleur, couleurBase
  end
end
