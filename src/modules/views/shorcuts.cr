module MyHotKeys::GtkMain

  def parse_accelerator(accel)
    accel = accel.gsub("<CTRL>","&lt;Ctrl&gt;")
    accel = accel.gsub("<ALT>","&lt;Alt&gt;")
    accel = accel.gsub("<SUPER>","&lt;Super&gt;")
    accel = accel.gsub("<SHIFT>","&lt;Shift&gt;")
    accel = accel.gsub("<META>","&lt;Meta&gt;")
    p accel
    accel
  end

  def read_shortcuts
    yaml = File.open("/home/pim/.hotkeys-popup-custom2.json") { |file| YAML.parse(file) }
    keyGroups = yaml.as_a
    keyGroups
  end


  def createXMLGroups(keyGroups)
    pGroups = [] of String
    keyGroups.each do | group |
      g = group.as_h
      name = g["name"].as_s
      shortcuts = g["shortcuts"].as_a
      pShortcuts = [] of String
      shortcuts.each do | shortcut|
        description = shortcut["description"].as_s
        rawKey = shortcut["key"].as_s
        key = parse_accelerator(shortcut["key"].as_s)

        shortcutXML = <<-sXML
          <child>
            <object class="GtkShortcutsShortcut">
              <property name="title" translatable="yes" context="shortcut window">#{description}</property>
              <property name="accelerator">#{key}</property>
            </object>
          </child>
        sXML
        pShortcuts << shortcutXML
      end

      groupXML = <<-gXML
        <child>
          <object class="GtkShortcutsGroup">
            <property name="title" translatable="yes" context="shortcut window">#{name}</property>
            #{pShortcuts.join("")}
          </object>
        </child>
      gXML
      pGroups << groupXML
    end

    pGroups.join("")

  end

  def makeShortcutsUI
    keyGroups = read_shortcuts
    innerXML = createXMLGroups(keyGroups)

    ui = <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkShortcutsWindow" id="shortcutsWindow">
    <property name="modal">True</property>
    <child>
      <object class="GtkShortcutsSection">
        <property name="section-name">shortcuts</property>
        <property name="max-height">20</property>
        #{innerXML}
      </object>
    </child>
  </object>
</interface>
XML
  ui
  p ui
  end
end

