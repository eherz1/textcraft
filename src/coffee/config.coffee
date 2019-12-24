Winston = require 'winston'

Config =
  server:
    port: 23232
  db:
    host: 'localhost'
    port: 27017
    db: 'textcraft'
    options: {}
  prompt: '[HP=%h/%y]: '
  game:
    origin: '54bde612fd398309c1847f48'
  logging:
    transports: [
      new Winston.transports.Console
        level: 'debug'
        colorize: true
        timestamp: true
        json: false
      new Winston.transports.File
        level: 'debug'
        colorize: false
        timestamp: true
        json: false
        tailable: true
        filename: __dirname + '/../../log/textcraft.log'
        maxsize: 10 * 1024 * 1024
    ]

module.exports = Config
