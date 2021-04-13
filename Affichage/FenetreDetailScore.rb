require './Fenetre.rb'


class FenetreDetailScore < Fenetre

    ##
    # Contructeur de FenetreDetailScore
    def initialize()
        self
    end

    ##
    # A COMPLETER
    def self.afficheToiSelec( lastView, numero)
        Fenetre.set_subtitle( @@lg.gt("DETAIL_SCORE") )
        Fenetre.add( FenetreDetailScore.new().creationInterface( lastView, numero ) )
        Fenetre.show_all
        return self
    end

    ##
    # Methode qui permet de creer l'interface
    def creationInterface( lastView, numero )
        grille = SauvegardeGrille.getInstance.getGrilleAt(numero)
        box = Gtk::Box.new(:vertical)

        # BACK BUTTON
        btnBoxH = Gtk::ButtonBox.new(:horizontal)
        btnBoxH.layout = :start
        btnBack = Gtk::Button.new(:label => @@lg.gt("RETOUR"))
        btnBack.name = "btnBack"
        btnBack.signal_connect("clicked") { Fenetre.remove(box) ; FenetreClassement.afficheToi( FenetreMenu) ; }
        lastView == nil ? btnBack.set_sensitive(false) : btnBack.set_sensitive(true)
        setmargin(btnBack,5,5,5,0)
        btnBoxH.add(btnBack)
        box.add(btnBoxH) #ADD
        box.add( setmargin(Gtk::Separator.new(:horizontal) ,0,15,0,0) )

        #GRILLE
        hBox = Gtk::Box.new(:vertical)
        box.add(creeGrille(grille))

         box.add( setmargin(Gtk::Separator.new(:horizontal) ,35,35,50,50) )

        #SCORES
        box.add(creeScores(grille.paliers, Sauvegardes.getInstance.getSauvegardeScore.scoresContreLaMontre[numero][0], Sauvegardes.getInstance.getSauvegardeScore.scoresContreLaMontre[numero][1]))
    

        return box
    end

    ##
    # A COMPLETER
    def creeScores(paliers, record, etoiles)
        box = Gtk::Box.new(:vertical)
        box.halign = :center

        if(etoiles == 3)
            box.add(creeLigneScore(record, -1))
        end

        box.add(creeLigneScore(paliers[2], 3))

        if(etoiles == 2)
            box.add(creeLigneScore(record, -1))
        end

        box.add(creeLigneScore(paliers[1], 2))

        if(etoiles == 1)
            box.add(creeLigneScore(record, -1))
        end

        box.add(creeLigneScore(paliers[0], 1))

        if(etoiles == 0)
            box.add(creeLigneScore(record, -1))
        end

        return box
    end

    ##
    # A COMPLETER
    def creeLigneScore(temps, etoiles)
        box = Gtk::Box.new(:horizontal)
        box.set_homogeneous(true)
        
        if(etoiles >= 0)
            etoilesTxt = ""
            for i in 0..2
                if(i<etoiles)
                        etoilesTxt += "★"
                else
                    etoilesTxt += "☆"
                end
            end
            etoilesLabel = Gtk::Label.new(etoilesTxt)
            setmargin(etoilesLabel, 0, 0, 0, 150)
        else
            etoilesTxt = @@lg.gt("MON_SCORE")
            etoilesLabel = Gtk::Label.new(etoilesTxt)
            setmargin(etoilesLabel, 0, 0, 0, 96)
        end
        
        
        etoilesLabel.name = "stars-detail"
        etoilesLabel.halign = :start
        box.add( etoilesLabel )

        tpsLabel = Gtk::Label.new(Chrono.getTpsFormatPrecis(temps))
        tpsLabel.name = "detailScore"
        tpsLabel.halign = :end
        box.add(tpsLabel)

        return box
    end

    ##
    # A COMPLETER
    def creeGrille( uneGrille )
        box = Gtk::Box.new(:vertical)
        setmargin(box,10,10,190,190)

        nomGrille = Gtk::Label.new()
        nomGrille.set_markup("<span size='25000' > " + @@lg.gt("GRILLE") + " #" + uneGrille.numero.to_s + "</span>")
        nomGrille.set_margin_bottom(10)

        box.add(nomGrille)


        # Frame exterieur pour que les rebord et la meme epaisseur
        maFrame = Gtk::Frame.new()
        maFrame.name = "fenetreGrille"
        # grid pour placer la grille de jeu dedans
        maGrille = Gtk::Grid.new()
        maGrille.set_height_request(300);   maGrille.set_width_request(300)
        maGrille.set_row_homogeneous(true);     maGrille.set_column_homogeneous(true)

        maGrilleDeJeu = uneGrille.tabCases
        for ligne in 0...maGrilleDeJeu.size
            for colonne in 0...maGrilleDeJeu.size
                cell =  creeCelluleGrille(maGrilleDeJeu[colonne][ligne].couleur )
                maGrille.attach( cell , ligne,colonne,1,1)
            end
        end

        maFrame.add(maGrille)


        box.add(maFrame)

        return box
    end

    ##
    # A COMPLETER
    def creeCelluleGrille(color)
        if color <= 0
            color = ""
        elsif color >= 10
            color = "+"
        end
        btn = Gtk::Label.new(color.to_s)
        btn.name = "little"
        return btn
    end

    ##
    # Methode qui permet de gerer les marges d'un objet donne
    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end
end
