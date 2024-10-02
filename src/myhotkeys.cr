require "json"
require "option_parser"
require "gtk4"
require "./modules/views/*"


module MyHotKeys::GtkMain
  extend self

  class State
    @shortcut_file = ""
    @schemas = Hash(String,String).new
    @use_gnome_schema = false

    def set_shortcut_file(file)
      @shortcut_file = file.path.to_s
    end

    def shortcut_file
      @shortcut_file
    end

#    def set_gnome_shemas(schemakey_plus_name)
#      _tmp = schemakey_plus_name.split(":")
#      if _tmp.size == 2
#        schemakey = _tmp[0]
#        name = _tmp[1]
#        @schemas[schemakey] = name
#      end
#    end
#
#    def gnome_schemas
#      NamedTuple.from(@schemas)
#    end

    def use_gnome_schema()
      @use_gnome_schema = true
    end

    def use_gnome_schema?()
      @use_gnome_schema
    end

  end

  STATE = State.new

  OptionParser.parse do |parser|
    parser.banner = "\nUsage: myhotkeys [ARGUMENTS] [FILE]\n"

    parser.on("-g", "--gnome-schemas", "Add Gnome Schema's") do
      puts "with gnome"
      STATE.use_gnome_schema()
    end

# This could work like this:
# . /bin/myhotkeys ./test.json -t "org.gnome.shell.keybindings:gnome shell" -t "org.gnome.desktop.wm.keybindings:Mutter"
#  But I can't get the NamedTuple working dynamically
#    parser.on("-t NAME", "--to=NAME", "Specifies the name to salute") { |name|
#      STATE.set_gnome_shemas( name )
#    }

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

  app = Gtk::Application.new("oss.mipmip.myhotkeys", Gio::ApplicationFlags::HandlesOpen)
  app.activate_signal.connect(->activate(Gtk::Application))

  #init_arguments

  SCHEMAS = {
    "org.gnome.shell.keybindings": "Gnome Shell",
    "org.gnome.desktop.wm.keybindings": "Mutter"
  }

  MAX_HEIGHT = 10

  app.open_signal.connect do |files, hint|
    if files.size > 0
      STATE.set_shortcut_file( files[0] )
    end
    app.activate
    nil
  end

  clean_argv = [PROGRAM_NAME].concat(ARGV.reject { |x| x.starts_with?('-') })
  exit(app.run(clean_argv))

end
