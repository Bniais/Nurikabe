require_relative 'Case.rb'

##
# Classe qui gere les grilles
class Grille

	##
	# @numero => numero de la grille
	# @tabCases => tableau des cases de la grille
	# @paliers => paliers de temps pour les étoiles
    attr_reader :numero, :tabCases, :paliers

	private_class_method :new

    ##
    # Constructeur de la grille
    def Grille.creer(numero, tabCases, paliers)
		new(numero, tabCases, paliers)
    end

    ##
    # Methode d'initialisation en spécifiant le numéro de grille, le tableau de cases, et les paliers des étoiles
    def initialize(numero, tabCases, paliers)
		@numero, @tabCases, @paliers = numero, tabCases, paliers
    end

    ##
    # Remet à zéro la grille
    def raz()
		for i in 0..tabCases.size-1
			for j in 0..tabCases.size-1
				if tabCases[i][j].couleur == Couleur::BLANC || tabCases[i][j].couleur == Couleur::NOIR
					tabCases[i][j].couleur = Couleur::GRIS
				end
			end
		end
    end


	##
	# Obtient le pourcentage de complétion de la grille selon la grilleCmp
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
    #Retourne le nombre de récompenses selon le temps passé en paramètre
	def getNbRecompense(tps)
		for i in 0..2
		if(paliers[2-i] >= tps)
			return (2-i)+1
		end
		end
		return 0
	end

    ##
    # Renvoie le nombre de différences entre cette grille et la grilleCmp en ignorant les cases grises
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
    # Renvoie le nombre de différences entre cette grille et la grilleCmp 
	def nbDifferenceBrut(grilleCmp)
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
    # Renvoie la première différence entre cette grille et la grilleCmp.
	# Parcours de gauche à droite et haut en bas
    def firstDifference(grilleCmp)
		for i in 0..tabCases.size - 1
			for j in 0..tabCases.size - 1
				if tabCases[i][j].couleur != Couleur::GRIS && tabCases[i][j].couleur != grilleCmp.tabCases[i][j].couleur
					return tabCases[i][j]
				end
			end
		end
    end

end