
// Before executing, set the test.bmp => equals to the bitmap file in Module["bmp"]
Module['preRun'] = function(){
  console.log(Module['intArrayFromString'](Module['bmp']));

  FS.createDataFile("/", "test.bmp", Module['bmp'], true, true);
};

Module['arguments'] = Module['arguments'] || ['-f', 'html', 'test.bmp'];

Module['return'] = '';

Module['print'] = function(text) {
  console.log(text);
  Module['return'] += text + '\n';
}

Module['postRun'] = function(){
  console.log("ended...");
}
