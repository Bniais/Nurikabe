require_relative '../Partie/Partie1v1.rb'
require 'socket'
require "resolv"
require 'open-uri'

##
# Classe qui gere la création de l'interface de la fenêtre 'A propos'
# Hérite de la classe Fenetre
class Fenetre1v1 < Fenetre
    ##
    # Socket pour échanger les données entre les joueurs
    @@socket = nil

    ##
    # Thread de l'attente
    @@attente = nil

    ##
    # Serveur qui héberge la connexion
    @@server = nil

    ##
    # Port de connexion
    @@port = ""

    ##
    # IP de connexion
    @@ip = ""

    ##
    # Methode pour l'initialisation
    def initialize()
        self
    end

    ##
    # Permet d'afficher la fenêtre de 1v1
    def self.afficheToi( lastView )
        Fenetre.set_subtitle( @@lg.gt("CONNECTION") )
        @@instance = Fenetre1v1.new()
        Fenetre.add( @@instance.creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end

    ##
    # Accesseur de la socket
    def self.getSocket()
        return @@socket
    end


    ##
    # Crée l'interface de la fenêtre 1v1
    def creationInterface( lastView )
        #Fermer les connexions et thread au cas où la déconnexion ne s'est pas bien passé
        if(@@socket != nil)
            @@socket.close
            @@socket = nil
        end

        if @@attente != nil
            @@attente.exit
            @@attente = nil
        end

        if @@server != nil
            @@server.close
            @@server = nil
        end


        box = Gtk::Box.new(:vertical)

        #Bouton retour
        btnBoxH = Gtk::ButtonBox.new(:horizontal)
        btnBoxH.layout = :start
        btnBack = Gtk::Button.new(:label => @@lg.gt("RETOUR"))
        btnBack.name = "btnBack"
        lastView == nil ? btnBack.set_sensitive(false) : btnBack.set_sensitive(true)
        setmargin(btnBack,5,5,5,0)
        btnBoxH.add(btnBack)
        box.add(btnBoxH) #ADD


        vBox = Gtk::Box.new(:vertical)
        vBox = setmargin(vBox,0,0,70,70)

        #Titre
        vBox.add( setmargin( titleLabel(@@lg.gt("CONNECTION")) , 15,15,0,0 )  )


        #IP
        entryBox = Gtk::Box.new(:horizontal)
        entryBox.set_homogeneous(false)
        entryBox.set_height_request(40)
        entryBox.halign = :center

        ipEntry = Gtk::Entry.new()
        ipEntry.halign = :fill
        ipEntry.set_placeholder_text("127.0.0.1")
        ipEntry.width_chars = 15
        ipEntry.max_length = 15
        ipEntry.text = @@ip
        ipEntry.set_width_request(300)


        entryBox.add( setmargin( ipEntry ,0,0,0,5) )


        #Port
        portEntry = Gtk::Entry.new()
        portEntry.set_placeholder_text("65553")
        portEntry.halign = :fill
        portEntry.width_chars = 15
        portEntry.max_length = 15
        portEntry.text = @@port


        entryBox.add( portEntry )

        vBox.add( setmargin( entryBox,20,10,20,20 ) );

        #Boutons 
        buttonBox = Gtk::Box.new(:horizontal)
        buttonBox.set_homogeneous(true)
        buttonBox.set_height_request(50)

        buttonHost = Gtk::Button.new(:label => @@lg.gt("HOST"))
        buttonBox.add( setmargin( buttonHost,0,0,0,5 ) )

        buttonJoin = Gtk::Button.new(:label => @@lg.gt("JOIN"))
        buttonBox.add( setmargin( buttonJoin,0,0,0,5 ) )

        buttonCancel = Gtk::Button.new(:label => @@lg.gt("CANCEL"))
        buttonBox.add(buttonCancel)

        vBox.add( setmargin( buttonBox,20,10,20,20 ) )


        #Signaux

        # Lancement de la recherche de personnes qui rejoignent, lancement et suivi de la partie 1v1
        buttonHost.signal_connect("clicked"){
            @@port = portEntry.text
            if(@@port.to_i > 0 && @@port.to_i < 65536)
                @@server = TCPServer.new (@@port.to_i)
                if(@@server != nil)
                    buttonHost.set_sensitive(false)
                    buttonJoin.set_sensitive(false)
                    ipEntry.editable = false
                    portEntry.editable = false

                    begin
                        ipEntry.text = URI.open('http://whatismyip.akamai.com').read
                    rescue
                        ipEntry.text = @@lg.gt("LOCAL_HOST")
                    end
                    @@ip = ipEntry.text

                    if(@@attente != nil)
                        @@attente.exit
                        @@attente = nil
                    end

                    @@attente = Thread.new do
                        @@socket = @@server.accept
                        if(@@socket != nil)
                            grilleId = rand(1..SauvegardeGrille.getInstance.getNombreGrille)
                            @@socket.puts grilleId.to_s

                            Fenetre.remove(box)
                            FenetrePartie.afficheToiSelec(Fenetre1v1, Partie1v1.creer(SauvegardeGrille.getInstance.getGrilleAt(grilleId.to_i)) )

                            while 1 < 2
                                line = @@socket.gets
                                if(line != nil)
                                    if(line.include?("av")) #Avancement du joueur
                                        FenetrePartie.getInstance.setAvancementEnemy(line.delete_prefix("av"))
                                    else
                                        if(line.include?("dc")) #Déconnexion du joueur
                                            FenetrePartie.getInstance.deco()
                                        elsif line.include?("ez") #Victoire du joueur
                                            FenetrePartie.getInstance.perdre(line.delete_prefix("ez"))
                                        end
                                        @@socket.puts "im sad" #Prévenir qu'il quitte naturellement
                                        @@socket.close
                                        @@socket = nil
                                        @@server.close
                                        @@server = nil
                                        break
                                    end
                                end
                            end
                        else
                            buttonJoin.set_sensitive(true)
                            buttonHost.set_sensitive(true)
                        end

                        if(@@socket != nil)
                            @@socket.close
                            @@socket = nil
                        end

                        if(@@server != nil)
                            @@server.close
                            @@server = nil
                        end
                    end
                end
            end
        }

        # Lancement de la recherche d'Host, lancement et suivi de la partie 1v1
        buttonJoin.signal_connect("clicked"){
            @@port = portEntry.text
            if(@@port.to_i > 0 && @@port.to_i < 65536)
                buttonHost.set_sensitive(false)
                buttonJoin.set_sensitive(false)
                ipEntry.editable = false
                portEntry.editable = false

                @@attente = Thread.new do
                    if(@@socket != nil)
                        @@socket.close
                        @@socket = nil
                    end

                    if !!(ipEntry.text =~ Resolv::IPv4::Regex)
                        @@socket = TCPSocket.new( ipEntry.text, @@port.to_i)
                    else
                        ipEntry.text = @@lg.gt("LOCAL_HOST")
                        @@socket = TCPSocket.new('localhost', @@port.to_i)
                    end
                    @@ip = ipEntry.text

                    if(@@socket != nil)

                        while line = @@socket.gets #Lire la @socket
                            Fenetre.remove(box)
                            FenetrePartie.afficheToiSelec(Fenetre1v1, Partie1v1.creer(SauvegardeGrille.getInstance.getGrilleAt(line.to_i)) )
                            break
                        end

                        while 1 < 2
                            line = @@socket.gets
                            if(line != nil)
                                if(line.include?("av")) #Avancement du joueur
                                    FenetrePartie.getInstance.setAvancementEnemy(line.delete_prefix("av"))
                                else
                                    if(line.include?("dc")) #Déconnexion du joueur
                                        FenetrePartie.getInstance.deco()
                                    elsif line.include?("ez") #Victoire du joueur
                                        FenetrePartie.getInstance.perdre(line.delete_prefix("ez"))
                                    end
                                    @@socket.puts "im sad" #Prévenir qu'il quitte naturellement
                                    @@socket.close
                                    @@socket = nil
                                    break
                                end

                            end
                        end
                    else
                        buttonJoin.set_sensitive(true)
                        buttonHost.set_sensitive(true)
                    end
                    if(@@socket != nil)
                        @@socket.close
                        @@socket = nil
                    end
                end
            end
        }

        buttonCancel.signal_connect("clicked"){
            if @@attente != nil
                @@attente.exit
                @@attente = nil
            end

            if @@server != nil
                @@server.close
                @@server = nil
            end

            if @@socket != nil
                @@socket.close
            end

            buttonJoin.set_sensitive(true)
            buttonHost.set_sensitive(true)
            ipEntry.editable = true
            portEntry.editable = true
        }

        btnBack.signal_connect("clicked") { Fenetre.remove(box) ; lastView.afficheToi( nil ) ; @@port = portEntry.text ; @@ip =  ipEntry.text}


        box.add(vBox)

        return box
    end

    ##
    # Retourne un label au format des titres (en grand)
    def titleLabel(unLabel)
        label = Gtk::Label.new()
        label.set_markup("<span size='25000' >" + unLabel.to_s + "</span>")
        return label
    end

    ##
    # Met des marges à un objet
    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end
end
