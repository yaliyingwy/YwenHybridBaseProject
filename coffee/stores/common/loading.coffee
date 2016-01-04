'use strict'

BaseStore = require 'stores/common/base'
assign = require 'object-assign'
Dispatcher = require 'dispatcher/dispatcher'
ActionType = require 'constants/events'

#引用计数，预防并发网络请求引起的问题
_count = 0

show = (params)->
	console.log 'show loading', params
	_count++
	LoadingStore.emitChange {
		msg: 'SHOW_LOADING'
		content: params.msg
		force: params.force isnt false
	}
	timeout = params.timeout or 30
	setTimeout ->
		hide() if _count > 0
	, timeout * 1000

hide = ->
	if _count is 1
		LoadingStore.emitChange {
			msg: 'HIDE_LOADING'
		}
	_count-- if _count > 0


LoadingStore = assign BaseStore, {
}

LoadingStore.token = Dispatcher.register (action) ->
	switch action.actionType
		when ActionType.LOADING_SHOW then show(action.params)
		when ActionType.LOADING_HIDE then hide()


module.exports = LoadingStore