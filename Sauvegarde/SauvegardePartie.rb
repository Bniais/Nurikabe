# Classe qui gere la sauvegarde de partie
require './Sauvegardes.rb'

class SauvegardePartie < Sauvegardes
    attr_reader :partie

    def initialize(unePartie)

        @partie = unePartie

    end

    def SauvegardePartie.creer(unePartie)
        new(unePartie)
    end 

    def getPartie()
        @partie
    end

end

=begin

c = Case.creer(Couleur::ILE_1,0,0)
c1 = Case.creer(Couleur::ILE_1,0,1)
c2 = Case.creer(Couleur::ILE_1,1,0)
c3 = Case.creer(Couleur::ILE_1,1,1)

c4 = Case.creer(nil,0,0)
c5 = Case.creer(nil,0,1)
c6 = Case.creer(nil,1,0)
c7 = Case.creer(nil,1,1)

tab = [[c,c1],[c2,c3]]

tab1 = [[c4,c5], [c6,c7]]



g = Grille.creer(1,tab)
#
g1 = Grille.creer(1,tab1)


p = Partie.creer(g,nil,nil)
p1 = Partie.creer(g1,nil,nil)

s = SauvegardePartie.creer(p)
s1 = SauvegardePartie.creer(p1)

s.sauvegarder(p)

s1.charger(p1)

g1.afficher

=end