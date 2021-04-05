# Classe qui gere les langues

class Langue
    # nom de la langue
    attr_reader :langues, :langueActuelle

    private_class_method :new

    @@monInstance = nil

    # Methode qui permet de creer une grille
    def Langue.creer()
        if (@@monInstance == nil)
          @@monInstance = new()
        else
          puts "instance lg already exist"
        end

        return @@monInstance
    end

    def self.getInstance()
      return @@monInstance
    end

    def utiliserLangue(id)
      puts "charger langue #{id}"
      @dico = Marshal.load( File.binread(@fichiersLangues[id]) )
      @langueActuelle = id
    end

    def importer(chemin)
      puts "chemin : #{chemin}"

      fichier = chemin.split('/').last
      if(fichier == chemin)
        fichier = chemin.split('\\').last
      end
      puts "fichier : #{fichier}"

      f = File.read(chemin)
      File.foreach(chemin) { |line| puts "aahhh #{line}" }


    end

    # Methode privee pour l'initialisation
    def initialize()
      
      #@dico = Marshal.load( File.binread("../Parametres/Fr_fr.dump") )


      

     
      @dico = Hash.new
      @dico["MESSAGE_DE_VICTOIRE"] = "Congratulations! You've won!"
      @dico["LIBRE"] = "Free play"
      @dico["CONTRELAMONTRE"] = "Time trial"
      @dico["SURVIE"] = "Survival"
      @dico["TUTORIEL"] = "Tutorial"
      @dico["CLASSEMENT"] = "Ranking"
      @dico["PARAMETRES"] = "Settings"
      @dico["A_PROPOS"] = "About"
      @dico["QUITTER"] = "Quit"
      @dico["FACILE"] = "Easy"
      @dico["MENU"] = "Menu"
      @dico["MOYEN"] = "Medium"
      @dico["DIFFICILE"] = "Hard"
      @dico["MEILLEUR_SCORE"] = "Best Score"
      @dico["ACTUALISER"] = "Update"
      @dico["RETOUR"] = "Back"
      @dico["JEU"] = "Game"
      @dico["UTILISATEUR"] = "User"
      @dico["INTERFACE"] = "Interface"
      @dico["AUDIO"] = "Audio"
      @dico["GRILLE"] = "Grid"
      @dico["PARTIE"] = "Game"
      @dico["AUCUN_RECORD"] = "No record"
      @dico["GRILLES"] = "Grids"
      @dico["MON_SCORE"] = "My time  "
      @dico["CASESGRISES"] = "Grey cells"
      @dico["COMPTEURILOTS"] = "Island counter"
      @dico["AFFICHERPORTER"] = "Island range"
      @dico["MURS2x2"] = "2x2 Walls"
      @dico["SUPPRIMER_SAUVEGARDE_PARTIE_EN_COURS"] = "Delete current game saves"
      @dico["RESET_PARAMETRE"] = "Reset to default settings"
      @dico["MODESOMBRE"] = "Dark mode"
      @dico["CHOISIRLANGUE"] = "Choose language"
      @dico["IMPORTERLANGUE"] = "Import language"
      @dico["SELECTION_MODE_LIBRE"] = "Grid selection"
      @dico["PARTIE_LIBRE"] = "Free play game"
      @dico["PARTIE_CLM"] = "Time trial game"
      @dico["OK"] = "Ok"
      @dico["PARTIE_SURVIE"] = "Survival game"
      @dico["OUI"] = "Yes"
      @dico["NON"] = "No"
      @dico["REPRENDRE_SAUVEGARDE"] = "Do you want to resume your saving ?"
      @dico["PARTIE_TUTORIEL"] = "Tutorial"
      @dico["APROPOSCONTENT"] = "
Nurikabe (ぬりかべ) is a Japanese puzzle in the style of sudoku.


This game, sometimes called \"island in the stream\", is a binary solving puzzle.


One can decide, for each cell, if it is white or black according to very precise rules.


The puzzle is solved on a rectangular grid of cells, some of which contain numbers.


Two cells are connected if they are adjacent vertically or horizontally,
but not diagonally.


The white cells constitute the islands while the connected black cells constitute the
the river.


The player scores cells without numbers that he is sure belong to an island with one point.
belong to an island.



This application was developed within the framework of a university project by :


BOUHANDI Asmae
CHAUMULON Cassandra
EL KANDOUSSI Adnan
LECOMTE Hugo
MAHI Samy
MARIN Timothée
RICHEFEU Mattéo
STER Maxime

      "
     
      tmpSaver("../Parametres/EN_en.dump")

@dico = Hash.new
      @dico["MESSAGE_DE_VICTOIRE"] = "¡Felicidades! Has ganado!"
      @dico["LIBRE"] = "Juego libre"
      @dico["CONTRELAMONTRE"] = "Contrarreloj"
      @dico["SURVIE"] = "Supervivencia"
      @dico["TUTORIEL"] = "Tutorial"
      @dico["CLASSEMENT"] = "Clasificación"
      @dico["PARAMETRES"] = "Configuración"
      @dico["A_PROPOS"] = "Sobre"
      @dico["QUITTER"] = "Salir"
      @dico["FACILE"] = "Fácil"
      @dico["MENU"] = "Menú"
      @dico["MOYEN"] = "Medio"
      @dico["DIFFICILE"] = "Difícil"
      @dico["MEILLEUR_SCORE"] = "Mejor puntuación"
      @dico["ACTUALISER"] = "Actualización"
      @dico["RETOUR"] = "Volver"
      @dico["JEU"] = "Juego"
      @dico["UTILISATEUR"] = "Usuario"
      @dico["INTERFACE"] = "Interfaz"
      @dico["AUDIO"] = "Audio"
      @dico["GRILLE"] = "Rejilla"
      @dico["PARTIE"] = "Juego"
      @dico["AUCUN_RECORD"] = "Sin registro"
      @dico["GRILLES"] = "Rejillas"
      @dico["MON_SCORE"] = "Mi tiempo"
      @dico["CASESGRISES"] = "Celdas grises"
      @dico["COMPTEURILOTS"] = "Contador de islas"
      @dico["AFFICHERPORTER"] = "Rango de la isla"
      @dico["MURS2x2"] = "Muros 2x2"
      @dico["SUPPRIMER_SAUVEGARDE_PARTIE_EN_COURS"] = "Borrar partidas guardadas actuales"
      @dico["RESET_PARAMETRE"] = "Restablecer la configuración por defecto"
      @dico["MODESOMBRE"] = "Modo oscuro"
      @dico["CHOISIRLANGUE"] = "Elegir idioma"
      @dico["IMPORTERLANGUE"] = "Importar idioma"
      @dico["SELECTION_MODE_LIBRE"] = "Selección de cuadrícula"
      @dico["PARTIE_LIBRE"] =  "Juego libre"
      @dico["PARTIE_CLM"] = "Juego contrarreloj"
      @dico["OK"] = "Ok"
      @dico["PARTIE_SURVIE"] = "Juego de supervivencia"
      @dico["OUI"] = "Sí"
      @dico["NON"] = "No"
      @dico["REPRENDRE_SAUVEGARDE"] = "¿Quiere reanudar su ahorro?"
      @dico["PARTIE_TUTORIEL"] = "Tutorial"
      @dico["APROPOSCONTENT"] = "
Nurikabe (ぬりかべ) es un rompecabezas japonés al estilo del sudoku.


Este juego, a veces llamado \"isla en la corriente\", es un rompecabezas de resolución binaria.


Uno puede decidir, para cada celda, si es blanca o negra según reglas muy precisas.


El rompecabezas se resuelve en una cuadrícula rectangular de celdas, algunas de las cuales contienen números.


Dos celdas están conectadas si son adyacentes vertical u horizontalmente,
pero no en diagonal.


Las celdas blancas constituyen las islas, mientras que las celdas negras conectadas constituyen
el río.


El jugador puntúa con un punto las casillas sin números de las que está seguro que pertenecen a una isla.
pertenecen a una isla.



Esta aplicación fue desarrollada en el marco de un proyecto universitario por :


BOUHANDI Asmae
CHAUMULON Cassandra
EL KANDOUSSI Adnan
LECOMTE Hugo
MAHI Samy
MARIN Timothée
RICHEFEU Mattéo
STER Maxime

      "
      tmpSaver("../Parametres/ES_es.dump")


      @dico = Hash.new
      @dico["MESSAGE_DE_VICTOIRE"] = "Félicitations ! Vous avez gagné !"
      @dico["LIBRE"] = "Libre"
      @dico["CONTRELAMONTRE"] = "Contre-La-Montre"
      @dico["SURVIE"] = "Survie"
      @dico["TUTORIEL"] = "Tutoriel"
      @dico["CLASSEMENT"] = "Classement"
      @dico["MENU"] = "Menu"
      @dico["PARAMETRES"] = "Paramètres"
      @dico["A_PROPOS"] = "À Propos"
      @dico["QUITTER"] = "Quitter"
      @dico["FACILE"] = "Facile"
      @dico["MOYEN"] = "Moyen"
      @dico["DIFFICILE"] = "Difficle"
      @dico["MEILLEUR_SCORE"] = "Meilleur Score"
      @dico["ACTUALISER"] = "Actualiser"
      @dico["RETOUR"] = "Retour"
      @dico["JEU"] = "Jeu"
      @dico["UTILISATEUR"] = "Utilisateur"
      @dico["INTERFACE"] = "Interface"
      @dico["AUDIO"] = "Audio"
      @dico["GRILLE"] = "Grille"
      @dico["PARTIE"] = "Partie"
      @dico["AUCUN_RECORD"] = "Aucun record"
      @dico["GRILLES"] = "Grilles"
      @dico["MON_SCORE"] = "Mon temps"
      @dico["CASESGRISES"] = "Cases grises"
      @dico["COMPTEURILOTS"] = "Compteur d'île"
      @dico["AFFICHERPORTER"] = "Portée d'île"
      @dico["MURS2x2"] = "Murs 2x2"
      @dico["SUPPRIMER_SAUVEGARDE_PARTIE_EN_COURS"] = "Supprimer les sauvegardes de parties en cours"
      @dico["RESET_PARAMETRE"] = "Remettre les paramètres par défaut"
      @dico["MODESOMBRE"] = "Mode sombre"
      @dico["CHOISIRLANGUE"] = "Choisir langue"
      @dico["IMPORTERLANGUE"] = "Importer langue"
      @dico["SELECTION_MODE_LIBRE"] = "Selection de grille"
      @dico["PARTIE_LIBRE"] = "Partie libre"
      @dico["PARTIE_CLM"] = "Partie contre-la-montre"
      @dico["OK"] = "Ok"
      @dico["PARTIE_SURVIE"] = "Partie survie"
      @dico["OUI"] = "Oui"
      @dico["NON"] = "Non"
      @dico["REPRENDRE_SAUVEGARDE"] = "Voulez-vous reprendre la sauvegarde ?"
      @dico["PARTIE_TUTORIEL"] = "Tutoriel"
      @dico["APROPOSCONTENT"] = "
Le Nurikabe (ぬりかべ) est un puzzle japonais dans le style du sudoku.


Ce jeu, quelquefois appelé « ilot dans le courant », est un puzzle à résolution binaire.


On peut décider, pour chaque cellule, si elle est blanche ou noir en fonction de règles
bien précises.



Le puzzle se résout sur une grille rectangulaire de cellules, dont certaines contiennent
des nombres.


Deux cellules sont connectées si elles sont adjacentes verticalemen ou horizontalement,
mais pas en diagonale.


Les cellules blanches constituent les îlots alors que les cellules noires connectées constituent
le fleuve.


Le joueur marque d'un point les cellules sans numéro dont il est sûr qu'elles appartiennent
à un îlot.



Cette application a été dévellopée dans le cadre d'un projet universitaire par :

BOUHANDI Asmae
CHAUMULON Cassandra
EL KANDOUSSI Adnan
LECOMTE Hugo
MAHI Samy
MARIN Timothée
RICHEFEU Mattéo
STER Maxime

      "
      tmpSaver("../Parametres/FR_fr.dump")

      @langues = ["Français", "English", "Español"]
      @fichiersLangues = ["../Parametres/FR_fr.dump", "../Parametres/EN_en.dump" , "../Parametres/ES_es.dump"]
      @langueActuelle = 0
     
      
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

#Langue.creer("../Parametres/ES_es.dump")
#Langue.getInstance.tmpSaver("../Parametres/FR_fr.dump")
