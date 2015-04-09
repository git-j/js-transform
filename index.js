/*
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
var mu = require('mu2');
var mustache = require('mustache');
var fs = require('fs');
require('array.prototype.find');

var transformer = {
	transform: function(input, callback) {
		parser.parse(input, function(source){
			callback(renderer.render(mapper.map(source)));
		})
	}
}

var parser = {
	parse: function(data, callback) {
		xml2js.Parser().parseString(data, function(error, result){
			if (error) throw error;
			callback(result);
		});
	}
}

var mapper = {
	map: function(source){
		return {
			organisation: this.mapOrganization(source.TED_EXPORT
					.FORM_SECTION[0]
					.PRIOR_INFORMATION[0]
					.FD_PRIOR_INFORMATION[0]
					.AUTHORITY_PRIOR_INFORMATION[0]
					.NAME_ADDRESSES_CONTACT_PRIOR_INFORMATION[0])
		};
	},
	mapOrganization: function(source) {
		var profile = source.CA_CE_CONCESSIONAIRE_PROFILE[0];
		return {
			name: profile.ORGANISATION[0].OFFICIALNAME[0],
			strasse_hausnummer: profile.ADDRESS[0]
		};
	}
}

var renderer = {
	render: function(model) {
		return JSON.stringify(model.organisation);
	}
}

fs.readFile(process.argv[2], function(error, data){
	if (error) throw error;
	transformer.transform(data, function(output){
		console.log(output);
	})
});
