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

