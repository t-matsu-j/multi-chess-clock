'use strict'
path = require('path')
utils = require('./utils')
config = require('../config')
vueLoaderConfig = require('./vue-loader.conf')

resolve = (dir) ->
  return path.join(__dirname, '..', dir)

createLintingRule = ->
  return {
    test: /\.(js|vue)$/
    loader: 'eslint-loader'
    enforce: 'pre'
    include: [resolve('src'), resolve('test')]
    options:
      formatter: require('eslint-friendly-formatter')
      emitWarning: !config.dev.showEslintErrorsInOverlay
    }

clientConfig =
  context: path.resolve(__dirname, '../')
  entry:
    app: './src/main.js'
  output:
    path: config.build.assetsRoot
    filename: '[name].js'
    publicPath: if process.env.NODE_ENV is 'production' then config.build.assetsPublicPath else config.dev.assetsPublicPath
  resolve:
    extensions: ['.js', '.vue', '.json']
    alias:
      'vue$': 'vue/dist/vue.esm.js'
      '@': resolve('src')
  module:
    rules: [
#      [createLintingRule()] if config.dev.useEslint else [],
        test: /\.vue$/
        loader: 'vue-loader'
        options: vueLoaderConfig
      ,
        test: /\.coffee$/
        loader: 'coffee-loader'
      ,
        test: /\.js$/
        loader: 'babel-loader'
        include: [resolve('src'), resolve('test')]
      ,
        test: /\.(png|jpe?g|gif|svg)(\?.*)?$/
        loader: 'url-loader'
        options:
          limit: 10000
          name: utils.assetsPath('img/[name].[hash:7].[ext]')
      ,
        test: /\.(mp4|webm|ogg|mp3|wav|flac|aac)(\?.*)?$/
        loader: 'url-loader'
        options:
          limit: 10000
          name: utils.assetsPath('media/[name].[hash:7].[ext]')
      ,
        test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/
        loader: 'url-loader'
        options:
          limit: 10000
          name: utils.assetsPath('fonts/[name].[hash:7].[ext]')
      ]
  node:
    ## prevent webpack from injecting useless setImmediate polyfill because Vue
    ## source contains it (although only uses it if it's native).
    setImmediate: false
    ## prevent webpack from injecting mocks to Node native modules
    ## that does not make sense for the client
    dgram: 'empty'
    fs: 'empty'
    net: 'empty'
    tls: 'empty'
    child_process: 'empty'

serverConfig =
  context: path.resolve(__dirname, '../')
  target: 'node'
  entry:
    io: './src/server/io.coffee'
  resolve:
    modules: [path.resolve(__dirname, '../src/server')]
    extensions: [".coffee", ".js"]
  externals: [
    "socket.io": "socket.io"
    "require-dir": "require-dir"
  ]
  output:
    path: config.build.assetsRoot
    library: "myio"
    libraryTarget: "umd"
    filename: 'io.js'
  module:
    rules: [
        test: /\.coffee$/,
        loader: 'coffee-loader'
      ,
        test: /\.js$/,
        loader: 'babel-loader',
        include: [resolve('src'), resolve('test')]
      ,
        test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
        loader: 'url-loader',
        options:
          limit: 10000,
          name: utils.assetsPath('img/[name].[hash:7].[ext]')
      ,
        test: /\.(mp4|webm|ogg|mp3|wav|flac|aac)(\?.*)?$/,
        loader: 'url-loader',
        options:
          limit: 10000,
          name: utils.assetsPath('media/[name].[hash:7].[ext]')
      ,
        test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
        loader: 'url-loader',
        options:
          limit: 10000,
          name: utils.assetsPath('fonts/[name].[hash:7].[ext]')
    ]

module.exports = [clientConfig, serverConfig]
