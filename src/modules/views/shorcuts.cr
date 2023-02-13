module MyHotKeys::GtkMain

  def parse_accelerator(accel)
    accel = accel.gsub("<Ctrl>","&lt;Ctrl&gt;")
    accel = accel.gsub("<Control>","&lt;Control&gt;")
    accel = accel.gsub("<Primary>","&lt;Primary&gt;")
    accel = accel.gsub("<Alt>","&lt;Alt&gt;")
    accel = accel.gsub("<Super>","&lt;Super&gt;")
    accel = accel.gsub("<Shift>","&lt;Shift&gt;")
    accel = accel.gsub("<Meta>","&lt;Meta&gt;")
    accel = accel.gsub("<CTRL>","&lt;Ctrl&gt;")
    accel = accel.gsub("<ALT>","&lt;Alt&gt;")
    accel = accel.gsub("<SUPER>","&lt;Super&gt;")
    accel = accel.gsub("<SHIFT>","&lt;Shift&gt;")
    accel = accel.gsub("<META>","&lt;Meta&gt;")
    accel
  end

  def read_shortcuts(shortcut_file)
    json = File.open(shortcut_file) { |file| JSON.parse(file) }
    keyGroups = json.as_a
    keyGroups
  end

  def createAccelCheat(description, keyin)
    key = parse_accelerator(keyin)
    <<-sXML
      <child>
        <object class="GtkShortcutsShortcut">
          <property name="title"  context="shortcut window">#{description}</property>
          <property name="accelerator">#{key}</property>
        </object>
      </child>
    sXML
  end

  def createCommandCheat(description, command)
    <<-sXML
      <child>
        <object class="GtkBox">
          <property name="spacing">12</property>
          <child>
            <object class="GtkLabel">
              <property name="label" translatable="yes" context="shortcut window">#{command}</property>
              <property name="margin-end">110</property>
              <attributes>
                <attribute name="font-desc" value="Monospace"/>
              </attributes>
            </object>
          </child>
          <child>
            <object class="GtkLabel">
              <property name="label" translatable="yes" context="shortcut window">#{description}</property>
            </object>
          </child>
        </object>
      </child>
    sXML
  end

  def createXMLGroupFromGio(name, shortcuts)

    pShortcuts = [] of String

    shortcuts = shortcuts[0..MAX_HEIGHT] if shortcuts.size > MAX_HEIGHT
    shortcuts.each do | shortcut|
      description = shortcut["description"]
      shortcutXML = ""
      shortcutXML = createAccelCheat(description, shortcut["key"])

      pShortcuts << shortcutXML if shortcutXML != ""
    end

    makeGroupXML(name, pShortcuts)
  end

  def createXMLGroupFromJson(group)
    g = group.as_h
    shortcuts = g["shortcuts"].as_a
    pShortcuts = [] of String
    shortcuts.each do | shortcut|
      description = shortcut["description"].as_s
      shortcutXML = ""
      if shortcut.as_h.has_key?("key")
        shortcutXML = createAccelCheat(description, shortcut["key"].as_s)
      elsif shortcut.as_h.has_key?("command")
        command = shortcut["command"].as_s
        shortcutXML = createCommandCheat(description, command)
      end

      pShortcuts << shortcutXML if shortcutXML != ""
    end
    makeGroupXML(group["name"].as_s, pShortcuts)

  end

  def makeGroupXML(name, pShortcuts)
    <<-gXML
        <child>
          <object class="GtkShortcutsGroup">
            <property name="title" translatable="yes" context="shortcut window">#{name}</property>
            #{pShortcuts.join("")}
          </object>
        </child>
      gXML
  end

  def makeShortcutsUI(shortcut_file)

    pGroups = [] of String

    SCHEMAS.each do |schema|
      shortcuts = gnome_schema_keys(schema)
      pGroups << createXMLGroupFromGio(translate_schema_name(schema.to_s), gnome_schema_keys(schema))
    end

    keyGroups = read_shortcuts(shortcut_file)
    keyGroups.each do | group |
      pGroups << createXMLGroupFromJson(group)
    end

    innerXML = pGroups.join("")

    ui = <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkShortcutsWindow" id="shortcutsWindow">
    <property name="modal">True</property>
    <child>
      <object class="GtkShortcutsSection">
        <property name="section-name">shortcuts</property>
        <property name="max-height">#{MAX_HEIGHT.to_s}</property>
        #{innerXML}
      </object>
    </child>
  </object>
</interface>
XML
  ui
  #p ui
  end
end

