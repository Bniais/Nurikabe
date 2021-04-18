##
# Classe qui gere la sauvegarde de partie
class SauvegardesParties

    ##
    # Variable d'instance :
    # @mesParties => Tableau qui contient des instances de Partie
    @mesParties = nil

    ##
    # Constructeur de SauvegardesPartie
    def initialize()
        @mesParties = Array.new
    end

    ##
    # Methode qui re initialise toute 
    # les sauvegardes de Partie
    def resetAll(unePartie)
        @mesParties = Array.new
        if(unePartie != nil)
            @mesParties.push(unePartie)
        end
    end

    ##
    # Retourne une partie du table à un indice en paramètre
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
    # Methode qui permet de renvoyer un tableau 
    # qui indique si une grille est en cours ou pas
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
    # Methode qui permet de retrouver si une sauvegarde
    # existe pour un numero de grille particulier
    # pour le mode libre
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

