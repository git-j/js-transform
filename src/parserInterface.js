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
/* \brief Parser Interface
          Interface for all Parsers. A Parser is required to return a JSON model from the input data or throw a exception.
*/
function parserInterface(){
  //SELF
  var self = this;
  //CODE
  
}

/**
 * Parse
 * Virtual parse implememtation. Overloads should call callback(null,json_object)
 * @param JSFunction callback - Callback - function with signature (JSObject error, JSObject result) for async calls
 *
 * @return void
 */
parserInterface.prototype.parse = function(/* JSFunction */callback){
  //SELF
  var self = this;
  //CODE
  console.warn('parserInterface::parse is not implemented');
  callback({message:'parserInterface::parse not implemented'},null);
}

/**
 * Set Input
 * configures the parser to work on the given input-data. the data may be a bytearray (from fs.readFile)
 * @param STRING string_data - no title string_data - no description
 *
 * @return JSObject
 */
parserInterface.prototype.setInput = function(/* STRING */string_data){
  //SELF
  var self = this;
  //CODE
  self.input_data = string_data;
  //END
  return self;
}
module.exports = parserInterface;