Net       = require 'net'

Auth      = require './server/channel/states/auth'
Channel   = require './server/channel'
Config    = require './config'
Logger    = require './logger'

Server =
  run: ->
    @channels = []
    self = @
    onConnect = (socket) ->
      Logger.info 'New connection from ' + socket.remoteAddress
      channel = new Channel self, socket, new Auth()
      self.channels.push channel
    @server = Net.createServer onConnect
    @server.listen Config.server.port, ->
      Logger.info "Server started on 127.0.0.1:#{Config.server.port}"
  findChannelByUser: (user) ->
    for channel in @channels
      if channel.user == user
        return channel
    null

module.exports = Server
