'use strict'

BaseStore = require 'stores/common/base'
assign = require 'object-assign'
Dispatcher = require 'dispatcher/dispatcher'
ActionType = require 'constants/events'


#TODO: 一些页面出现刷新数据的方法放到这里
viewAppear = ->
	paths = window.location.pathname.split('/')
	switch paths[paths.length - 1]
		when 'hello-login.html', 'hello'
			CommonStore.emitChange {
				msg: 'PAGE_HELLO_LOGIN_APPEAR'
			}
		when 'hello-items.html'
			CommonStore.emitChange {
				msg: 'PAGE_HELLO_ITEM_LIST_APPEAR'
			}


CommonStore = assign BaseStore, {

}

CommonStore.token = Dispatcher.register (action) ->
	console.log 'action in common', action
	if action.actionType is ActionType.CALL_FROM_NATIVE
		switch action.msg
			when 'VIEW_APPEAR' then viewAppear()


module.exports = CommonStore