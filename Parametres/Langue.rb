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
        @dico = Marshal.load( File.binread(chemin) )

=begin
        @dico = Hash.new
        @dico["MESSAGE_DE_VICTOIRE"] = "Félicitations ! Vous avez gagné !"
        @dico["LIBRE"] = "Libre"
        @dico["CONTRELAMONTRE"] = "Contre-La-Montre"
        @dico["SURVIE"] = "Survie"
        @dico["TUTORIEL"] = "Tutoriel"
        @dico["CLASSEMENT"] = "Classement"
        @dico["PARAMETRES"] = "Parametres"
        @dico["A_PROPOS"] = "À Propos"
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
        @dico["APROPOSCONTENT"] = "
        Le Nurikabe (ぬりかべ) est un puzzle japonais dans le style du sudoku. Ce jeu, quelquefois appelé « ilot dans le courant », est un puzzle à résolution binaire.

        On peut décider, pour chaque cellule, si elle est blanche ou noir en fonction de règles bien précises. Le puzzle se résout sur une grille rectangulaire de cellules, dont certaines contiennent des nombres. Deux cellules sont connectées si elles sont adjacentes verticalement ou horizontalement, mais pas en diagonale. Les cellules blanches constituent les îlots alors que les cellules noires connectées constituent le fleuve. Le joueur marque d'un point les cellules sans numéro dont il est sûr qu'elles appartiennent à un îlot. 
        
                             -----------------------------------------

        Le mot Nurikabe signifie « Peindre le mur » en japonais. Cela vient en réalité d’un un démon (yokai) de la folklore japonaise. 
        
        Sa 1ère apparition dans une peinture remonterait à ce tableau de Tourin Kanou en 1802. Selon la légende, ce Yokai apparaît la nuit, bloquant le passage aux personnes qui souhaitent travers. Impossible de le contourner ni par la gauche, ni par la droite, ni de l’escalader. Le secret pour le faire disparaît est de frapper deux fois le sol à l’aide d’un bâton. 
        
        Il existe deux représentations de celui ci. La représentation sous forme d’un chien à trois yeux et ayant les oreilles tombantes est la plus ancienne. La deuxième représenta est celle d’un mur avec des jambes (et quelques fois un visage).
                
      "
=end
    end

    def tmpSaver (chemin)
      File.open(chemin, "wb") { |f| f.write(Marshal.dump(@dico) ) }
      @dico =  Marshal.load( File.binread(chemin) )
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

Langue.creer("../Parametres/FR_fr.dump")
#Langue.getInstance.tmpSaver("../Parametres/FR_fr.dump")
