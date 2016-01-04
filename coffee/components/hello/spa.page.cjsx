window.inBrowser = true

require 'components/common/common'
require 'hello-style'

React = require 'react'

ReactRouter = require('react-router')

Dom = require 'react-dom'

History = require 'utils/history'



Link = ReactRouter.Link
Router = ReactRouter.Router

Login = require 'components/hello/login.page'
Items = require 'components/hello/items.page'
Demo = require 'components/hello/demo.page'

Toast = require 'components/common/toast'

Alert = require 'components/common/alert'

Loading = require 'components/common/loading'



Hello = React.createClass {
	render: ->
		<div>欢迎来到hello app</div>
}

App = React.createClass {
	render: ->
		<div className="hello">
			<Alert />
			<Toast />
			<Loading />
		<h1 className="title">这是一个hello app</h1>
		<ul className="menu">
			<li><Link to='/hello-login.html'>登录</Link></li>
			<li><Link to='/hello-items.html'>列表</Link></li>
		</ul>
		{@props.children}
		</div>
}

routeConfig = []

hello = {
	path: '/'
	component: App
	indexRoute: {component: Hello}
	childRoutes: [
		{
			path: 'hello-login.html'
			component: Login
		}
		{
			path: 'hello-items.html'
			component: Items
		}
		{
			path: 'hello-demo.html'
			component: Demo
		}
	]

}

routeConfig.push hello

Dom.render <Router history={History} routes={routeConfig} />, document.getElementById('content')