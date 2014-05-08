createMiniHarp = (root) ->
  connect = require("connect")
  app = connect()
  argv = require("minimist")(process.argv.slice(2))
  port = argv.port or 4000
  serveStatic = require("serve-static")
  jadePreprocessor = require("../lib/processor/jade")
  lessPreprocessor = require("../lib/processor/less")
  path = require("path")

  app
  .use((req,res,next) ->
    if req.url is "current-time"
      res.end((new Date()).toISOString() + "\n")
    else if req.url is "/"
      req.url = "/index.html"
      next()
    else if path.extname(req.url) is ".jade" or path.extname(req.url) is ".less"
      res.statusCode = 404
      res.end()
    else
      next()
      
    return
  )
  .use(serveStatic(root))
  .use(jadePreprocessor(root))
  .use(lessPreprocessor(root))
  .listen(port)

  console.log "Starting mini-harp on http://localhost:" + port

  return app

module.exports = createMiniHarp