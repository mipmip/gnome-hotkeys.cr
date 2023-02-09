require "gtk4"
require "./modules/views/*"

module Tiny::Stats
  extend self
  APP = Gtk::Application.new("dev.geopjr.myhotkeys", Gio::ApplicationFlags::None)
end
