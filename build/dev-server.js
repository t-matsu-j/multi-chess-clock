require('./check-versions')()
var config = require('../config')
if (!process.env.NODE_ENV) process.env.NODE_ENV = JSON.parse(config.dev.env.NODE_ENV)
var path = require('path')
var express = require('express')
var webpack = require('webpack')
var proxyMiddleware = require('http-proxy-middleware')

var coffee = require('coffeescript/register')
var webpackConfig = require('./webpack.dev.conf.coffee')

// var srvIOConfig = require('./webpack.srv.conf.coffee')
// default port where dev server listens for incoming traffic
var port = process.env.PORT || config.dev.port
// Define HTTP proxies to your custom API backend
// https://github.com/chimurai/http-proxy-middleware
var proxyTable = config.dev.proxyTable

var app = express()
var clientConfig, clientCompiler, serverCompiler
// call run on the compiler along with the callback
Promise.resolve()
.then(
  webpackConfig
)
.then( (configs) => {
  return new Promise( (resolve, reject) =>{
    debugger
    clientConfig = configs[0]
    var compiler = webpack(configs)
    clientCompiler = compiler.compilers[0]
    serverCompiler = compiler.compilers[1]
    resolve()
  })
})
.then( () => {
  //serverCompiler
  return new Promise( (resolve, reject) => {
    serverCompiler.run( (err, stats) => {
      if(err) reject(err)
      resolve()
    })
  })
})
.then( () => {
  //clientCompiler
  return new Promise( (resolve, reject) => {
    var devMiddleware = require('webpack-dev-middleware')(clientCompiler, {
      publicPath: clientConfig.output.publicPath,
      stats: {
        colors: true,
        chunks: false
      }
    })

    var hotMiddleware = require('webpack-hot-middleware')(clientCompiler)
    // force page reload when html-webpack-plugin template changes
    clientCompiler.plugin('compilation', function (compilation) {
      compilation.plugin('html-webpack-plugin-after-emit', function (data, cb) {
        hotMiddleware.publish({ action: 'reload' })
        cb()
      })
    })

    // proxy api requests
    Object.keys(proxyTable).forEach(function (context) {
      var options = proxyTable[context]
      if (typeof options === 'string') {
        options = { target: options }
      }
      app.use(proxyMiddleware(context, options))
    })

    // handle fallback for HTML5 history API
    app.use(require('connect-history-api-fallback')())

    // serve webpack bundle output
    app.use(devMiddleware)

    // enable hot-reload and state-preserving
    // compilation error display
    app.use(hotMiddleware)

    // serve pure static assets
    var staticPath = path.posix.join(config.dev.assetsPublicPath, config.dev.assetsSubDirectory)
    app.use(staticPath, express.static('./static'))

    var server = app.listen(port, function (err) {
      if (err) {
        reject(err)
        return
      }

      var uri = 'http://localhost:' + port
      console.log('Listening at ' + uri + '\n')

    })
debugger
    var io = require('../dist/io.js')
    io(server)
    resolve()
  })
})
.catch((err)=>{
  console.log(err)
})
