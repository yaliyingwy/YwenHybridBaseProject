'use strict'

express = require 'express'
app = express()

bodyParser = require 'body-parser'

#log
app.use (req, res, next)->
	console.log "#{req.ip}-#{req.method}-#{req.url}"
	console.log req.body
	res.header "Access-Control-Allow-Origin", "*"
	next()

app.use '/', express.static(__dirname + '/../spa')

app.use(bodyParser())

app.get '/', (req, res)->
	res.sendFile('hello-spa.html', {root: 'spa'})

#假api
app.all '/fake/api/login', (req, res)->
	#延迟一下，方便看到loading
	data = JSON.parse(req.body.data)
	setTimeout ->
		if data.userName is 'ywen' and data.passwd is '123'
			res.json {
				code: '0000'
				data: {
					userId: 'abc123'
				}
				msg: ''
			}
		else
			res.json {
				code: '0001'
				data: ''
				msg: '用户名或密码错误'
			}
	, 3000

app.all '/fake/api/itemList', (req, res)->
	data = null
	try
		data = JSON.parse(req.body.data)
	catch e
		res.json {
			code: '0001'
			msg: '无参数！'
		}
	
	page = data.page or 1
	pageSize = data.pageSize or 10
	res.json {
		code: '0000'
		data: {
			list: ("第#{page}页，第#{i}条数据" for i in [1..pageSize])
		}
	}

app.use (req, res, next)->
	console.log res
	next()

server = app.listen 3000, ->
	console.log 'Listening on  port %d', server.address().port