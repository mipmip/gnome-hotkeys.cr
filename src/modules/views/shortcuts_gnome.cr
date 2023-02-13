module MyHotKeys::GtkMain

  def gnome_schema_keys(schema)

    shortcuts = [] of Hash(String,String)
    #shortcut_group = Hash(String, typeof(shortcuts))
    keybindingsSettings = Gio::Settings.new(schema.to_s)
    keys = keybindingsSettings.list_keys()

    keys.each do |key|

      if keybindingsSettings.strv(key).size > 0
        val = keybindingsSettings.strv(key)

        shortCutEntry = {
          "description" => normalize_description(key),
          "key" => normalize_shortcut(val[0])
        }

        shortcuts << shortCutEntry
      end
    end

    shortcuts
#    return {
#      "name" => translate_schema_name(schema.to_s),
#      "shortcuts" => shortcuts
#    }
  end

  def normalize_description(str)
    str = str.to_s.gsub("-", " ").capitalize
  end

  def normalize_shortcut(str)
    str
  end

  def translate_schema_name(schema)
    SCHEMAS[schema]
  end




end


