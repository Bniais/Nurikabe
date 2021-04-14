

class Partie1v1 < Partie
  private_class_method :new

  ##
  # Creer un partie contre la montre en prenant en compte les sauvegardes
  def Partie1v1.creer(grille)
    new(grille)
  end

  ##
  # Constructeur de PartieContreLaMontre
  def initialize(grille) 
    super(grille)
  end

  ##
  # Renvoie le mode Contre la montre
  def getMode
      return Mode::VS
  end


  # ENLEVER LES AIDES PAYANTES 
  def partieTerminee?()
    term = @grilleEnCours.nbDifferenceBrut(@grilleBase)

    if(term == 0)
        socket = Fenetre1v1.getSocket
        if(socket != nil)
          mettrePause
          socket.puts ("ez" + Chrono.getTpsFormatPrecis(@chrono.time))
        end
    end

    return term == 0
  end

  ##
  # Methode qui permet de verifier
  # si la grille comporte des erreurs
  # est desactiver car coute du temps
  def verifierErreur(fromUser)#TOTEST
    return 0
  end   


  ##
  # Methode qui permet d'ajouter
  # un coup et qui previent l'adversaire du 
  # pourcentage de la grille en cours
  def ajouterCoup(coup)
     if(coup.couleur != coup.case.couleur && coup.couleur < Couleur::ILE_1) 
      coup.case.couleur = coup.couleur
      @grilleRaz = nil
      tabCoup.pop(tabCoup.size - @indiceCoup) #supprimer les coups annulés
      tabCoup.push(coup)
      @indiceCoup += 1

      socket = Fenetre1v1.getSocket
      if(socket != nil)
        socket.puts ("av" + @grilleEnCours.getPourcentage(@grilleBase, nil).to_s )
      end

      return true
    end
    return false
  end

  ##
  # Methode qui revient en avant(le coup)
  def retourAvant()#TOTEST
    if(@indiceCoup < tabCoup.size) #vérification normalement inutile puisque le bouton devrait être disable
      #On annule en passant au coup suivant
      coupSuivant = tabCoup.at(@indiceCoup)
      @grilleEnCours.tabCases[coupSuivant.case.positionY][coupSuivant.case.positionX].setCouleur(coupSuivant.couleur)
      @grilleRaz = nil

      @indiceCoup += 1 #On passe au coup suivant

      socket = Fenetre1v1.getSocket
      if(socket != nil)
        socket.puts ("av" + @grilleEnCours.getPourcentage(@grilleBase, nil).to_s )
      end
    end

    return [peutRetourAvant?, coupSuivant.case] #Pour dire aux fonctions appelantes si on peut encore aller en avant
  end

  ##
  # Methode qui retourne en arrière (le coup)
  def retourArriere()#TOTEST
    if(@grilleRaz != nil)
      @grilleEnCours = Marshal.load(Marshal.dump(@grilleRaz))    
      @tabCoup = Marshal.load(Marshal.dump(@tabCoupRaz))
      @indiceCoup = Marshal.load(Marshal.dump(@indiceCoupRaz))

      @grilleRaz = nil

      socket = Fenetre1v1.getSocket
      if(socket != nil)
        socket.puts ("av" + @grilleEnCours.getPourcentage(@grilleBase, nil).to_s )
      end
      return nil
    else
      if(@indiceCoup > 0) #vérification normalement inutile puisque le bouton devrait être disable
        coupPrecedent = tabCoup.at(@indiceCoup-1)
        @grilleEnCours.tabCases[coupPrecedent.case.positionY][coupPrecedent.case.positionX].setCouleur(coupPrecedent.couleurBase)
        
        @indiceCoup -= 1 #On passe au coup précédent  
        socket = Fenetre1v1.getSocket
        if(socket != nil)
          socket.puts ("av" + @grilleEnCours.getPourcentage(@grilleBase, nil).to_s )
        end
        return [peutRetourArriere?, coupPrecedent.case]  
      end
      return nil#Pour dire aux fonctions appelantes qu'on ne pourra plus aller en arrière
    end
  end

  ##
  #Remet a 0 une grille
  def raz()#TOTEST
    @grilleRaz = Marshal.load(Marshal.dump(@grilleEnCours))
    @indiceCoupRaz = Marshal.load(Marshal.dump(@indiceCoup))
    @tabCoupRaz = Marshal.load(Marshal.dump(@tabCoup))

    @grilleEnCours.raz()
    @indiceCoup = 0
    @tabCoup = Array.new(0);

    socket = Fenetre1v1.getSocket
    if(socket != nil)
      socket.puts ("av" + @grilleEnCours.getPourcentage(@grilleBase, nil).to_s )
    end
  end
  
  ##
  # Methode qui empeche l'utilisatation
  # de revenir a la derniere position bonne 
  # en mode 1v1 car ca coute du temps
  def revenirPositionBonne() #TOTEST
    self
  end

  ##
  # Methode qui empeche l'utilisatation
  # de demander un indice 1v1 car ca 
  # coute du temps
  def donneIndice()
    nil
  end

end
