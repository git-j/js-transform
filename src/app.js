/** LICENSE
Copyright (c) 2015, git-j@refeus.de
Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice  and this permission notice appear in all copies.
THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
var Promise = require('bluebird');
var XMLParser = require('./XMLParser.js');
var parserInterface = require('./parserInterface.js');
var transformWorker = require('./transformWorker.js');
/* \brief JS-Transform App
          console application to convert a given input file to the from the given input format to the given output format
*/
function app(){
  //SELF
  var self = this;
  //CODE
  
}

/**
 * Main
 * Entrypoint for console
 * @param int argc - no title argc - no description
 * @param JSArray argv - no title - no description
 *
 * @return INT
 */
app.prototype.main = function(/* int */argc, /* JSArray */argv){
  //SELF
  var self = this;
  //START
  var rc = 0;
  var parser = new parserInterface();
  var transformer = new transformWorker();
  //CODE
  if ( argc < 4
    || typeof argv[2] !== 'string'
    || typeof argv[3] !== 'string'
    || typeof argv[4] !== 'string'
    ){
    self.usage();
  }
  var filename = argv[2];
  var input_type = argv[3];
  var output_type = argv[4];

  /** todo: factory */
  if ( filename.indexOf('.xml') === filename.length - 4 ){
    parser = new XMLParser();
  }

  var mapper = require('../' + input_type + '/src');
  var renderer = require('../' + output_type + '/src');

  transformer.setInputFilename(filename)
             .setParser(parser)
             .setMapper(new mapper())
             .setRenderer(new renderer())
             .run(function(errors,output){
    console.log(output);
  });
  //ERROR
  rc = 1;
  //END
  return rc;
}

/**
 * Usage
 * Tell the user how to use it
 *
 * @return void
 */
app.prototype.usage = function(){
  //SELF
  var self = this;
  //CODE
  console.log('js-transform');
  console.log('node.js app.js path/to.input InputType OutputType');
  console.log('input types: OSM');
  console.log('output types: JSON');
  process.exit(1);
}
/** executable entry point */
var app_instance = new app();
app_instance.main(process.argc, process.argv);