mobile = (input)->
	return /^1\d{2}(-|\s)?\d{4}(-|\s)?\d{4}$/.test input

module.exports = {
	mobile: mobile
}