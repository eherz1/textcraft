Config        = require '../../../config'
Interpreter   = require '../../../ui/interpreter'
Messages      = require '../../../messages'
Prompt        = require '../../../ui/prompt'
TokenContext  = require '../../../ui/token_context'

class Active
  constructor: ->
    @name = 'Active'
  writePrompt: (channel) =>
    ctx = new TokenContext channel.user
    channel.socket.write Prompt.format(Config.prompt, ctx)
  enter: (channel) =>
    self = @
    channel.socket.write Messages.entrance(channel.user.login)
    self.writePrompt channel
  exit: (channel) =>
  data: (channel, buffer) =>
    self = @
    string = buffer.toString()
    Interpreter.process channel, string, -> self.writePrompt channel
  close: (channel, buffer) =>
    #channel.socket.write Messages.hardclose

module.exports = Active
