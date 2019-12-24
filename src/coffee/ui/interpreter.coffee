Commands          = require './commands'
Parser            = require './parser'
UnknownCommand    = require './commands/unknown_command'

Interpreter =
  process: (channel, string, callback) ->
    cob = Parser.parse string
    handler = Commands.get cob.command
    handler = UnknownCommand unless handler?
    handler.process channel, cob, callback

module.exports = Interpreter
