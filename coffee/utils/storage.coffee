put = (key, value)->
	if typeof(value) is 'string' and value.constructor is String
		localStorage.setItem key, value
	else
		localStorage.setItem key, JSON.stringify(value)

get = (key)->
	result = localStorage.getItem key
	try
		result = JSON.parse result
	catch e
		console.log 'not json, return string'
	finally
		return result

remove = (key)->
	localStorage.removeItem key

clear = ->
	localStorage.clear()

#页面间数据的传递，都放到一个对象里，避免window上变量污染
transData = (key, value)->
	td = get('transData') or {}
	if value
		td[key] = value
		put 'transData', td
	else
		return td[key] or null

module.exports = 
	put: put
	get: get
	remove: remove
	clear: clear
	transData: transData