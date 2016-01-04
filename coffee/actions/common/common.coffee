'use strict'

Dispatcher = require 'dispatcher/dispatcher'
ActionType = require 'constants/events'

CommonAction = {
	callFromNative: (data)->
		Dispatcher.dispatch {
			actionType: ActionType.CALL_FROM_NATIVE
			msg: data.msg or 'EMPTY_MESSAGE'
			params: data.params or {}
		}
}

module.exports = CommonAction