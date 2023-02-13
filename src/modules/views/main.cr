module MyHotKeys::GtkMain

  def activate(app : Gtk::Application)
    window = Gtk::ApplicationWindow.new(app)
    openShortcutsPopup
  end

  def openShortcutsPopup
    shortcut_file = STATE.shortcut_file
    if File.exists?(shortcut_file)
      shortcutsWindowUI = makeShortcutsUI(shortcut_file)
      shortcutsWindow = Gtk::Builder.new_from_string(shortcutsWindowUI, shortcutsWindowUI.size.to_i64)
      scwin = Gtk::ShortcutsWindow.cast(shortcutsWindow["shortcutsWindow"])
      scwin.close_request_signal.connect() do
        exit(0)
        true
      end
      scwin.present()
    else
      usage
      exit(1)
    end
  end

  def usage
    print "you should give a valid file name as 1st argument\n"
  end


end
