# Classe qui gere les langues

LIBRE = 1
CONTRE-LA-MONTRE = 2
SURVIE = 3
TUTORIEL = 4
CLASSEMENT = 5
PARAMETRES = 6
A_PROPOS = 7
QUITTER = 8
FACILE = 9
MOYEN = 10
DIFFICILE = 11
MEILLEUR_SCORE = 12
ACTUALISER = 13
RETOUR = 14
JEU = 15
UTILISATEUR = 16
INTERFACE = 17
AUDIO = 18
CASES_GRISES = 19
COMPTEUR_D_ILOT = 20
AFFICHER_PORTEE = 21
MURS_2X2 = 22
MODE_SOMBRE = 23
CHOISIR_UNE_LANGUE = 24
IMPORTER_UNE_LANGUE = 25
GRILLE = 26
PARTIE = 27

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

langue = Langue.creer("fr.txt")
