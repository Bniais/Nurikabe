# Classe qui gere les langues

LIBRE = 1
CONTRELAMONTRE = 2
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

    @@monInstance = nil

    # Methode qui permet de creer une grille
    def Langue.creer(chemin)
        if (@@monInstance == nil)
          @@monInstance = new(chemin)
        else 
          puts "instance already exist"
          @@monInstance
        end
    end

    def self.getInstance()
      return @@monInstance
    end

    # Methode privee pour l'initialisation
    def initialize(chemin)
        @dico = Hash.new
        @dico["LIBRE"] = "Libre"
        @dico["CONTRELAMONTRE"] = "Contre-La-Montre"
        @dico["SURVIE"] = "Survie"
        @dico["TUTORIEL"] = "Tutoriel"
        @dico["CLASSEMENT"] = "Classement"
        @dico["PARAMETRES"] = "Parametres"
        @dico["A_PROPOS"] = "A Propos"
        @dico["QUITTER"] = "Quitter"
        @dico["FACILE"] = "Facile"
        @dico["MOYEN"] = "Moyen"
        @dico["DIFFICILE"] = "Difficle"
        @dico["MEILLEUR_SCORE"] = "Meilleur Score"
        @dico["ACTUALISER"] = "Actueliser"
        @dico["RETOUR"] = "Retour"
        @dico["JEU"] = "Jeu"
        @dico["UTILISATEUR"] = "Utilisateur"
        @dico["INTERFACE"] = "Interface"
        @dico["AUDIO"] = "Audio"
        @dico["CASES_GRISES"] = "Cases Grises"
        @dico["COMPTEUR_D_ILOT"] = "Compteur d'Ilot"
        @dico["MURS_2X2"] = "Murs 2x2"
        @dico["MODE_SOMBRE"] = "Mode sombre"
        @dico["CHOISIR_UNE_LANGUE"] = "Choisir une langue"
        @dico["IMPORTER_UNE_LANGUE"] = "Importer une langue"
        @dico["GRILLE"] = "Grille"
        @dico["PARTIE"] = "Partie"
    end

    def tmpSaver (chemin)
      File.open(chemin, "w") { |f| f.write Marshal.dump(@dico) }
    end

    def gt(text)
      if ( @dico[text] == nil )
        return "UNDEF " + text.to_s
      end
      return @dico[text]
    end

    def to_s()
      return "#{@dico}"
    end
end

#Langue.creer("../Parametres/fr.txt")
#Langue.getInstance.tmpSaver("../Parametres/FR_fr.dump")
