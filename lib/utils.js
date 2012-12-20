exports.completeFileName = function (name) {
	return /\.css$/.test(name) ? name : name + '.css'
}