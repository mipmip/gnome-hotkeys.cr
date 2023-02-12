require "yaml"
require "gtk4"
require "./modules/views/*"

module MyHotKeys::GtkMain
  extend self

  APP = Gtk::Application.new("oss.mipmip.myhotkeys", Gio::ApplicationFlags::None)
  #APP.activate_signal.connect(->activate(Gtk::Application,GLib::VariantDict))
  APP.activate_signal.connect(->activate(Gtk::Application))
  #APP.open_signal.connect(->open_file(Gtk::Application))
  #APP.handle_local_options_signal.connect(->activate(Gtk::Application))
  #APP.command_line_signal.connect(->command_line(Gio::ApplicationCommandLine))

  init_arguments

  #p ARGV[1]

  APP.run(ARGV)
end
