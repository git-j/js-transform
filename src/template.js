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
var handlebars = require('handlebars');
/* \brief no title template
          no description
*/
function template(){
  //SELF
  var self = this;
  //CODE
  ['buy', 'do', 'drink', 'eat', 'go', 'item-group', 'main', 'other', 'see', 'sleep', 'vicinity']
  .forEach(function(partial){
    handlebars.registerPartial(partial,fs.readFileSync("template/" + partial + ".mustache",{encoding: "UTF-8"}));
  });
  var itemGroupTemplate = handlebars.compile("{{>item-group}}");
  handlebars.registerHelper({
    'item-group': function (name, options) {
      const items = this[name];
      if (!items) {
        return options.inverse(this)
      }
      return itemGroupTemplate({name: name, items: items, icon: options.fn(items, options)});
    },
    'slice': function (array, start, end, options) {
      if (!array || array.length == 0)
        return options.inverse(this);

      return array.slice(start, end).map(options.fn).join('');
    }
  });
}

/**
 * no title render
 * no description
 *
 * @return void
 */
template.prototype.render = function(){
  //SELF
  var self = this;
  //CODE
  handlebars.compile("{{>main}}").call(self,arguments);
}
module.exports = template;