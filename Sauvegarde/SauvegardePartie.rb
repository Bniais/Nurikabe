# Classe qui gere la sauvegarde de partie


class SauvegardesParties

    @mesParties = nil

    def initialize()
        @mesParties = Array.new
    end

    def resetAll(unePartie)
        @mesParties = Array.new
        if(unePartie != nil)
            @mesParties.push(unePartie)
        end
    end

    def getPartie( indice )
        return @mesParties[indice]
    end

    def ajouterSauvegardePartie( unePartie )
        @mesParties.push(unePartie)
    end

    def supprimerSauvegardePartie( unePartie )
        @mesParties.delete(unePartie)
    end

    def nbPartieSauvegarder()
        return @mesParties.size
    end

    def nbPartieSauvegarderLibre()
        compteur = 0;
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::LIBRE
                compteur += 1;
            end
        end
        compteur
    end

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

    def nbPartieSauvegarderSurvie()
        compteur = 0;
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::SURVIE
                compteur += 1;
            end
        end
        compteur
    end

    def getIndicePartieSauvegarderSurvie()
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::SURVIE
                return i;
            end
        end
        return -1;
    end

    def nbPartieSauvegarderContreLaMontre()
        compteur = 0;
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::CONTRE_LA_MONTRE
                compteur += 1;
            end
        end
        compteur
    end

    def getIndicePartieSauvegarderContreLaMontre()
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::CONTRE_LA_MONTRE
                return i;
            end
        end
        return -1;
    end

    def nbPartieSauvegarderTutoriel()
        compteur = 0;
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::TUTORIEL
                compteur += 1;
            end
        end
        compteur
    end 

    def getIndicePartieSauvegarderTutoriel()
        for i in 0...nbPartieSauvegarder
            if @mesParties[i].getMode == Mode::TUTORIEL
                return i;
            end
        end
        return -1;
    end

end

