command -v emcc >/dev/null 2>&1 || { echo >&2 "I require emcc but it's not installed.  Aborting."; exit 1; }
command -v emconfigure >/dev/null 2>&1 || { echo >&2 "I require emconfigure but it's not installed.  Aborting."; exit 1; }
command -v emmake >/dev/null 2>&1 || { echo >&2 "I require emmake but it's not installed.  Aborting."; exit 1; }

git submodule init
git submodule update
cd libcaca
emconfigure ./configure --disable-doc --disable-slang --disable-java --disable-cshart --disable-ruby
cd caca
emmake make
cd ../src
emmake make
cd ../..
emcc -O2 libcaca/src/img2txt-img2txt.o dist/libz.bc libcaca/src/img2txt-common-image.o libcaca/caca/.libs/libcaca.a -o img2txt.js --pre-js pre.js
cat > img2txt.wrapper.js << EOF
function img2txt(data, arguments)
{
  var Module = {
    bmp : data,
    arguments: arguments
  };

{{{GENERATED_CODE}}}

  return Module.return;
}
EOF
cat img2txt.wrapper.js
str="{{{GENERATED_CODE}}}"
sed -e "/$str/r img2txt.js" -e "/$str/d" img2txt.wrapper.js > img2txt2.wrapper.js
mv img2txt2.wrapper.js dist/img2txt.js
rm img2txt.js
rm img2txt.wrapper.js

