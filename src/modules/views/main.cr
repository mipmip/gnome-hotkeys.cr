module MyHotKeys::GtkMain
  #def activate(app : Gtk::Application, options : GLib::VariantDict)
  def activate(app : Gtk::Application)
    window = Gtk::ApplicationWindow.new(app)

    openShortcutsPopup
  end

  def open_file(app : Gtk::Application)
    p "Hallo"
  end
  def command_line(cl : Gio::ApplicationCommandLine)
    p "Hallo"
  end

  def openShortcutsPopup
    shortcutsWindowUI = makeShortcutsUI
    p ARGV
    shortcutsWindow = Gtk::Builder.new_from_string(shortcutsWindowUI, shortcutsWindowUI.size.to_i64)
    scwin = Gtk::ShortcutsWindow.cast(shortcutsWindow["shortcutsWindow"])
    scwin.close_request_signal.connect() do
      exit(0)
      true
    end
    scwin.present()
  end


end
