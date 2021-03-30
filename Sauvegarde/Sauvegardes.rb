# Classe qui contient l'ensemble des sauvegardes
require '../Partie/Partie.rb'
require '../Parametres/Parametre.rb'

#require './SauvegardePartie.rb'

class Sauvegardes

    ROOT_FILE = "save.dump"

    @@instanceSauvegarde = nil
    

    @sauvegardePartie = nil
    @sauvegardeParametre = nil

    def initialize
        if File.exist?(ROOT_FILE) == true 
            @@instanceSauvegarde = Marshal.load( File.binread( ROOT_FILE ) )
        else
            @@instanceSauvegarde = self
        end
    end

    def self.creer
        if @@instanceSauvegarde == nil
            new()
        else 
            puts "Save already exist"
        end
    end

    def self.getInstance()
        return @@instanceSauvegarde
    end



    def sauvegarder 
        File.open(ROOT_FILE, "wb") { |f| f.write(Marshal.dump(@@instanceSauvegarde) ) }
    end

    def getSauvegardePartie()
        if @sauvegardePartie == nil
            @sauvegardePartie = SauvegardesParties.new()
            return @sauvegardePartie
        else 
            return @sauvegardePartie
        end
    end

    def getSauvegardeParametre()
        if @sauvegardeParametre == nil
            @sauvegardeParametre = Parametre.initialiseToi()
        else 
            @sauvegardeParametre
        end
    end

end



class SauvegardesParties < Sauvegardes 

    @mesParties = nil

    def initialize()
        @mesParties = Array.new
    end

    def getPartie( indice )
        return @mesParties[indice]
    end

    def ajouterSauvegardePartie( unePartie )
        @mesParties.push(unePartie)
    end

    def nbPartieSauvegarder()
        return @mesParties.size
    end
end



Sauvegardes.creer()

maPartie = Partie.creer(Grille.creer(4, 
[
  [Case.creer(Couleur::GRIS, 0, 0) ,Case.creer(Couleur::ILE_4, 1, 0),Case.creer(Couleur::NOIR, 2, 0),Case.creer(Couleur::ILE_5, 3, 0), Case.creer(Couleur::GRIS, 4, 0)],
  [Case.creer(Couleur::GRIS, 0, 1), Case.creer(Couleur::GRIS, 1, 1), Case.creer(Couleur::NOIR, 2, 1), Case.creer(Couleur::GRIS, 3, 1), Case.creer(Couleur::GRIS, 4, 1)],
  [Case.creer(Couleur::GRIS, 0, 2), Case.creer(Couleur::NOIR, 1, 2), Case.creer(Couleur::ILE_1, 2, 2), Case.creer(Couleur::NOIR, 3, 2), Case.creer(Couleur::GRIS, 4, 2)],
  [Case.creer(Couleur::ILE_4, 0, 3), Case.creer(Couleur::GRIS, 1, 3), Case.creer(Couleur::NOIR, 2, 3), Case.creer(Couleur::GRIS, 3, 3), Case.creer(Couleur::GRIS, 4, 3)],
  [Case.creer(Couleur::GRIS, 0, 4), Case.creer(Couleur::GRIS, 1, 4), Case.creer(Couleur::GRIS, 2, 4), Case.creer(Couleur::GRIS, 3, 4), Case.creer(Couleur::GRIS, 4, 4)]
]), nil, nil)

Sauvegardes.getInstance().getSauvegardePartie().ajouterSauvegardePartie(  maPartie    )


maPartie.grilleEnCours.tabCases[0][0].couleur = 18

puts Sauvegardes.getInstance().getSauvegardePartie().nbPartieSauvegarder

puts Sauvegardes.getInstance().getSauvegardeParametre.modeSombre?

Sauvegardes.getInstance.sauvegarder()



