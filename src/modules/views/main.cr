module Tiny::Stats
  @@main_window_id = 0_u32

  def startup(app : Gtk::Application)
    #CSS.load_from_resource("/dev/geopjr/myhotkeys/css/style.css")
  end

  def makeShortcutsUI

    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkShortcutsWindow" id="shortcutsWindow">
    <property name="modal">True</property>
    <child>
      <object class="GtkShortcutsSection">
        <property name="section-name">shortcuts</property>
        <property name="max-height">15</property>

        <child>
          <object class="GtkShortcutsGroup">
            <property name="title" translatable="yes" context="shortcut window">General</property>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="shortcut window">Add New Feed</property>
                <property name="action-name">win.show-add-feed-dialog</property>
                <property name="accelerator">&lt;primary&gt;a</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="shortcut window">Add New Directory</property>
                <property name="action-name">win.show-add-directory-dialog</property>
                <property name="accelerator">&lt;primary&gt;d</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="shortcut window">Update All Feeds</property>
                <property name="action-name">win.update-all-feeds</property>
                <property name="accelerator">&lt;primary&gt;r</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="shortcut window">Show Shortcuts</property>
                <property name="action-name">win.show-help-overlay</property>
                <property name="accelerator">&lt;primary&gt;question</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="shortcut window">Quit</property>
                <property name="action-name">app.quit</property>
                <property name="accelerator">&lt;primary&gt;q</property>
              </object>
            </child>
          </object>
        </child>
        <child>


          <object class="GtkShortcutsGroup">
            <property name="title" translatable="yes" context="shortcut window">General</property>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="preferences">Show Preferences</property>
                <property name="action-name">app.preferences</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="shortcut window">Show Shortcuts</property>
                <property name="action-name">win.show-help-overlay</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="shortcut window">Quit</property>
                <property name="action-name">["&lt;primary&gt;a"]</property>
              </object>
            </child>
          </object>
        </child>
        <child>
          <object class="GtkShortcutsGroup">
            <property name="title" translatable="yes" context="shortcut window">Vaults</property>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Add New Vault</property>
                <property name="action-name">[&lt;Alt&gt;Down]</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Import Vault</property>
                <property name="action-name">win.import_vault</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Search</property>
                <property name="action-name">win.search</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Refresh</property>
                <property name="action-name">win.refresh</property>
              </object>
            </child>
          </object>
        </child>
        <child>
          <object class="GtkShortcutsGroup">
            <property name="title" translatable="yes" context="shortcut window">Vaults 3</property>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Add New Vault</property>
                <property name="action-name">win.add_new_vault</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Import Vault</property>
                <property name="action-name">win.import_vault</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Search</property>
                <property name="action-name">win.search</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Refresh</property>
                <property name="action-name">win.refresh</property>
              </object>
            </child>
          </object>
        </child>

        <child>
          <object class="GtkShortcutsGroup">
            <property name="title" translatable="yes" context="shortcut window">Vaults 2</property>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Add New Vault</property>
                <property name="action-name">win.add_new_vault</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Import Vault</property>
                <property name="action-name">win.import_vault</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Search</property>
                <property name="action-name">win.search</property>
              </object>
            </child>
            <child>
              <object class="GtkShortcutsShortcut">
                <property name="title" translatable="yes" context="vaults">Refresh</property>
                <property name="action-name">win.refresh</property>
              </object>
            </child>
          </object>
        </child>
      </object>
    </child>
  </object>
</interface>
XML
  end

  def activate(app : Gtk::Application)
    window = Gtk::ApplicationWindow.new(app)
    window.title = "MyHotkeys"

    shortcutsWindowUI = makeShortcutsUI
    shortcutsWindow = Gtk::Builder.new_from_string(shortcutsWindowUI, shortcutsWindowUI.size.to_i64)
    swin = Gtk::ShortcutsWindow.cast(shortcutsWindow["shortcutsWindow"])
    swin.close_request_signal.connect() do
      exit(0)
      true
    end
    swin.present()
  end

  APP.startup_signal.connect(->startup(Gtk::Application))
  APP.activate_signal.connect(->activate(Gtk::Application))
  APP.run(ARGV)
end
