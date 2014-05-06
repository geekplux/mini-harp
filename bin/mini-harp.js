#!/usr/bin/env node
var miniHarp = require( '../lib/createMiniHarp.js' ),
    argv = require("minimist")(process.argv.slice(2)),
    root = process.cwd(); // current directory
    path = argv._[0] || root;

miniHarp(path);