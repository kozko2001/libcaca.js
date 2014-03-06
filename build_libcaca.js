command -v emcc >/dev/null 2>&1 || { echo >&2 "I require emcc but it's not installed.  Aborting."; exit 1; }
command -v emconfigure >/dev/null 2>&1 || { echo >&2 "I require emconfigure but it's not installed.  Aborting."; exit 1; }
command -v emmake >/dev/null 2>&1 || { echo >&2 "I require emmake but it's not installed.  Aborting."; exit 1; }

git submodule init
git submodule update

cd libcaca
emconfigure ./configure --disable-doc --disable-slang --disable-java --disable-cshart --disable-ruby
cd caca
emmake make
cd ../..
emcc -O2 dist/libz.bc libcaca/caca/.libs/libcaca.a -o libcaca.js -s EXPORTED_FUNCTIONS="['_caca_create_canvas', '_caca_set_canvas_size', '_caca_set_color_ansi', '_caca_clear_canvas', '_caca_set_dither_algorithm', '_caca_create_dither', '_caca_dither_bitmap', '_caca_export_canvas_to_memory']"
mv libcaca.js dist/
