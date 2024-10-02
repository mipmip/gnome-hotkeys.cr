.PHONY: all test build
PREFIX ?= /usr
LOCALE_LOCATION ?= /share/locale

all: .WAIT configure
	shards build --release --debug $(CR_FLAGS) -s --link-flags='-Wl,--as-needed'

configure:
	shards install
	./bin/gi-crystal

#all: bindings build

bindings:
	./bin/gi-crystal --no-doc

build:
	APP_LOCALE_LOCATION="$(PREFIX)$(LOCALE_LOCATION)" $(CRYSTAL_LOCATION)shards build -Dpreview_mt --no-debug

build_release:
	APP_LOCALE_LOCATION="$(PREFIX)$(LOCALE_LOCATION)" $(CRYSTAL_LOCATION)shards build -Dpreview_mt --release --no-debug

test:
	$(CRYSTAL_LOCATION)crystal spec -Dpreview_mt --order random

install:
	install -D -m 0755 bin/myhotkeys $(DESTDIR)$(PREFIX)/bin/myhotkeys
	#install -D -m 0644 myhotkeys.desktop $(DESTDIR)$(PREFIX)/share/applications/io.github.hugopl.myhotkeys.desktop
	#install -D -m 0644 data/io.github.hugopl.myhotkeys.svg $(DESTDIR)$(PREFIX)/share/icons/hicolor/scalable/apps/io.github.hugopl.myhotkeys.svg
	# Settings schema
	#install -D -m644 data/gschema.xml $(DESTDIR)$(PREFIX)/share/glib-2.0/schemas/io.github.hugopl.myhotkeys.gschema.xml
	# Data
	#cp -r data/icons $(DESTDIR)$(PREFIX)/share/myhotkeys/

	install -D -m0644 LICENSE $(DESTDIR)$(PREFIX)/share/licenses/myhotkeys/LICENSE
	install -D -m0644 CHANGELOG.md $(DESTDIR)$(PREFIX)/share/doc/myhotkeys/CHANGELOG.md
	gzip -9fn $(DESTDIR)$(PREFIX)/share/doc/myhotkeys/CHANGELOG.md

#post-install:
#	gtk4-update-icon-cache --ignore-theme-index $(DESTDIR)$(PREFIX)/share/icons/hicolor
#	glib-compile-schemas $(DESTDIR)$(PREFIX)/share/glib-2.0/schemas

#uninstall:
#	rm -f $(DESTDIR)$(PREFIX)/bin/myhotkeys
#	rm -f $(DESTDIR)$(PREFIX)/share/applications/io.github.hugopl.myhotkeys.desktop
#	rm -f $(DESTDIR)$(PREFIX)/share/icons/hicolor/scalable/apps/io.github.hugopl.myhotkeys.svg
#	rm -rf $(DESTDIR)$(PREFIX)/share/myhotkeys
#	rm -rf $(DESTDIR)$(PREFIX)/share/licenses/myhotkeys
#	rm -rf $(DESTDIR)$(PREFIX)/share/doc/myhotkeys






