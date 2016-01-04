gulp = require 'gulp'
plugins = require('gulp-load-plugins')()

apiServer = 'http://192.168.26.177:7080/llmj-app/'

www_folders = ['HybridIos/HybridIos/www/', 'HybridAndroid/app/src/main/assets/www/']
spa_files = [
	'www/hello-spa.html',
	'www/hello-spa.js',
	'www/mobile-util.js',
	'www/hello-spa.css',
	'www/common.js',
]

#webpack
webpack = require 'webpack'
WebpackDevServer = require 'webpack-dev-server'
config = require './webpack.config.js'

gulp.task 'webpack:build', ['pre-build'], (cb)->
	myConfig = Object.create config
	myConfig.output.publicPath = './'
	myConfig.plugins = myConfig.plugins.concat(
		new webpack.DefinePlugin({
			'process.env': {
				'NODE_ENV': JSON.stringify 'development'
			}
		}),
		new webpack.optimize.DedupePlugin(),
	) 
	webpack myConfig, (err, stats)->
			plugins.util.PluginError 'webpack', err  if err
			plugins.util.log '[webpack]', stats.toString {colors: true}
			cb()

gulp.task 'webpack:dist', ['pre-build'], (cb)->
	myConfig = Object.create config
	myConfig.output.publicPath = './'
	myConfig.plugins = myConfig.plugins.concat(
		new webpack.DefinePlugin({
			'process.env': {
				'NODE_ENV': JSON.stringify 'production'
			}
		}),
		new webpack.optimize.DedupePlugin(),
		# new webpack.optimize.OccurenceOrderPlugin(true),
		new webpack.optimize.LimitChunkCountPlugin({maxChunks: 15}),
		new webpack.optimize.MinChunkSizePlugin({minChunkSize: 10000}),
		new webpack.optimize.UglifyJsPlugin {
			compress: {
				drop_console: true
			}
			outSourceMap: false
		}
	) 
	webpack myConfig, (err, stats)->
			plugins.util.PluginError 'webpack', err  if err
			plugins.util.log '[webpack]', stats.toString {colors: true}
			cb()


devConfig = Object.create config
devConfig.devtool = 'eval-cheap-module-source-map'
devConfig.debug = true
devConfig.output.publicPath = './'
devCompiler = webpack devConfig
gulp.task 'webpack:dev', ['pre-build'], (cb)->
	devCompiler.run (err, stats)->
		throw new plugins.util.PluginError 'webpack:dev', err if err
		plugins.util.log '[webpack:dev]', stats.toString {colors: true}
		cb()


gulp.task 'webpack-dev-server', ['pre-build'], (cb)->
	serverConfig = Object.create config
	for key in Object.keys(serverConfig.entry)
		serverConfig.entry[key].unshift 'webpack-dev-server/client?http://localhost:8080', 'webpack/hot/dev-server'
	serverConfig.debug = true
	serverConfig.devtool = 'eval-cheap-module-source-map'
	serverConfig.plugins = serverConfig.plugins.concat(
		new webpack.HotModuleReplacementPlugin()
		)
 
	new WebpackDevServer webpack(serverConfig), {
		# publicPath: serverConfig.output.publicPath
		contentBase: serverConfig.output.path
		hot: true
		historyApiFallback: true
		proxy: {
			'*shtml': apiServer, #反向代理，解决跨域
			'/fake/api/*': 'http://localhost:3000',
		}
		stats: {
			colors: true
		}
	}
	.listen 8080, 'localhost', (err)->
			throw new plugins.util.PluginError 'webpack-dev-server', err if err
			plugins.util.log '[webpack-dev-server]', 'http://localhost:8080/webpack-dev-server/hello-spa.html'


gulp.task 'build-dev', ['webpack:dev'], ->
	gulp.watch ['coffee/**/*'], ['webpack:dev']


gulp.task 'prepare', ['webpack:build'], plugins.shell.task('rsync -r www/* ' + www_folders.join(';rsync -r www/* '))

gulp.task 'clean', plugins.shell.task('rm -rf www/* spa/* ' + www_folders.join('* '))

gulp.task 'sass', ->
	plugins.rubySass('assets/sass/*.scss').pipe(gulp.dest('assets/css/'))

gulp.task 'style', ->
	gulp.watch ['assets/sass/*.scss'], ['sass']


gulp.task 'todo', plugins.shell.task('grep -r "TODO" coffee -n > TODO.md')


gulp.task 'pre-build', ['sass', 'todo']

gulp.task 'build', ['webpack:build'], plugins.shell.task('rsync -r www/* ' + www_folders.join(';rsync -r www/* '))
gulp.task 'dist', ['webpack:dist'], plugins.shell.task('rsync -r www/* ' + www_folders.join(';rsync -r www/* '))
gulp.task 'spa:build', ['webpack:build'], plugins.shell.task('cp ' + spa_files.join(' ') + ' spa/')
gulp.task 'spa:dist', ['webpack:dist'], plugins.shell.task('cp ' + spa_files.join(' ') + ' spa/')
gulp.task 'spa:server', plugins.shell.task(['cd server', 'coffee server/app.coffee'])

gulp.task 'coffee', ->
	gulp.src('coffee/test/*.coffee').pipe(plugins.coffee()).pipe(gulp.dest('coffee/test/build/'))

gulp.task 'mocha', ['coffee'], ->
	gulp.src(['coffee/test/build/*.js']).pipe(plugins.mocha())

gulp.task 'test', ->
	# 自动单元测试
	gulp.watch('coffee/test/*.coffee').on 'change', (file)->
		gulp.src(file.path).pipe(plugins.coffee()).pipe(gulp.dest('coffee/test/build/'))

	gulp.watch(['coffee/test/build/*.js']).on 'change', (file)->
		gulp.src(file.path, {read: false}).pipe(plugins.mocha({timeout: 10000})).on 'error', (err)->
			console.error '测试未通过', err

gulp.task 'default', ['webpack-dev-server', 'style', 'test', 'spa:server']
