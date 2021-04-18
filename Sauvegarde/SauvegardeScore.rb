require_relative "SauvegardeGrille.rb"

##
# Classe qui gère la sauvegarde des scores
class SauvegardesScore

    ##
    # Variables d'instance :
    # @scoresContreLaMontre => Tableau des scores en mode Contre la montre
    # @scoresSurvie => Tableau des scores en mode Survie
    # @nbEtoiles => Nombre d'étoiles que le joueur possède
    attr_reader :scoresContreLaMontre, :scoresSurvie, :nbEtoiles

    @scoresContreLaMontre = nil
    @scoresSurvie = nil
    @nbEtoiles = 0

    ##
    # Constructeur de SauvegardesScore
    def initialize()
        @nbEtoiles = 0
        @scoresContreLaMontre = Array.new(SauvegardeGrille.getInstance.getNombreGrille+1){[-1, 0]}
        @scoresSurvie = Array.new(3){-1}
    end

    ##
    # Methode qui re initialise toute 
    # les scores
    def resetAll
        @nbEtoiles = 0
        @scoresContreLaMontre = Array.new(SauvegardeGrille.getInstance.getNombreGrille+1){[-1, 0]}
        @scoresSurvie = Array.new(3){-1}
    end

    ##
    # Ajoute une grille au tableau
    def ajouterGrille()
        @scoresContreLaMontre.append([-1,0])
        Sauvegardes.getInstance.sauvegarder()
    end

    ##
    # Ajouter du temps au chrono en CLM
    def ajouterTempsContreLaMontre(num, tps)
        if(@scoresContreLaMontre[num][0] == -1 || @scoresContreLaMontre[num][0] > tps)
            
            @scoresContreLaMontre[num][0] = tps

            nouveauEtoile = SauvegardeGrille.getInstance.getGrilleAt(num).getNbRecompense(tps)
            
            @nbEtoiles +=  nouveauEtoile - @scoresContreLaMontre[num][1]
            @scoresContreLaMontre[num][1] = nouveauEtoile
        end
    end

    ##
    # Ajouter du temps au chrono en mode Survie
    def ajouterTempsSurvie(num, nbGrilleFinis)
        nbGrille = SauvegardeGrille.getInstance.getNombreGrille
        if num <= nbGrille/3
            diff = 0
        elsif num <= 2*nbGrille/3
            diff = 1
        else
            diff = 2
        end

        if(@scoresSurvie[diff] == -1 || @scoresSurvie[diff] < nbGrilleFinis)
            @scoresSurvie[diff] = nbGrilleFinis
            #attribuer récompenses
        end
    end
end