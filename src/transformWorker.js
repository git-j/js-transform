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
var fs = require('fs');
/* \brief Transform Worker
          must be configured with renderer, mapper and input data to work, then the work is done by run
*/
function transformWorker(){
  //SELF
  var self = this;
  //CODE
  
}

/**
 * Load Input
 * Reads the current input filename to a internal buffer
 * @param JSFunction callback - Callback - function with signature (JSObject error, JSObject result) for async calls
 *
 * @return void
 */
transformWorker.prototype.loadInput = function(/* JSFunction */callback){
  //SELF
  var self = this;
  //CODE
  fs.readFile(self.input_filename, function (error, data) {
    if (error) throw error;
    callback(null,data);
  });
}

/**
 * no title run
 * no description
 * @param JSFunction callback - Callback - function with signature (JSObject error, JSObject result) for async calls
 *
 * @return void
 */
transformWorker.prototype.run = function(/* JSFunction */callback){
  //SELF
  var self = this;
  //CODE
  self.loadInput(function(errors,input_file_contents){
    if ( errors ) throw errors;
    self.parser.setInput(input_file_contents).parse(function(errors,input_model){
      if ( errors ) throw errors;
      self.mapper.setModel(input_model)
                 .map(function(errors,render_model){
        if ( errors ) throw errors;
        self.renderer.setModel(render_model).render(function(errors,output_data){
          if ( errors ) throw errors;
          callback(errors,output_data)
        });
      });
    });
  });
}

/**
 * Set Input Filename
 * configures worker to a specific input file. mapper and parser should be able to process the format
 * @param STRING filename - no title filename - no description
 *
 * @return JSObject
 */
transformWorker.prototype.setInputFilename = function(/* STRING */filename){
  //SELF
  var self = this;
  //CODE
  self.input_filename = filename;
  //END
  return self;
}

/**
 * Set Mapper
 * configures the worker to use a instance of mapperInterface to process the input model to the intermediate model
 * @param mapperInterface mapper - no title mapper - no description
 *
 * @return JSObject
 */
transformWorker.prototype.setMapper = function(/* mapperInterface */mapper){
  //SELF
  var self = this;
  //CODE
  self.mapper = mapper;
  //END
  return self;
}

/**
 * Set Parser
 * configures the worker to use a instance of parserInterface to process the input raw data and convert it to the input model
 * @param parserInterface parser - Parser - Parser that is used to load the inputModel so the definitionModel may use it
 *
 * @return JSObject
 */
transformWorker.prototype.setParser = function(/* parserInterface */parser){
  //SELF
  var self = this;
  //CODE
  self.parser = parser;
  //END
  return self;
}

/**
 * Set Renderer
 * configures the worker to use a instance of renderer to process the intermediate model into the output model
 * @param rendererInterface renderer - no title renderer - no description
 *
 * @return JSObject
 */
transformWorker.prototype.setRenderer = function(/* rendererInterface */renderer){
  //SELF
  var self = this;
  //CODE
  self.renderer = renderer;
  //END
  return self;
}
module.exports = transformWorker;