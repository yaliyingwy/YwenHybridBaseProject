'use strict'

BaseStore = require 'stores/common/base'
assign = require 'object-assign'
Dispatcher = require 'dispatcher/dispatcher'
ActionType = require 'constants/events'



show = (params)->
	ToastStore.emitChange {
		msg: 'SHOW_TOAST'
		content: params.msg
		type: params.type or 'show'
		showTime: params.showTime or 1
	}


ToastStore = assign BaseStore, {
}

ToastStore.token = Dispatcher.register (action) ->
	switch action.actionType
		when ActionType.TOAST_SHOW then show(action.params)


module.exports = ToastStore