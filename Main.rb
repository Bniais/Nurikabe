require 'gtk2'

Gtk.init

window = Gtk::Window.new
window.signal_connect('destroy') {
   Gtk.main_quit
}

button = Gtk::Button.new('Bonjour tout le monde')
button.signal_connect('clicked') {
   print "Bonjour !\n"
}
window.add(button)

window.show_all

Gtk.main

print "Terminé\n"