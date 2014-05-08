makeJade = (root) ->

  return (req, res, next) ->
    fs = require("fs")
    path = require("path")
    jade = require("jade")

    if path.extname(req.url) isnt ".html"
      next()
      return

    file = path.join(root, req.url)
    if fs.existsSync(file)
      res.end(file)
      return

    else
      file = path.join(root, path.basename(req.url, ".html") + ".jade")

      if fs.existsSync(file)
        fs.readFile(file, {encoding: "utf8"}, (err, data) ->
          if err
            throw err
            next()

          else
            jade.render(data, (err, html) ->
              if err
                throw err
                next()

              else
                res.setHeader("Content-Length", html.length)
                res.setHeader("Content-Type", "text/html; charset=UTF-8")
                res.end(html)

              return
            )
          return
        )

      else
        res.statusCode = 404
        res.end()

      return

module.exports = makeJade