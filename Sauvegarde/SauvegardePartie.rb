# Classe qui gere la sauvegarde de partie
load 'Sauvegardes.rb'
class SauvegardePartie
    attr_reader :partie

    def initialize(unePartie)

        @grille = unePartie

    end

    def SauvegardePartie.creer(unePartie)
        new(unePartie)
    end 

    # Methode qui permet de sauvegarder une partie
    def sauvegarder(Partie)

        f = File.new("SauvegardePartie/#{Partie.mode}.#{Partie.grilleEnCours.numero}.txt", "w")
    
        
        for ligne in 0..Partie.grilleEnCours.tabCases.size-1
           for colonne in 0..Partie.grilleEnCours.tabCases.size-1

                f.write(Partie.grilleEnCours.tabCases[ligne][colonne].couleur)
                f.write("\n")
           end
        end

        for i in 0..Partie.tabCoup.size-1
            f.write


        f.close

    end

    # Methode qui permet de charger une partie donnee
    def charger(mode, grille)

        f = File.open("SauvegardePartie/#{mode}.#{grille.numero}.txt","r+")

        while (!f.eof?)

            for ligne in 0..grille.tabCases.size-1
                for colonne in 0..grille.tabCases.size-1
                    
                        grille.tabCases[ligne][colonne].couleur = f.readchar
                        f.readchar
                     
                end
            end

        end

        f.close
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
g1 = Grille.creer(1,tab1)

s = SauvegardePartie.creer(1,g)
s1 = SauvegardePartie.creer(1,g1)

s.sauvegarder(1,g)

s1.charger(1,g1)

g1.afficher

=end