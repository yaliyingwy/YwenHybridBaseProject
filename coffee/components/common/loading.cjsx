require 'ui-style'

React = require 'react'

Dom = require 'react-dom'

LoadingStore = require 'stores/common/loading'
LoadingAction = require 'actions/common/loading'

Halogen = require 'halogen'



Loading = React.createClass {
	getInitialState: ->
		{
			show: false
			msg: '加载中....'
			force: true
		}
	componentDidMount: ->
		LoadingStore.addChangeListener @_eventHandler

	componentWillUnmount: ->
		LoadingStore.removeChangeListener @_eventHandler

	_eventHandler: (event)->
		switch event.msg
			when 'SHOW_LOADING'
				@setState {
					show: true
					msg: event.content
					force: event.force
				}
			when 'HIDE_LOADING'
				@setState {
					show: false
				}

	_clickLoading: ->
		console.log 'force---', @state.force
		LoadingAction.hide() if @state.force is false


	_disableScroll: (e)->
		e.preventDefault()
		e.stopPropagation()

	render: ->
		spinnerSize = 30/(640/16/1)
		spinnerMargin = 8/(640/16/1)
		cls = if @state.show then 'ui-loading show' else 'ui-loading'
		<section  onTouchMove={@_disableScroll} className={cls} >
			<div className="content-box loading-box">
				<div className="loading-spinner"><Halogen.PulseLoader size={spinnerSize.toFixed(2) + 'rem'} margin={spinnerMargin.toFixed(2) + 'rem'} color='white' /></div>
				{
					if @state.msg?.length > 0
						<p className="loading-content">{@state.msg}</p>
				}	
			</div>
			<div onClick={@_clickLoading} className="ui-mask"></div>
		</section>
}

module.exports = Loading