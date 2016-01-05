require 'components/common/common'


React = require 'react'

Dom = require 'react-dom'

PureRenderMixin = require 'react-addons-pure-render-mixin'
LinkedStateMixin = require 'react-addons-linked-state-mixin'
CSSTransitionGroup = require 'react-addons-css-transition-group'
InfiniteScroll = require('react-infinite-scroll')(React)
CommonStore = require 'stores/common/common'
HelloStore = require 'stores/hello/hello'
HelloAction = require 'actions/hello/hello'

#分页参数
_page = 1
_pageSize = 40
_hasMore = true
_netBusy = false

Items = React.createClass {
	mixins: [PureRenderMixin, LinkedStateMixin]

	getInitialState: ->
		{
			list: HelloStore.getItemList()
		}

	componentDidMount: ->
		CommonStore.addChangeListener @_change

	componentWillUnmount: ->
		CommonStore.removeChangeListener @_change

	_change: (event)->
		switch event.msg
			when 'PAGE_HELLO_ITEM_LIST_APPEAR'
				console.log  'item-list page appear!'
			when 'ITEM_LIST_CHANGE'
				_netBusy = false
				list = HelloStore.getItemList()
				_hasMore = (list.size % _pageSize) is 0
				_page = parseInt(list.size / _pageSize) + 1 if _hasMore
				console.log "_netBusy: #{_netBusy}, _hasMore: #{_hasMore}, _page: #{_page}"

				@setState {
					list: list
				}

	_requestData: ->
		console.log '_requestData!'
		return null if _netBusy

		_netBusy = true
		HelloAction.itemList {
			page: _page
			pageSize: _pageSize
		}

	render: ->
		itemList = @state.list.map (item, i)->
			<li key={i}>{item}</li>
		<div className="item-list">
		<h1>这是一个列表页面</h1>
		<div className="list">
		<ul>
		<InfiniteScroll pageStart=0 loadMore={@_requestData} hasMore={_hasMore and not _netBusy}>
		<CSSTransitionGroup transitionName="list" transitionEnterTimeout={500} transitionLeaveTimeout={300}>
		{itemList}
		</CSSTransitionGroup>
		</InfiniteScroll>
		</ul>
		</div>
		</div>
}

if not window.inBrowser
	Dom.render <Items />, document.getElementById('content')

module.exports = Items