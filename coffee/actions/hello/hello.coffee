Dispatcher = require 'dispatcher/dispatcher'
ActionType = require 'constants/events'

HelloAction = {
	login: (params)->
		Dispatcher.dispatch {
			actionType: ActionType.HELLO_LOGIN
			params: params
		}

	itemList: (params)->
		Dispatcher.dispatch {
			actionType: ActionType.HELLO_ITEM_LIST
			params: params
		}
}

module.exports = HelloAction