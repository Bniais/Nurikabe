
# Classe qui gere la fenetre 'A propos'
class FenetreAPropos
    attr_reader :view

    private_class_method :new

    def FenetreAPropos.creer(menuPrincipal)
        new(menuPrincipal)
    end

    # Constructeur de la fenetre A Propos
    def initialize(menuPrincipal)
        @menuPrincipal = menuPrincipal
        @view = creerViewAPropos()
        puts "View a propos initialise"
    end


    # Methode qui permet d'ouvrir la fenetre 'A propos'
    def creerViewAPropos()
        box = Gtk::Box.new(:vertical, 10)
        box.set_width_request(745)

        grille = Gtk::Grid.new()

        labelBtnRetour = Gtk::Label.new()
        labelBtnRetour.set_markup("<span foreground='#a4a400000000' >Retour</span>");
        # creation du bouton de retour
        @btnRetour = Gtk::Button.new()
        @btnRetour.add(labelBtnRetour)
        setmargin(@btnRetour,20,15,70,70)
        @btnRetour.set_height_request(40)

        @btnRetour.signal_connect("clicked") do
            @menuPrincipal.changerVue(@menuPrincipal.indexCourant, FenetreMenu::MENU)
        end

        grille.attach(@btnRetour, 0, 0, 1, 1)

        textBuff = Gtk::TextBuffer.new()
        textBuff.text = "Hacque adfabilitate confisus cum eadem postridie feceris, ut incognitus haerebis et repentinus, hortatore illo hesterno clientes numerando, qui sis vel unde venias diutius ambigente agnitus vero tandem et adscitus in amicitiam si te salutandi adsiduitati dederis triennio indiscretus et per tot dierum defueris tempus, reverteris ad paria perferenda, nec ubi esses interrogatus et quo tandem miser discesseris, aetatem omnem frustra in stipite conteres summittendo.

        Etenim si attendere diligenter, existimare vere de omni hac causa volueritis, sic constituetis, iudices, nec descensurum quemquam ad hanc accusationem fuisse, cui, utrum vellet, liceret, nec, cum descendisset, quicquam habiturum spei fuisse, nisi alicuius intolerabili libidine et nimis acerbo odio niteretur. Sed ego Atratino, humanissimo atque optimo adulescenti meo necessario, ignosco, qui habet excusationem vel pietatis vel necessitatis vel aetatis. Si voluit accusare, pietati tribuo, si iussus est, necessitati, si speravit aliquid, pueritiae. Ceteris non modo nihil ignoscendum, sed etiam acriter est resistendum.

        Itaque tum Scaevola cum in eam ipsam mentionem incidisset, exposuit nobis sermonem Laeli de amicitia habitum ab illo secum et cum altero genero, C. Fannio Marci filio, paucis diebus post mortem Africani."

        textView = Gtk::TextView.new()
        textView.set_buffer(textBuff)
        textView.set_editable(false)
        textView.set_wrap_mode(Gtk::WrapMode::WORD)
        textView.set_width_request(700)
        setmargin(textView,80,15,70,70)

        grille.attach(textView, 0, 1, 5, 1)
        box.pack_start(grille)

        return box
    end

    def setmargin( obj , top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return nil
    end


    # # Methode qui permet de revenir a la fenetre precedente
    # def listenerRetourArriere()
    #     #
    # end
end

