.PHONY: all install uninstall test build mo desktop metainfo
PREFIX ?= /usr
PO_LOCATION ?= po
LOCALE_LOCATION ?= /share/locale

all: desktop metainfo bindings build

bindings: 
#	$(CRYSTAL_LOCATION)shards install
	./bin/gi-crystal

build:
	TINY_APP_LOCALE_LOCATION="$(PREFIX)$(LOCALE_LOCATION)" $(CRYSTAL_LOCATION)shards build -Dpreview_mt --no-debug

build_release:
	TINY_APP_LOCALE_LOCATION="$(PREFIX)$(LOCALE_LOCATION)" $(CRYSTAL_LOCATION)shards build -Dpreview_mt --release --no-debug

test:
	$(CRYSTAL_LOCATION)crystal spec -Dpreview_mt --order random

gresource:
	glib-compile-resources --sourcedir data --target data/dev.geopjr.myhotkeys.gresource data/dev.geopjr.myhotkeys.gresource.xml

mo:
	mkdir -p $(PO_LOCATION)/mo
	for lang in `cat "$(PO_LOCATION)/LINGUAS"`; do \
		if [[ "$$lang" == 'en' || "$$lang" == '' ]]; then continue; fi; \
		mkdir -p "$(PREFIX)$(LOCALE_LOCATION)/$$lang/LC_MESSAGES"; \
		msgfmt "$(PO_LOCATION)/$$lang.po" -o "$(PO_LOCATION)/mo/$$lang.mo"; \
		install -D -m 0644 "$(PO_LOCATION)/mo/$$lang.mo" "$(PREFIX)$(LOCALE_LOCATION)/$$lang/LC_MESSAGES/dev.geopjr.myhotkeys.mo"; \
	done

metainfo:
	msgfmt --xml --template data/dev.geopjr.myhotkeys.metainfo.xml.in -d "$(PO_LOCATION)" -o data/dev.geopjr.myhotkeys.metainfo.xml

desktop:
	msgfmt --desktop --template data/dev.geopjr.myhotkeys.desktop.in -d "$(PO_LOCATION)" -o data/dev.geopjr.myhotkeys.desktop

install: mo
	install -D -m 0755 bin/myhotkeys $(PREFIX)/bin/myhotkeys
	install -D -m 0644 data/dev.geopjr.myhotkeys.desktop $(PREFIX)/share/applications/dev.geopjr.myhotkeys.desktop
	install -D -m 0644 data/icons/dev.geopjr.myhotkeys.svg $(PREFIX)/share/icons/hicolor/scalable/apps/dev.geopjr.myhotkeys.svg
	install -D -m 0644 data/icons/dev.geopjr.myhotkeys-symbolic.svg $(PREFIX)/share/icons/hicolor/symbolic/apps/dev.geopjr.myhotkeys-symbolic.svg
	gtk-update-icon-cache /usr/share/icons/hicolor

uninstall:
	rm -f $(PREFIX)/bin/myhotkeys
	rm -f $(PREFIX)/share/applications/dev.geopjr.myhotkeys.desktop
	rm -f $(PREFIX)/share/icons/hicolor/scalable/apps/dev.geopjr.myhotkeys.svg
	rm -f $(PREFIX)/share/icons/hicolor/symbolic/apps/dev.geopjr.myhotkeys-symbolic.svg
	rm -rf $(PREFIX)$(LOCALE_LOCATION)/*/*/dev.geopjr.myhotkeys.mo
	gtk-update-icon-cache /usr/share/icons/hicolor
