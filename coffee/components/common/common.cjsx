FastClick = require 'fastclick'
Hybrid = require 'ywen-hybrid-js'

DB = require 'utils/storage'

CommonAction = require 'actions/common/common'
CommonStore = require 'stores/common/common'

document.addEventListener 'deviceready', ->
	FastClick.attach document.body
	Hybrid.hybrid.registerHandler (data)->
		CommonAction.callFromNative data
	DB.put 'uuid', window.uuid if window.uuid
	DB.put 'version', window.version if window.version
	DB.put 'client_type', window.client_type if window.client_type
