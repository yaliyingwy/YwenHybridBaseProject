'use strict'

BaseStore = require 'stores/common/base'
assign = require 'object-assign'
Dispatcher = require 'dispatcher/dispatcher'
ActionType = require 'constants/events'

_show = false
_confirmCb = null
_cancelCb = null
_btns = ['确定', '取消']

show = (params)->
	console.log 'show alert', params
	_confirmCb = params.confirmCb
	_cancelCb = params.cancelCb
	_btns = params.btns if params.btns
	_show = true
	AlertStore.emitChange {
		msg: 'SHOW_ALERT'
		content: params.msg
		title: params.title or '提示'
	}

confirm = ->
	_show = false

	_confirmCb?()
	_confirmCb = null
	_btns = ['确定', '取消']

cancel = ->
	_show = false

	_cancelCb?()
	_cancelCb = null
	_btns = ['确定', '取消']

AlertStore = assign BaseStore, {
	getAlertStatus: ->
		_show
	getBtns: ->
		_btns
}

AlertStore.token = Dispatcher.register (action) ->
	switch action.actionType
		when ActionType.ALERT_SHOW then show(action.params)
		when ActionType.ALERT_CONFIRM then confirm()
		when ActionType.ALERT_CANCEL then cancel()


module.exports = AlertStore