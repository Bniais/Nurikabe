##
# Classe qui gère la sauvegarde de partie
class SauvegardesParties

    ##
    # Tableau qui contient des sauvegardes de Partie
    @mesParties = nil

    ##
    # Initialise la sauvegarde de partie avec un tableau de parties vide
    def initialize()
        @mesParties = Array.new
    end

    ##
    # Supprime toutes les sauvegardes de parties, sauf celle en cours (passée en paramètre)
    def resetAll(unePartie)
        @mesParties = Array.new
        if(unePartie != nil)
            @mesParties.push(unePartie)
        end
    end

    ##
    # Retourne la partie présente à un indice donné
    def getPartie( indice )
        return @mesParties[indice]
    end

    ##
    # Ajoute une partie au tableau
    def ajouterSauvegardePartie( unePartie )
        @mesParties.push(unePartie)
    end
    ##
    # Supprime une partie du tableau
    def supprimerSauvegardePartie( unePartie )
        @mesParties.delete(unePartie)
    end

    ##
    # Retourne le nombre de parties sauvegardées
    def nbPartieSauvegarder()
        return @mesParties.size
    end

    ##
    # Renvoie un tableau de booleen qui indique si une grille est en cours ou pas
    def getListPartieLibreEnCours()
        monTab = Array.new( SauvegardeGrille.getInstance.getNombreGrille + 1 ) {false}
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::LIBRE
                monTab[@mesParties[i].grilleBase.numero ] = true
            end
        end
        return monTab
    end

    ##
    # Permet de retrouver si une sauvegarde existe pour un numéro de grille particulié pour le mode libre
    def getIndicePartieLibreSauvegarder( numGrille )
        indice = -1;
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].grilleBase.numero == numGrille && @mesParties[i].getMode == Mode::LIBRE
                indice = i
            end
        end
        return indice
    end



    ##
    # Retourne l'indice de la première partie en mode Survie
    def getIndicePartieSauvegarderSurvie()
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::SURVIE
                return i;
            end
        end
        return -1;
    end


    ##
    # Retourne l'indice de la première partie en mode Contre La Montre
    def getIndicePartieSauvegarderContreLaMontre()
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::CONTRE_LA_MONTRE
                return i;
            end
        end
        return -1;
    end

end

