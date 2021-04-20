##
# Classe qui représente les différents malus pendant une partie
class Malus
   	##
   	# Malus pour avoir utilisé une verification d'erreur
	MALUS_VERIFICATION = 10

	##
	# Malus pour avoir utilisé l'aide de localisation d'erreur
	MALUS_DONNER_ERREUR = 15

	##
	# Malus pour être revenu au dernier bon coup
	MALUS_POS_BONNE = 20

	##
	# Malus pour avoir utilisé le premier indice
	MALUS_INDICE = 15

	##
   	# Malus pour avoir utilisé une deuxième fois l'indice (localisation de l'indice)
	MALUS_INDICE_POS = 20 

	private_class_method :new
end