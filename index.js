var createMiniHarp = function() {
  var connect = require('connect'),
      argv = require("minimist")(process.argv.slice(2)),
      app = connect(),
      port = argv.port || 4000;

  app.use(function(req,res,next){
    var url = req.url.split("/");
    if (url[1] == "current-time" && url[2] === undefined)
      res.end((new Date()).toISOString()+"\n");
    else
      next();
    }).listen(port);

  console.log("Starting mini-harp on http://localhost:" + port);
}

module.exports = createMiniHarp;