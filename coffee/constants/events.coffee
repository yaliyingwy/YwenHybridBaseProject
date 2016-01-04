keymirror  = require 'keymirror'

actionType = {
	CALL_FROM_NATIVE: null

	#通用的ui小组件
	#alert
	ALERT_SHOW: null
	ALERT_CONFIRM: null
	ALERT_CANCEL: null
	#toast
	TOAST_SHOW: null
	#loading
	LOADING_SHOW: null
	LOADING_HIDE: null

	#hello word
	HELLO_LOGIN: null
	HELLO_ITEM_LIST: null
}

module.exports = keymirror actionType