'use strict';

var webpack = require('webpack'),
    HtmlWebpackPlugin = require('html-webpack-plugin'),
    path = require('path'),
    StatsPlugin = require('stats-webpack-plugin'),
    coffeePath = path.join(__dirname, 'coffee');

var ExtractTextPlugin = require("extract-text-webpack-plugin");

var fs = require('fs');

var busy = false;

var pages = [];


//遍历找到.page后缀的文件，用于自动生成页面
var folders = fs.readdirSync(path.join(coffeePath, 'components'));
for (var i = 0; i < folders.length; i++) {
    var files = fs.readdirSync(path.join(coffeePath, 'components', folders[i]));
    for (var j = 0; j < files.length; j++) {
        var file = files[j];
        var index = file.indexOf('.page.');
        if (index !== -1) {
            pages.push({
                file: file.slice(0, index),
                folder: folders[i]
            });
        }
    }
}

console.log('out pages', pages);


var config = {
    target: 'web',
    cache: true,
    entry: {
        'mobile-util': ['mobile-util'],
        'common': []
    },
    resolve: {
        root: __dirname,
        extensions: ['', '.coffee', '.js', '.cjsx', '.css', '.woff', '.svg', '.ttf', '.eot', '.json', '.png', '.jpg'],
        modulesDirectories: ['coffee', 'assets/js', 'assets/css', 'assets/images', 'node_modules'],
        alias: {
            "fastclick": "node_modules/fastclick/lib/fastclick.js",
            'hello-style': 'assets/css/hello.css',
            'app-style': 'assets/css/app.css',
            'ui-style': 'assets/css/ui.css',
            'anim-style': 'assets/css/anim.css',
        }
    },
    output: {
        path: path.join(__dirname, 'www'),
        publicPath: '/',
        filename: '[name].js',
        pathInfo: true
    },

    module: {
        loaders: [{
            test: /\.coffee$/,
            exclude: /node_modules/,
            loader: 'coffee'
        }, {
            test: /\.cjsx$/,
            exclude: /node_modules/,
            loaders: ['react-hot', "coffee-jsx-loader"]
        }, {
            test: /\.*zepto(\.min)?\.js$/,
            loader: "exports?Zepto"
        }, {
            test: /\.*swiper(\.min)?\.js$/,
            loader: "exports?Swiper"
        }, {
            test: /\.*fastclick(\.min)?\.js$/,
            loader: "exports"
        }, {
            test: /\.*lazyload(\.min)?\.js$/,
            loader: "exports?Swiper"
        }, {
            test: /\.*css$/,
            loader:  ExtractTextPlugin.extract("style-loader", "css-loader")
        }, {
            test: /\.(woff|svg|ttf|eot)$/,
            loader: 'url'
        },{
            test: /\.json$/,
            loader: 'json'
        },{ 
            test: /\.(jpe?g|png|gif|svg)$/i,
            loader: 'url?limit=10000!img?progressive=true'
        }]
    },
    plugins: [
        new ExtractTextPlugin("[name].css", {
            allChunks: true
        }),
        new StatsPlugin('stats.json', {
            chunkModules: true,
            exclude: [/node_modules[\\\/]react/]
        }),
        new webpack.NoErrorsPlugin(),
    ],
};


var chunk_files = []
for (var i = 0; i < pages.length; i++) {
    var page = pages[i];
    chunk_files.push(page.folder + '-' + page.file);

    //自动生成js
    config.entry[page.folder + '-' + page.file] = ['components/' + page.folder + '/' + page.file + '.page'];


    //自动生成html
    config.plugins.push(new HtmlWebpackPlugin({
        inject: true,
        minify: false,
        title: page.file,
        hash: true,
        filename: page.folder + '-' + page.file + '.html',
        chunks: ['common', page.folder + '-' + page.file],
        template: 'assets/views/tpl.html'
    }));
}

config.plugins.push(new webpack.optimize.CommonsChunkPlugin('common.js', chunk_files));

module.exports = config;