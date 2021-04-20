require_relative "SauvegardeGrille.rb"

##
# Classe qui gère la sauvegarde des scores
class SauvegardesScore

    ##
    # @scoresContreLaMontre => Tableau des scores et des étoiles en mode Contre la montre
    # @scoresSurvie => Tableau des scores en mode Survie
    # @nbEtoiles => Nombre d'étoiles que le joueur possède
    attr_reader :scoresContreLaMontre, :scoresSurvie, :nbEtoiles

    @scoresContreLaMontre = nil
    @scoresSurvie = nil
    @nbEtoiles = 0

    ##
    # Initialise la sauvegarde des scores en mettant un tableau de taille nbGrille à "Pas de record" et 0 étoile, et les records de survie à "Pas de record"
    def initialize()
        @nbEtoiles = 0
        @scoresContreLaMontre = Array.new(SauvegardeGrille.getInstance.getNombreGrille+1){[-1, 0]}
        @scoresSurvie = Array.new(3){-1}
    end

    ##
    # Réinitialise toute les scores, jamais appelée dans le programme (pour debug)
    def resetAll
        @nbEtoiles = 0
        @scoresContreLaMontre = Array.new(SauvegardeGrille.getInstance.getNombreGrille+1){[-1, 0]}
        @scoresSurvie = Array.new(3){-1}
    end

    ##
    # Ajoute une sauvegarde de score supplémentaire car nouvelle grille
    def ajouterGrille()
        @scoresContreLaMontre.append([-1,0])
        Sauvegardes.getInstance.sauvegarder()
    end

    ##
    # Ajoute un nouveau record sur la grille numéro "num" en contre la montre
    def ajouterTempsContreLaMontre(num, tps)
        if(@scoresContreLaMontre[num][0] == -1 || @scoresContreLaMontre[num][0] > tps)
            
            @scoresContreLaMontre[num][0] = tps

            nouveauEtoile = SauvegardeGrille.getInstance.getGrilleAt(num).getNbRecompense(tps)
            
            @nbEtoiles +=  nouveauEtoile - @scoresContreLaMontre[num][1]
            @scoresContreLaMontre[num][1] = nouveauEtoile
        end
    end

    ##
    # Ajoute un record en contre la montre 
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
        end
    end
end