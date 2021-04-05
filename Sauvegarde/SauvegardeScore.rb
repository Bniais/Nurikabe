require_relative "SauvegardeGrille.rb"

class SauvegardesScore

    attr_reader :scoresContreLaMontre, :scoresSurvie

    @scoresContreLaMontre = nil
    @scoresSurvie = nil
    @nbEtoiles = 0

    def initialize()
        @nbEtoiles = 0
        @scoresContreLaMontre = Array.new(SauvegardeGrille.getInstance.getNombreGrille+1){[-1, 0]}
        @scoresSurvie = Array.new(3){-1}
        afficher
    end

    def resetAll
        @nbEtoiles = 0
        @scoresContreLaMontre = Array.new(SauvegardeGrille.getInstance.getNombreGrille+1){[-1, 0]}
        @scoresSurvie = Array.new(3){-1}
    end

    def ajouterGrille()
        @scoresContreLaMontre.append([-1,0])
    end


    def afficher
        for g in 1..SauvegardeGrille.getInstance.getNombreGrille
            puts "score pour grille  #{g} : #{@scoresContreLaMontre[g][0]}, ça fait #{@scoresContreLaMontre[g][1]} etoile"
        end

        puts "\n score pour survie : #{@scoresSurvie[0]} , #{@scoresSurvie[1]} , #{@scoresSurvie[2]}"
    
        puts "\n nbEtoiles : #{@nbEtoiles}\n"

    end

    def ajouterTempsContreLaMontre(num, tps)
        if(@scoresContreLaMontre[num][0] == -1 || @scoresContreLaMontre[num][0] > tps)
            
            @scoresContreLaMontre[num][0] = tps

            nouveauEtoile = SauvegardeGrille.getInstance.getGrilleAt(num).getNbRecompense(tps)
            
            @nbEtoiles +=  nouveauEtoile - @scoresContreLaMontre[num][1]
            @scoresContreLaMontre[num][1] = nouveauEtoile
        end
    end

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