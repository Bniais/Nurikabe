class Indice
	INDICE_UNKNOWN = 0
	# si il y a une ile de valeur 1 et case grise à coté => on lui indique que ça doit être une case noire
	INDICE_ILE_1 = 1
	# 2 îles séparées par une case grise => doit être noire
	INDICE_ILE_ADJACENTE = 2
	# idem sauf que les îles sont en diagonale
	INDICE_ILE_ADJACENTE_DIAG = 3
	# île complète (assez de cases blanches) et adjacente à une case grise (doit être noire)
	INDICE_ILE_COMPLETE = 4
	# île qui n'a aucun chemin possible (entourée par des murs)
	INDICE_CASE_ISOLEE = 5
	# bloc de mur qui a un seul voisin gris (doit être noir) et qui a d'autres murs noirs autre part
	INDICE_EXPENSION_MUR = 6
	# idem sauf 1 seule case qui peut reliée 2 blocs de mur (OPTION)
	INDICE_CONTINUITE_MUR = 7
	# comme expansion mur qd une île a une seule case grise (doit être blanche)
	INDICE_EXPENSION_ILE = 8
	# île presque terminée (plus qu'une seule case) avec 2 voisins gris => case adjacente doit être noire
	INDICE_EXPENSION_2D = 9
	# PAS A FAIRE
	INDICE_EXPENSION_CACHEE = 10
	# mur 2 * 2
	INDICE_EVITER_2x2 = 11
	# continuité mur (14h03)
	INDICE_CONTINUITE_ILE = 12
	# case isolee mais prend en compte la distance (portée des îles)
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