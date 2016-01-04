Hybrid = require 'ywen-hybrid-js'
AlertAction = require 'actions/common/alert'
ToastAction = require 'actions/common/toast'
LoadingAction = require 'actions/common/loading'
History = require 'utils/history'
Setting = require 'constants/setting'

#page: 推出页面的名称
push = (page, params, success, err)->
	if not window.inBrowser
		Hybrid.nav.push page, params, success, err
	else
		History.pushState null, page, params

#index: 后退几个页面，默认为1，即退回上一页，0的话退回到第一页,考虑到spa部分，尽量不要用0
pop = (index)->
	index = index or 1
	if not window.inBrowser
		Hybrid.nav.pop index
	else
		console.log 'pop:', index
		window.history.go(-index)

#btns: [’确定‘， ’取消‘]
#okCb: 确定的回调
#cancelCb: 取消的回调
alert = (msg, title, btns, okCb, cancelCb)->
	if not window.inBrowser
		Hybrid.ui.alert msg, title, btns, okCb, cancelCb
	else
		AlertAction.show {
			msg: msg
			title: title
			btns: btns
			confirmCb: okCb
			cancelCb: cancelCb
		}

#type: show, success, error
#position: top, center, bottom
#showTime: 显示时间
toast = (type, msg, showTime, position)->
	if not window.inBrowser
		Hybrid.ui.toast type, msg, showTime, position
	else
		ToastAction.show {
			type: type
			msg: msg
			showTime: showTime
		}

#type: show, hide
#force: true, false
#timeout: 超时时间
loading = (type, msg, force, timeout)->
	console.log 'loading---', type
	if not window.inBrowser
		Hybrid.ui.loading type, msg, force, timeout
	else
		if type is 'show'
			LoadingAction.show {
				msg: msg
				force: force
				timeout: timeout
			}
		else
			LoadingAction.hide()

run = (msg, params, success, err)->
	if not window.inBrowser
		Hybrid.hybrid.exec msg, params, success, err
	else
		alert '看到这条消息说明你代码有问题，不应该在纯网页中调用plugin的run方法，用window.inBrowser判断处理一下吧'

#不要直接用alert调试，用这个
debug = (msg)->
	alert msg if Setting.DEBUG
	
module.exports = {
	push: push
	pop: pop
	alert: alert
	toast: toast
	loading: loading
	run: run
	debug: debug
}

	
	

