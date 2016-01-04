require 'ui-style'

React = require 'react'

Dom = require 'react-dom'

AlertStore = require 'stores/common/alert'
AlertAction = require 'actions/common/alert'


Alert = React.createClass {
	getInitialState: ->
		{
			show: AlertStore.getAlertStatus()
			btns: AlertStore.getBtns()
			title: '提示'
			content: ''
		}
	componentDidMount: ->
		AlertStore.addChangeListener @_eventHandler

	componentWillUnmount: ->
		AlertStore.removeChangeListener @_eventHandler

	_eventHandler: (event)->
		switch event.msg
			when 'SHOW_ALERT'
				@setState {
					btns: AlertStore.getBtns()
					show: AlertStore.getAlertStatus()
					title: event?.title or '提示'
					content: event?.content
				}

	_confirm: ->
		@setState {
			show: false
		}
		AlertAction.confirm()

	_cancel: ->
		@setState {
			show: false
		}
		AlertAction.cancel()

	_disableScroll: (e)->
		e.preventDefault()
		e.stopPropagation()

	render: ->
		cls = if @state.show then 'ui-alert show' else 'ui-alert'
		<section onTouchMove={@_disableScroll} className={cls} >
			<div className="content-box alert-box">
			    <div className="alert-title">{@state.title}</div>
			    	<p className="alert-content">{@state.content}</p>
			    <div className="btns">
			        <a onClick={@_confirm}>{@state.btns[0]}</a>
			        <a onClick={@_cancel}>{@state.btns[1]}</a>
			    </div>
			</div>
			<div className="ui-mask"></div>
		</section>
}

module.exports = Alert