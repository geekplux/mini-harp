createMiniHarp = (path) ->
  connect = require("connect")
  app = connect()
  argv = require("minimist")(process.argv.slice(2))
  port = argv.port or 4000
  serveStatic = require("serve-static")
  jadePreprocessor = require("../lib/processor/jade")
  lessPreprocessor = require("../lib/processor/less")

  app
  .use((req,res,next) ->
    if (req.url is "current-time")
      res.end((new Date()).toISOString() + "\n")
    else if (req.url is "/")
      req.url = "/index.html"
      next()
    else
      next()
  )
  .use(serveStatic(path))
  .use(jadePreprocessor(path))
  .use(lessPreprocessor(path))
  .listen(port)

  console.log "Starting mini-harp on http://localhost:" + port

  return app

module.exports = createMiniHarp;