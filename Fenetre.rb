# Classe abstraite qui gere l'interface
class Fenetre
    # titre de la fenetre
    attr_accessor :titre
    # application
    attr_reader :application

    private_class_method :new

    # Methode pour creer une fenetre
    def Fenetre.creer(titre,application)
        new(titre,application)
    end

    # Methode qui permet d'ouvrir la fenetre
    def ouvrir()
        #
    end

    # Methode qui permet de fermer la fenetre
    def listenerQuitter()
        #
    end
end