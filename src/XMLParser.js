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
var xml2js = require('xml2js');
/** base classes **/
var parserInterface = require('./parserInterface.js');
/* \brief XML Parser
          parserInterface implementation for xml-files.
*/
function XMLParser(){
  //SELF
  var self = this;
  //CODE
  
}
/** base classes **/
XMLParser.prototype = new parserInterface();
XMLParser.prototype.constructor = function(){
  parserInterface.protytype.call(this);
}

/**
 * Parse
 * parses the input_data as xml-nodes (more description->xml2js docu)
 * @param JSFunction callback - Callback - function with signature (JSObject error, JSObject result) for async calls
 *
 * @return void
 */
XMLParser.prototype.parse = function(/* JSFunction */callback){
  //SELF
  var self = this;
  //CODE
  xml2js.Parser().parseString(self.input_data,function(errors,result){
    if ( errors ) throw errors;
    callback(null,result);
  });
}
module.exports = XMLParser;