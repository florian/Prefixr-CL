var fs = require('fs');
var $ = require('jquery');
var utils = require('./utils.js');

var prefix = function (css, options, callback) {

	if ($.isFunction(options)) {
		callback = options;
		options = {};
	} else {
		options = options || {};

		options.add_spaces_option = 'on';

		options.compress_option = options.compress ? 'on' : 'off';
		if (options.compress_option == 'off') delete options.compress_option;

		options.keep_vars_option = options.variables ? 'off' : 'on';
		if (options.keep_vars_option == 'off') delete options.keep_vars_option;

		options.exclude = $.makeArray(options.exclude);
		options.exclude.forEach(function (prefix) {
			options[prefix + '_exclude'] = 'on';
		});

		delete options.compress;
		delete options.variables;
		delete options.exclude;
	}

	params = options;
	params.css = css;

	$.post('http://prefixr.com/api/index.php', params, function (prefixed) {
		callback(prefixed);
	});
};

prefix.files = function (files, options, callback) {
	files = $.makeArray(files);
	var css = '';

	files.forEach(function (name) {
		name = utils.completeFileName(name);
		css += fs.readFileSync(name);
	});

	prefix(css, options, callback);
};

prefix.VERSION = '1.0.1';

module.exports = prefix;