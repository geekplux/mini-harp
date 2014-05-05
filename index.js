var createMiniHarp = function() {
  var connect = require('connect'),
      argv = require("minimist")(process.argv.slice(2)),
      app = connect(),
      port = argv.port || 4000;

  console.log("Starting mini-harp on http://localhost:" + port);
  app.listen(port);
}

module.exports = createMiniHarp;