
UnknownCommand =
  process: (channel, cob, callback) ->
    channel.socket.write "Command not recognized.\n"
    callback null

module.exports = UnknownCommand
