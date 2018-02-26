BUILD_FLAGS		= -O0 -g -DCHUNKWM_DEBUG -std=c++11 -Wall -Wno-deprecated
BUILD_PATH		= ./bin
SRC				= ./src/core/chunkwm.mm
BINS			= $(BUILD_PATH)/chunkwm $(BUILD_PATH)/chunkc plugins/bar.so plugins/blur.so plugins/border.so plugins/ffm.so plugins/purify.so plugins/tiling.so
LINK			= -rdynamic -ldl -lpthread -framework Carbon -framework Cocoa

all: $(BINS)

copy:

install: BUILD_FLAGS=-O2 -std=c++11 -Wall -Wno-deprecated
install: clean $(BINS) copy

.PHONY: all clean install chunkc

$(BINS): | $(BUILD_PATH)

$(BUILD_PATH):
	mkdir -p $(BUILD_PATH)

clean:
	rm -rf $(BUILD_PATH)
	rm -rf plugins

$(BUILD_PATH)/chunkwm: $(SRC)
	clang++ $^ $(BUILD_FLAGS) -o $@ $(LINK)

$(BUILD_PATH)/chunkc: ./src/chunkc/chunkc.c
	clang src/chunkc/chunkc.c -O2 -o $(BUILD_PATH)/chunkc

plugins/bar.so:
	make install -C src/plugins/bar

plugins/blur.so:
	make install -C src/plugins/blur
	cp src/plugins/blur/bin/blur.so plugins/blur.so

plugins/border.so:
	make install -C src/plugins/border

plugins/ffm.so:
	make install -C src/plugins/ffm

plugins/purify.so:
	make install -C src/plugins/purify

plugins/tiling.so:
	make install -C src/plugins/tiling

