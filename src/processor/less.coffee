makeLess = (root) ->

  return (req, res, next) ->
    fs = require("fs")
    path = require("path")
    less = require("less")

    if path.extname(req.url) isnt ".css"
      next()
      return
    
    file = path.join(root, req.url)
    if fs.existsSync(file)
      res.end(file)
      return

    else
      file = path.join(root, path.basename(req.url, ".css") + ".less")

      if fs.existsSync(file)
        fs.readFile(file, {encoding: "utf8"}, (err, data) ->
          if err
            throw err
            next()

          else
            less.render(data, (e, css) ->
              if e
                throw e
                next()

              else
                res.setHeader("Content-Length", css.length)
                res.setHeader("Content-Type", "text/css; charset=UTF-8")
                res.end(css)

              return
            )
          return
        )

      else
        res.statusCode = 404
        res.end()

      return

module.exports = makeLess