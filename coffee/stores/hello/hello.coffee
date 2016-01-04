'use strict'

BaseStore = require 'stores/common/base'
assign = require 'object-assign'
Dispatcher = require 'dispatcher/dispatcher'
ActionType = require 'constants/events'
Plugin = require 'utils/plugin'

UserModel = require 'model/user'

Http = require 'utils/http'
Api = require 'constants/api'

Immutable = require 'immutable'


_user = new UserModel
_items = Immutable.List()


login = (params)->
	console.log 'login params: ', params
	Http.post Api.HELLO_LOGIN, params, (data)->
		console.log 'data', data
		Plugin.toast 'success', '登录成功！'
		Plugin.push '/hello-demo.html'
	, null
	, true

itemList = (params)->
	Http.post Api.HELLO_ITEM_LIST, params, (data)->
		_items = Immutable.List() if params.page is 1
		_items = _items.concat data.list
		HelloStore.emitChange {
			msg: 'ITEM_LIST_CHANGE'
		}

HelloStore = assign BaseStore, {
	getUser: ->
		_user

	getItemList: ->
		_items
}


Dispatcher.register (action) ->
	console.log 'action:', action, action.actionType, ActionType.HELLO_LOGIN
	return null if not action.actionType
	switch action.actionType
		when ActionType.HELLO_LOGIN 
			login(action.params)
		when ActionType.HELLO_ITEM_LIST
			itemList(action.params)



module.exports = HelloStore