module MyHotKeys::GtkMain
  def init_arguments
    APP.add_main_option(
      "config",
      99i8,
      GLib::OptionFlags::InMain,
      GLib::OptionArg::Filename,
      "/path/to/myhotkeys_config.yml",
      "My HotKeys configuration file"
    )

#    APP.option_context_parameter_string("FILE")
#    APP.option_context_summary("  FILE is a json conf of shotcuts")
#    APP.option_context_description("where FILE is json conf file to load")
  end
end

