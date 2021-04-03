require_relative "SauvegardeGrille.rb"

class SauvegardesScore

    attr_reader :scoresContreLaMontre, :scoresSurvie

    @scoresContreLaMontre = nil
    @scoresSurvie = nil

    def initialize()
        @scoresContreLaMontre = Array.new(SauvegardeGrille.getInstance.getNombreGrille+1){-1}
        @scoresSurvie = Array.new(3){-1}
        afficher
    end

    def resetAll
        @scoresContreLaMontre = Array.new(SauvegardeGrille.getInstance.getNombreGrille+1){-1}
        @scoresSurvie = Array.new(3){-1}
    end


    def afficher
        for g in 1..SauvegardeGrille.getInstance.getNombreGrille
            puts "score pour grille  #{g} : #{@scoresContreLaMontre[g]}"
        end

        puts "\n\n score pour survie : #{@scoresSurvie[0]} , #{@scoresSurvie[1]} , #{@scoresSurvie[2]}"
    end

    def ajouterTempsContreLaMontre(num, tps)
        if(@scoresContreLaMontre[num] > tps)
            @scoresContreLaMontre[num] = tps
            #attribuer récompenses
        end
    end
end