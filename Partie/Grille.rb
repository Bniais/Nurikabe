require_relative 'Case.rb'

##
# Classe qui gere les grilles
class Grille

	##
	# @numero => numero de la grille
	# @tabCases => tableau des cases de la grille
	# @paliers => paliers de temps pour les étoiles
    attr_reader :numero, :tabCases, :paliers

    ##
    # Methode qui permet de creer une grille
    def Grille.creer(numero, tabCases, paliers)
		new(numero, tabCases, paliers)
    end

    ##
    # Methode privee pour l'initialisation
    def initialize(numero, tabCases, paliers)
		@numero, @tabCases, @paliers = numero, tabCases, paliers
    end

    ##
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


	##
	# Methode qui permet de
	# retourner le pourcentage
	# de complexion d'une grille
	def getPourcentage(grilleCmp, caseIgn)
		nbCase = 0.0
		nbSame = 0.0
		for i in 0..tabCases.size - 1
			for j in 0..tabCases.size - 1
				if !tabCases[i][j].estIle?
					if(tabCases[i][j] != caseIgn && tabCases[i][j].couleur == grilleCmp.tabCases[i][j].couleur)
						nbSame += 1
					end
					nbCase += 1
				end
			end
		end
		return nbSame/nbCase
	end


    ##
    #Retourne le nombre de récompenses du joueur
	def getNbRecompense(tps)
		for i in 0..2
		if(paliers[2-i] >= tps)
			return (2-i)+1
		end
		end
		return 0
	end

    ##
    #Renvoie le nombre d'erreur dans la grille
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

    ##
    # Methode qui permet de renvoyer le nombre d'erreur dans la grille avec un if moins contrainiant
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

    ##
    #Renvoie la premiere erreur trouver dans la grille
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