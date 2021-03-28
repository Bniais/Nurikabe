# Classe qui gere les langues

TXT_PARTIE_LIBRE = 0
TXT_CONTRE_LA_MONTRE = 1
TXT_MODE_SURVIE = 2

class Langue
    # nom de la langue
    attr_reader :nomLangue
    # repertoire du fichier de langue
    attr_reader :repertoireLangue
    # tableau contenant le texte
    attr_reader :dico
    private_class_method :new

    # Methode qui permet de creer une grille
    def Langue.creer(chemin)
        new(chemin)
    end

    # Methode privee pour l'initialisation
    def initialize(chemin)
        @repertoireLangue = chemin
        @dico = File.readlines(@repertoireLangue)
    end

    def get_text(indice)
      return @dico[indice]
    end

    def to_s()
      return "#{@dico}"
    end
end
