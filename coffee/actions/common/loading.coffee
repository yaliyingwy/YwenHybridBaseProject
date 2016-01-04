'use strict'

Dispatcher = require 'dispatcher/dispatcher'
ActionType = require 'constants/events'

LoadingAction = {
	show: (params)->
		setTimeout ->
			Dispatcher.dispatch {
				actionType: ActionType.LOADING_SHOW
				params: params
			}
		, 0
	hide: ->
		setTimeout ->
			Dispatcher.dispatch {
				actionType: ActionType.LOADING_HIDE
			}
		, 0
}

module.exports = LoadingAction