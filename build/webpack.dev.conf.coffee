'use strict'
utils = require('./utils')
webpack = require('webpack')
config = require('../config')
merge = require('webpack-merge')
baseWebpackConfig = require('./webpack.base.conf.coffee')
HtmlWebpackPlugin = require('html-webpack-plugin')
FriendlyErrorsPlugin = require('friendly-errors-webpack-plugin')
portfinder = require('portfinder')

HOST = process.env.HOST
PORT = process.env.PORT && Number(process.env.PORT)

## add hot-reload related code to entry chunks
Object.keys(baseWebpackConfig[0].entry).forEach((name)->
  baseWebpackConfig[0].entry[name] = ['./build/dev-client'].concat(baseWebpackConfig[0].entry[name])
)

## devWebpackConfig = merge(baseWebpackConfig, {
clientConfig = merge(baseWebpackConfig[0],
  module:
    rules: utils.styleLoaders({ sourceMap: config.dev.cssSourceMap, usePostCSS: true })
  ## cheap-module-eval-source-map is faster for development
  devtool: config.dev.devtool

  ## ## these devServer options should be customized in /config/index.js
  ## devServer: {
  ##   clientLogLevel: 'warning'
  ##   historyApiFallback: true
  ##   hot: true
  ##   compress: true
  ##   host: HOST || config.dev.host
  ##   port: PORT || config.dev.port
  ##   open: config.dev.autoOpenBrowser
  ##   overlay: config.dev.errorOverlay
  ##     ? { warnings: false, errors: true }
  ##     : false
  ##   publicPath: config.dev.assetsPublicPath
  ##   proxy: config.dev.proxyTable
  ##   quiet: true, ## necessary for FriendlyErrorsPlugin
  ##   watchOptions: {
  ##     poll: config.dev.poll
  ##   }
  ## }
  plugins: [
    new webpack.DefinePlugin(
      'process.env': require('../config/dev.env')
    )
    new webpack.HotModuleReplacementPlugin()
    new webpack.NamedModulesPlugin() ## HMR shows correct file names in console on update.
    new webpack.NoEmitOnErrorsPlugin()
    ## https://github.com/ampedandwired/html-webpack-plugin
    new HtmlWebpackPlugin(
      filename: 'index.html'
      template: 'index.html'
      inject: true
    )
    new FriendlyErrorsPlugin(
      compilationSuccessInfo:
        messages: ['Your application is running here: http://localhost:8080']
      onErrors: if config.dev.notifyOnErrors then utils.createNotifierCallback() else undefined
    )
  ]
)

devWebpackConfig = [clientConfig, baseWebpackConfig[1]]

module.exports = () ->
  new Promise (resolve, reject) ->
    portfinder.basePort = process.env.PORT or config.dev.port
    portfinder.getPort (err, port) ->
      if err
        reject(err)
      else
        console.log(devWebpackConfig)
        ## publish the new Port, necessary for e2e tests
        process.env.PORT = port
        # ## add port to devServer config
        # devWebpackConfig[0].devServer.port = port

        ## Add FriendlyErrorsPlugin
        devWebpackConfig[0].plugins.push(new FriendlyErrorsPlugin({
          compilationSuccessInfo: {
            messages: ["Your application is running here: http://localhost:#{port}"]
          }
          onErrors: if config.dev.notifyOnErrors then utils.createNotifierCallback() else undefined
        }))

        resolve(devWebpackConfig)
