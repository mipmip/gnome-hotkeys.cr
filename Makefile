.PHONY: all test build
PREFIX ?= /usr
LOCALE_LOCATION ?= /share/locale

all: bindings build

bindings:
	./bin/gi-crystal --no-doc

build:
	TINY_APP_LOCALE_LOCATION="$(PREFIX)$(LOCALE_LOCATION)" $(CRYSTAL_LOCATION)shards build -Dpreview_mt --no-debug

build_release:
	TINY_APP_LOCALE_LOCATION="$(PREFIX)$(LOCALE_LOCATION)" $(CRYSTAL_LOCATION)shards build -Dpreview_mt --release --no-debug

test:
	$(CRYSTAL_LOCATION)crystal spec -Dpreview_mt --order random
