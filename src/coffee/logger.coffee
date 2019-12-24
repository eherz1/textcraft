Winston = require 'winston'

Config  = require './config'

Logger = new Winston.Logger(transports: Config.logging.transports)

module.exports = Logger

