require_relative 'Case.rb'

# Classe qui gere les grilles

class Grille

    attr_reader :numero, :tabCases, :paliers

    # Methode qui permet de creer une grille
    def Grille.creer(numero, tabCases, paliers)
		new(numero, tabCases, paliers)
    end

    # Methode privee pour l'initialisation
    def initialize(numero, tabCases, paliers)
		@numero, @tabCases, @paliers = numero, tabCases, paliers
    end

    # Methode qui remet a zero la grille
    def raz()
		for i in 0..tabCases.size-1
			for j in 0..tabCases.size-1
				if tabCases[i][j].couleur == Couleur::BLANC || tabCases[i][j].couleur == Couleur::NOIR   # -1 = couleur blanche
					tabCases[i][j].couleur = Couleur::GRIS                                                 # -2 = couleur grise 
				end                                                                                     # -3 = couleur noir
			end
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

   

    # Methode qui envoie la grille suivante
    def grilleSuivante()
		return nil
    end

    #renvoie le nombre d'erreur dans la grille 
    def nbDifference(grilleCmp)
		#return int
		erreur = 0
		for i in 0..tabCases.size - 1
			for j in 0..tabCases.size - 1
				
				if tabCases[i][j].couleur != Couleur::GRIS && tabCases[i][j].couleur != grilleCmp.tabCases[i][j].couleur 
					
					erreur += 1                             
				end                                                                          
			end
		end

		return erreur             

    end

	def nbDifferenceBrut(grilleCmp)
		#return int
		erreur = 0
		for i in 0..tabCases.size - 1
			for j in 0..tabCases.size - 1
				if tabCases[i][j].couleur != grilleCmp.tabCases[i][j].couleur 
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