createMiniHarp = (path) ->
  connect = require("connect")
  app = connect()
  argv = require("minimist")(process.argv.slice(2))
  port = argv.port || 4000
  serveStatic = require('serve-static')

  app
  .use((req,res,next) ->
    url = req.url.split("/")
    if (url[1] == "current-time" && url[2] == undefined)
      res.end((new Date()).toISOString()+"\n")
    else
      next()
    )
  .use(serveStatic(path))
  .listen(port)

  console.log "Starting mini-harp on http://localhost:" + port

  return

module.exports = createMiniHarp;