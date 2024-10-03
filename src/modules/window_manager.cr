module MyHotKeys::GtkMain

  def activate(app : Gtk::Application)
    window = Gtk::ApplicationWindow.new(app)
    openShortcutsPopup
  end

  def runOpenWindow(shortcut_file)
    shortcutsWindowUI = makeShortcutsUI(shortcut_file)
    shortcutsWindow = Gtk::Builder.new_from_string(shortcutsWindowUI, shortcutsWindowUI.size.to_i64)

    scwin = Gtk::ShortcutsWindow.cast(shortcutsWindow["shortcutsWindow"])
    scwin.close_request_signal.connect() do
      exit(0)
      true
    end
    scwin.present()
  end

  def openShortcutsPopup

    default_file = Path["~/.config/myhotkeys/keys.json"].expand(home: true)

    shortcut_file = STATE.shortcut_file

    if File.exists?(shortcut_file)
      runOpenWindow(shortcut_file)

    elsif File.exists?(default_file)
      runOpenWindow(default_file)

    else
      usage
      exit(1)
    end
  end

  def usage
    print "Error: No ~/.config/myhotkeys/keys.json or valid file name as 1st argument.\n"
  end


end
