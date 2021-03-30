# Classe qui gere la sauvegarde du score
class SauvegardeScore
    attr_reader :score

    # Methode qui permet de sauvegarder un score
    def sauvegarder(monscore)
        @score = monscore
        chemin = "SauvegardeScore/score.txt"
        File.open(chemin, "wb") { |f| f.write(Marshal.dump(@score) ) }
    end

    # Methode qui permet de charger un score donne
    def charger(chemin)
        #
    end
end