Immutable = require 'immutable'

User = Immutable.Record {
	userName: null #用户名
	passwd: null #密码
}

module.exports = User