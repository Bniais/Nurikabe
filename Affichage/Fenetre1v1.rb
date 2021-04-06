require '../Partie/Partie1v1.rb'
require 'socket'
require "resolv"
require 'open-uri'

##
# Classe qui gere la fenetre 'A propos'
#
# Herite de la classe abstraite Fenetre
class Fenetre1v1 < Fenetre

    @@socket = nil
    @@attente = nil
    @@server = nil
    ##
    # Methode privee pour l'initialisation
    def initialize()
        self
    end

    ##
    # Methode qui permet a la fenetre de s'afficher
    def self.afficheToi( lastView )
        Fenetre.set_subtitle( @@lg.gt("CONNECTION") )
        @@instance = Fenetre1v1.new()
        Fenetre.add( @@instance.creationInterface( lastView ) )
        Fenetre.show_all
        return self
    end

    def self.getSocket()
        return @@socket
    end


    ##
    # Methode qui permet de creer l'interface
    def creationInterface( lastView )
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

        # BACK BUTTON

        btnBoxH = Gtk::ButtonBox.new(:horizontal)
        btnBoxH.layout = :start
        btnBack = Gtk::Button.new(:label => @@lg.gt("RETOUR"))
        btnBack.name = "btnBack"
        btnBack.signal_connect("clicked") { Fenetre.remove(box) ; lastView.afficheToi( nil ) ; }
        lastView == nil ? btnBack.set_sensitive(false) : btnBack.set_sensitive(true)
        setmargin(btnBack,5,5,5,0)
        btnBoxH.add(btnBack)
        box.add(btnBoxH) #ADD


        vBox = Gtk::Box.new(:vertical)
        
        #titre
        vBox.add(titleLabel(@@lg.gt("CONNECTION")))
        
        
        #ip
        ipBox = Gtk::Box.new(:horizontal)
        ipBox.halign = :center
        ipBox.set_homogeneous(true)
        
        ipLabel = Gtk::Label.new(@@lg.gt("IP"))
        ipBox.add(ipLabel)


        ipEntry = Gtk::Entry.new()
        ipEntry.width_chars = 15
        ipEntry.max_length = 15
        ipBox.add(ipEntry)

        vBox.add(ipBox)
        
        #port
        portBox = Gtk::Box.new(:horizontal)
        portBox.halign = :center
        portBox.set_homogeneous(true)
        
        portLabel = Gtk::Label.new(@@lg.gt("PORT"))
        portBox.add(portLabel)

        portEntry = Gtk::Entry.new()
        portEntry.width_chars = 15
        portEntry.max_length = 15

        portBox.add(portEntry)

        vBox.add(portBox)

        #buttons

        buttonBox = Gtk::Box.new(:horizontal)
        buttonBox.halign = :center
        
        buttonHost = Gtk::Button.new(:label => @@lg.gt("HOST"))
        buttonBox.add(buttonHost)

        buttonJoin = Gtk::Button.new(:label => @@lg.gt("JOIN"))
        buttonBox.add(buttonJoin)

        buttonCancel = Gtk::Button.new(:label => @@lg.gt("CANCEL"))
        buttonBox.add(buttonCancel)

        vBox.add(buttonBox)

        
        #signals
        buttonHost.signal_connect("clicked"){
            port = portEntry.text.to_i
            if(port > 0 && port < 65536)
                @@server = TCPServer.new (port)
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
                           
                            while line = @@socket.gets
                                if(line.include?("dc"))
                                    FenetrePartie.getInstance.deco()
                                elsif line.include?("ez")
                                    FenetrePartie.getInstance.perdre(line.delete_prefix("ez"))
                                end
                                @@socket.puts "im sad"
                                @@socket.close
                                break
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

        buttonJoin.signal_connect("clicked"){
            port = portEntry.text.to_i
            if(port > 0 && port < 65536)
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
                        @@socket = TCPSocket.new( ipEntry.text, portEntry.text.to_i)
                    else
                        ipEntry.text = @@lg.gt("LOCAL_HOST")
                        @@socket = TCPSocket.new('localhost', portEntry.text.to_i)
                    end

                    if(@@socket != nil)

                        while line = @@socket.gets # Read lines from @socket
                            Fenetre.remove(box)
                            FenetrePartie.afficheToiSelec(Fenetre1v1, Partie1v1.creer(SauvegardeGrille.getInstance.getGrilleAt(line.to_i)) )
                            break
                        end

                        while line = @@socket.gets
                            puts line
                            if(line.include?("dc"))
                                FenetrePartie.getInstance.deco()
                            elsif line.include?("ez")
                                FenetrePartie.getInstance.perdre(line.delete_prefix("ez"))
                            end
                            @@socket.puts "im sad"
                            @@socket.close
                            break
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


        box.add(vBox)

        return box
    end

    def threadAttenteClient
        
    end

    def titleLabel(unLabel)
        label = Gtk::Label.new()
        label.set_markup("<span size='25000' >" + unLabel.to_s + "</span>")
        return label
    end

    ##
    # Methode qui permet de gerer les marges d'un objet
    private
    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end
end
