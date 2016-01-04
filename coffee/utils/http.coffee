Api = require 'constants/api'
Setting = require 'constants/setting'
DB = require 'utils/storage'
UUID = require 'utils/uuid'
Plugin = require 'utils/plugin'
request = require 'superagent'



post = (api, params, cb, err, showLoading)->
	console.log api, params, cb, err, showLoading
	data = JSON.stringify params
	#浏览器中调试，生成假的数据
	if window.inBrowser
		window.uuid = UUID.v4()
		window.version = '1.0'
		window.client_type = '2'

	#没有就从本地取
	uuid = window.uuid or DB.get 'uuid'
	version = window.version or DB.get 'version'
	client_type = window.client_type or DB.get 'client_type'

	if not (uuid && version && client_type)
		console.error 'uuid:', uuid, ',version:', version, ',client_type:', client_type
		return

    #更新本地存储
	DB.put 'uuid', uuid
	DB.put 'version', version
	DB.put 'client_type', client_type

	console.group()
	paramDic = {
		uuid: uuid
		version: version
		client_type: client_type
		data: data
	}
	
	api = Setting.API_SERVER + api if api.indexOf('http') isnt 0 and not window.inBrowser
	console.log '请求接口:', api
	console.log '发送参数:', JSON.stringify(paramDic)


	Plugin.loading 'show', '加载中...', true, 30 if showLoading

	request.post(api)
			.type('form')
			.send(paramDic)
			.timeout(Setting.HTTP_TIMEOUT)
			.end (err, res)->
				Plugin.loading 'hide' if showLoading
				if err
					return Plugin.toast 'error', '无法连接到服务器，请检查网络设置', 2
				console.log '返回值：', res.text
				result = null
				try
					result = JSON.parse res.text
				catch e
					console.error res.text
				if result.code is '0000'
					cb result.data
				else
					console.error "错误码: #{result.code}, 错误信息: #{result.msg}"
					if err
						err result.msg
					else
						Plugin.toast 'error', result.msg

	

module.exports = 
	post: post