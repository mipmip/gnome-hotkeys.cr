require "json"
require "option_parser"
require "gtk4"
require "./modules/views/*"


module MyHotKeys::GtkMain
  extend self

  class State
    @shortcut_file = ""

    def set_shortcut_file(file)
      @shortcut_file = file.path.to_s
    end

    def shortcut_file
      @shortcut_file
    end
  end

  OptionParser.parse do |parser|
    parser.banner = "\nUsage: myhotkeys [ARGUMENTS] [FILE]\n"
    parser.on("-h", "--help", "Show this help") do
      puts parser
      exit
    end
    parser.invalid_option do |flag|
      STDERR.puts "ERROR: #{flag} is not a valid option."
      STDERR.puts parser
      exit(1)
    end
  end

  APP = Gtk::Application.new("oss.mipmip.myhotkeys", Gio::ApplicationFlags::HandlesOpen)
  APP.activate_signal.connect(->activate(Gtk::Application))

  SCHEMAS = {
    "org.gnome.shell.keybindings": "Shell",
    "org.gnome.desktop.wm.keybindings": "Window Manager"
  }
  MAX_HEIGHT = 10

  init_arguments
  STATE = State.new

  APP.open_signal.connect do |files, hint|
    if files.size > 1

      STATE.set_shortcut_file( files[1] )
    end
    APP.activate
    nil
  end

  clean_argv = [PROGRAM_NAME].concat(ARGV.reject { |x| x.starts_with?('-') })
  exit(APP.run(clean_argv))

end
