# Classe qui gere les langues
class Langue
    # nom de la langue
    attr_reader :nomLangue
    # repertoire du fichier de langue
    attr_reader :repertoireLangue

    private_class_method :new

    # Methode qui permet de creer une grille
    def Langue.creer(chemin)
        new(chemin)
    end

    # Methode privee pour l'initialisation
    def initialize(chemin)
        @repertoireLangue = chemin
    end
end