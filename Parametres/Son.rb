# Classe qui gere les effets sonores
class Son
    ##
    # chemin pour acceder au fichier du son
    attr_reader :chemin

    private_class_method :new

    ##
    # Methode pour creer un nouveau son
    def Son.creer(chemin)
        new(chemin)
    end

    ##
    # Methode privee pour l'initialisation
    def initialize(chemin)
        @chemin = chemin
    end
end