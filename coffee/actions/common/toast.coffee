'use strict'

Dispatcher = require 'dispatcher/dispatcher'
ActionType = require 'constants/events'

ToastAction = {
	show: (params)->
		setTimeout ->
			Dispatcher.dispatch {
				actionType: ActionType.TOAST_SHOW
				params: params
			}
		, 0
}

module.exports = ToastAction