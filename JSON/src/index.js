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
/* \brief no title index
          no description
*/
function index(){
  //SELF
  var self = this;
  //CODE
  
}

/**
 * no title map
 * no description
 * @param JSFunction callback - Callback - function with signature (JSObject error, JSObject result) for async calls
 *
 * @return void
 */
index.prototype.map = function(/* JSFunction */callback){
  //SELF
  var self = this;
  //CODE
  callback(null,self.source);
  
}

/**
 * no title render
 * no description
 * @param JSFunction callback - Callback - function with signature (JSObject error, JSObject result) for async calls
 *
 * @return void
 */
index.prototype.render = function(/* JSFunction */callback){
  //SELF
  var self = this;
  //CODE
  callback(null,self.source);
}

/**
 * no title setModel
 * no description
 * @param JSObject model - no title model - no description
 *
 * @return JSObject
 */
index.prototype.setModel = function(/* JSObject */model){
  //SELF
  var self = this;
  //CODE
  self.source = model;
  //END
  return self;
}
module.exports = index;