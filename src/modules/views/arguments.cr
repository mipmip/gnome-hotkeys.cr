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
  end
end

