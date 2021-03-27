require_relative 'Case.rb'

# Classe qui gere les grilles

class Grille
    # numero de la grille
    attr_reader :numero
    # tableau des cases de la grille
    attr_reader :tabCases
    # niveau de difficulte
    attr_reader :difficulte

    attr_reader :grille


    private_class_method :new

    # Methode qui permet de creer une grille
    def Grille.creer(numero, tabCases)
			new(numero, tabCases)
    end

    # Methode privee pour l'initialisation
    def initialize(numero, tabCases)
			@numero, @tabCases = numero, tabCases     
    end

    # Methode qui renvoie une case donnee en fonction de ses coordonnees
    def getCase(x,y)
			# return Case
			return tabCases[x][y]
    end

    # Methode qui remet a zero la grille
    def raz()
			for i in 0..tabCases.size-1
				for j in 0..tabCases.size-1
					if tabCases[i][j].couleur == Couleur::BLANC || tabCases[i][j].couleur == Couleur::NOIR   # -1 = couleur blanche
						mettreAJour( tabCases[i][j],Couleur::GRIS)                                                     # -2 = couleur grise 
					end                                                                                     # -3 = couleur noir
				end
			end                                                                        
    end

    # Methode qui permet de savoir si la grille est terminee ou non
    def grilleTerminee?()
			# return un booleen
			if grille[numero].nbDifference() != 0
				print "il reste encore #{grille[numero].nbDifference()}"
				return false
			else
				print "Bravo ! Tu as réussi"
				return true
			end
            
    end

    # Methode qui permet d'afficher la grille
    def afficher()
			for i in 0..tabCases.size-1
				for j in 0..tabCases.size-1
					print "| #{tabCases[i][j].couleur} "
				end
				print "|\n"
			end
    end

    # Methode qui permet de mettre a jour l'etat d'une case donnee
    def mettreAJour(uneCase,uneCouleur)
			#
			uneCase.setCouleur(uneCouleur)

    end

    # Methode qui ajoute une nouvelle grille
    def ajouterGrille(unChemin)
			#return boolean

    end

    # Methode qui envoie la grille suivante
    def grilleSuivante()
			#return Grille
			numero += 1

    end

    # Methode....................
    def Grille.charger()
			#
    end

    # Methode...................
    def Grille.ajouterGrille(chemin)
			#
    end

    #renvoie le nombre d'erreur dans la grille 
    def nbDifference(grilleCmp)
			#return int
			puts "grille cmp : "
			grilleCmp.afficher
			puts"\n\n"
			erreur = 0
			for i in 0..tabCases.size - 1
				for j in 0..tabCases.size - 1
					
					if tabCases[i][j].couleur != Couleur::GRIS && tabCases[i][j].couleur != grilleCmp.tabCases[i][j].couleur 
						puts "diff #{tabCases[i][j].couleur} #{grilleCmp.tabCases[i][j].couleur} at #{i} #{j}"    
						erreur += 1                             
					end                                                                          
				end
			end

			return erreur             

    end

    #renvoie la premiere erreur trouver dans la grille
    def firstDifference(grilleCmp)
			#return case
			for i in 0..tabCases.size - 1
				for j in 0..tabCases.size - 1
					if tabCases[i][j].couleur != Couleur::GRIS && tabCases[i][j].couleur != grilleCmp.tabCases[i][j].couleur     
						return tabCases[i][j]                                                    
					end                                                                          
				end
			end                                                                       
    end

end




=begin
c = Case.creer(Couleur::NOIR,0,0)
c1 = Case.creer(Couleur::BLANC,0,1)
c2 = Case.creer(Couleur::GRIS,1,0)
c3 = Case.creer(Couleur::ILE_1,1,1)

tab = [[c,c1],[c2,c3]]

g = Grille.creer(1,tab)

g.afficher()
=end