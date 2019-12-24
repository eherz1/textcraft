Db        = require './db'
Logger    = require './logger'
Server    = require './server'

Logger.info 'Opening DB connection'
Db.openConnection()

Logger.info 'Starting server'
Server.run()
