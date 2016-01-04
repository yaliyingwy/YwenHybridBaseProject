require 'ui-style'

React = require 'react'

Dom = require 'react-dom'

ToastStore = require 'stores/common/toast'
ToastAction = require 'actions/common/toast'


Toast = React.createClass {
	getInitialState: ->
		{
			show: false
			msg: ''
			type: 'show'
		}
	componentDidMount: ->
		ToastStore.addChangeListener @_eventHandler

	componentWillUnmount: ->
		ToastStore.removeChangeListener @_eventHandler

	_eventHandler: (event)->
		switch event.msg
			when 'SHOW_TOAST'
				@setState {
					show: true
					type: event.type
					msg: event.content
				}

				#消失
				hide = ->
					@setState {
						show: false
					}
				setTimeout hide.bind(this), event.showTime * 1000


	_disableScroll: (e)->
		e.preventDefault()
		e.stopPropagation()

	render: ->
		cls = if @state.show then 'ui-toast show' else 'ui-toast'
		<section onTouchMove={@_disableScroll} className={cls} >
			<div className="content-box toast-box">
				{
					if @state.type isnt 'show'
						<i className={'hybridui toast-icon ' + if @state.type is 'success' then 'icon-toast-ok' else 'icon-toast-error'}></i>
				}
				<p className="toast-content">{@state.msg}</p>
			</div>
			<div className="ui-mask"></div>
		</section>
}

module.exports = Toast