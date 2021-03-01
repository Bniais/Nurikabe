require 'gtk3'

Gtk.init

window = Gtk::Window.new
window.signal_connect('destroy'){
   Gtk.main_quit()
}

button = Gtk::Button.new('Bonjour tout le monde')
button.signal_connect('clicked') {
   puts "Bonjour !"
}
window.add(button)

window.show_all

Gtk.main

puts "Terminé"
