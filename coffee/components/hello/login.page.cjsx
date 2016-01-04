require 'components/common/common'
require 'hello-style'

React = require 'react'
Dom = require 'react-dom'

PureRenderMixin = require 'react-addons-pure-render-mixin'
LinkedStateMixin = require 'react-addons-linked-state-mixin'

Plugin = require 'utils/plugin'

HelloAction = require 'actions/hello/hello'
HelloStore = require 'stores/hello/hello'
CommonStore = require 'stores/common/common'

Login = React.createClass {
	mixins: [PureRenderMixin, LinkedStateMixin]

	componentDidMount: ->
		CommonStore.addChangeListener @_change

	componentWillUnmount: ->
		CommonStore.removeChangeListener @_change

	_change: (event)->
		switch event.msg
			when 'PAGE_HELLO_LOGIN_APPEAR'
				alert 'login page appear!'

	getInitialState: ->
		{
			userName: ''
			passwd: ''
		}

	_login: ->
		console.log 'click login!'
		if @state.userName.length < 1
			Plugin.toast 'error', '用户名不能为空', 3
		else if @state.passwd.length < 1
			Plugin.toast 'show', '密码不能为空', 1
		else
			userName = @state.userName
			passwd = @state.passwd
			Plugin.alert '确定进行登录？', '请确定', ['登录', '取消'], ->
				setTimeout ->
					console.log 'do login'
					HelloAction.login {
						userName: userName
						passwd: passwd
					}
				, 0
			, ->
				Plugin.toast 'error', '用户放弃了登录'

	render: ->
		<div className="login">
		<input valueLink={@linkState 'userName'} className="input-weak" type="text" placeholder="用户名" />
		<input valueLink={@linkState 'passwd'} className="input-weak" type="text" placeholder="密码" />
		<a className="btn-pri" onClick={@_login}>登录</a>
		</div>
}

if not window.inBrowser
	Dom.render <Login />, document.getElementById('content')

module.exports = Login