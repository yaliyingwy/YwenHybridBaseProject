require 'anim-style'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'

CHANGE_EVENT = 'change'
ONETIME_EVENT = 'one:time:event'


BaseStore = assign {}, EventEmitter.prototype, {
	urlPath: window.location.pathname
	emitChange: (params)->
		@emit CHANGE_EVENT, params

	emitOneTime: (params)->
		@emit ONETIME_EVENT, params

	addChangeListener: (cb)->
		@on CHANGE_EVENT, cb

	addOneTimeListener: (cb, signal)->
		@once signal or ONETIME_EVENT, cb

	removeChangeListener: (cb)->
		@removeListener CHANGE_EVENT, cb
	}

module.exports = BaseStore