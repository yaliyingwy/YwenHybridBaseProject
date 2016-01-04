require 'components/common/common'

require 'hello-style'

React = require 'react'

Dom = require 'react-dom'

PureRenderMixin = require 'react-addons-pure-render-mixin'
LinkedStateMixin = require 'react-addons-linked-state-mixin'

Plugin = require 'utils/plugin'

Demo = React.createClass {
	mixins: [PureRenderMixin, LinkedStateMixin]

	_pop: ->
		Plugin.pop()
	render: ->
		<div className="demo">
		<h1>hybrid demo 展示</h1>
		<ul>
		<li><a onClick={@_pop}>pop回去</a></li>
		</ul>
		</div>
}

if not window.inBrowser
	Dom.render <Demo />, document.getElementById('content')

module.exports = Demo