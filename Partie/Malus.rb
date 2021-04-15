##
# Classe qui représente les différents malus pendant une partie
class Malus
   	##
   	# Constantes :
   	# MALUS_VERIFICATION => Malus pour avoir utilisé une verification d'erreur
   	# MALUS_DONNER_ERREUR => Malus pour avoir utilisé l'aide d'affichage d'erreur
   	# MALUS_POS_BONNE => Malus pour être revenu au dernier bon coup
   	# MALUS_INDICE => Malus pour avoir utilisé le premier indice
   	# MALUS_INDICE2 => Malus pour avoir utilisé une deuxième fois l'indice
	MALUS_VERIFICATION = 10
	MALUS_DONNER_ERREUR = 15
	MALUS_POS_BONNE = 20
	MALUS_INDICE = 15
	MALUS_INDICE2 = 20 #donner localisation de l'indice

     private_class_method :new
end