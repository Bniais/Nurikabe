class Indice
	INDICE_UNKNOWN = 0
	INDICE_ILE_1 = 1
	INDICE_ILE_ADJACENTE = 2
	INDICE_ILE_ADJACENTE_DIAG = 3
	INDICE_ILE_COMPLETE = 4
	INDICE_CASE_ISOLEE = 5
	INDICE_EXPENSION_MUR = 6
	INDICE_CONTINUITE_MUR = 7
	INDICE_EXPENSION_ILE = 8
	INDICE_EXPENSION_2D = 9
	INDICE_EXPENSION_CACHEE = 10
	INDICE_EVITER_2x2 = 11
	INDICE_CONTINUITE_ILE = 12
	INDICE_ILE_INATTEIGNABLE = 13

	MESSAGES = ["Message non spécifié",
		"Cette case est adjacente à une île de valeur 1, et ne peut donc pas être blanche",
		"Cette case est adjacente à deux îles, elle ne peut donc pas être blanche sinon les deux îles seraient collées",
		"Cette case est adjacente à deux îles, elle ne peut donc pas être blanche sinon les deux îles seraient collées",
		"Cette case est adjacente à une île complète, et ne peut donc pas être blanche, sinon l'île déborderait",
		"Cette case est isolée : il n'y a aucun chemin menant vers une île",
		"Cette case est une case d'expension obligée pour que le mur adjacent ne soit pas isolé",
		"Cette case est une case d'expension obligée pour que les deux murs adjacents soient liés",
		"Cette case est une case d'expension obligée pour que l'île adjacente se dévellope assez",
		"Une case d'île présente à la diagonale ne peut s'étendre que dans deux direction et ne peut pas atteindre cette case. Dans les deux directions possible, cette case est adjacente et ne peut donc pas être blanche.",
		"Cette case est une case d'expension obligée pour que l'île adjacente se dévellope assez",
		"Si cette case était noire, il se formerait un bloc noir de taille 2x2",
		"Cette case est une case d'expension obligée pour que l'île rejoigne une portion d'île qui lui appartient",
		"Cette case est trop loin de toutes île et est donc inatteignable"]
end