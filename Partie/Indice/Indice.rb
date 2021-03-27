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
		"Il existe une case adjacente à une île de valeur 1, et qui ne peut donc pas être blanche",
		"Il existe une case adjacente à deux îles, elle ne peut donc pas être blanche sinon les deux îles seraient collées",
		"Il existe une case adjacente à deux îles, elle ne peut donc pas être blanche sinon les deux îles seraient collées",
		"Il existe une case adjacente à une île complète, elle ne peut donc pas être blanche, sinon l'île déborderait",
		"Il existe une case isolée : il n'y a aucun chemin qui la mène vers une île",
		"Il existe une case d'expension obligée pour éviter qu'un mur se retrouve isolé",
		"Il existe une case d'expension obligée pour éviter que deux murs soient séparés",
		"Il existe une case d'expension obligée pour qu'une île se dévelloppe",
		"Il existe une île presque terminée qui ne peut s'étendre que dans deux direction, les deux ayant une case adjacente en commun qui ne pourra donc pas être blanche",
		"Il existe une case d'expension obligée pour qu'une île se dévellope assez",
		"Il y a un presque un bloc de mur 2x2, la case restante ne peut donc pas être noire",
		"Une case blanche qui n'est pas reliée à une île passe nécessairement par une case pour rejoindre l'île",
		"Une case est trop loin de toutes île et est donc inatteignable"]
end