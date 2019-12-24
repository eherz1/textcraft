Mongoose      = require 'mongoose'
Util          = require 'util'

Config        = require './config'

Db =

  buildUrl: -> Util.format 'mongodb://%s:%s/%s', \
    Config.db.host, \
    Config.db.port, \
    Config.db.db

  openConnection: -> Mongoose.connect Db.buildUrl()

module.exports = Db

