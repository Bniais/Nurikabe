##
# Classe qui gere les recompenses
class SauvegardeRecompense
    # solde de recompense
    attr_reader :solde
    ##
    # Methode pour l'initialisation
    def initialize()
        @solde = 0
    end
    ##
    # Methode qui permet de depenser des recompenses
    def depenser(valeur)
        @solde -= valeur
    end
    ##
    # Methode qui permet d'ajouter des recompenses
    def ajouter(valeur)
        @solde += valeur
    end
end