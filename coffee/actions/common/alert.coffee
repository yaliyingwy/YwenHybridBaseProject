'use strict'

Dispatcher = require 'dispatcher/dispatcher'
ActionType = require 'constants/events'

AlertAction = {
	confirm: ->
		setTimeout ->
			Dispatcher.dispatch {
				actionType: ActionType.ALERT_CONFIRM
			}
		, 0
	cancel: ->
		setTimeout ->
			Dispatcher.dispatch {
				actionType: ActionType.ALERT_CANCEL
			}
		, 0
	show: (params)->
		setTimeout ->
			Dispatcher.dispatch {
				actionType: ActionType.ALERT_SHOW
				params: params
			}
		, 0
}

module.exports = AlertAction