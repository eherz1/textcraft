Active            = require './active'
CharacterCreation = require './character_creation'
Logger            = require '../../../logger'
Messages          = require '../../../messages'

User              = require '../../../db/models/User'

class Auth
  constructor: ->
    @name = 'Auth'
    @step = 'LOGIN'
  enter: (channel) ->
    channel.socket.write Messages.welcome
    channel.socket.write Messages.login
  exit: (channel) ->
  verify: (callback) ->
    self = @
    query = User.findOne login: @login
      .populate 'character'
    query.exec (err, user) ->
      return callback err if err?
      success = user != null && user.login == self.login && \
        user.password == self.password
      callback null, success, user
  data: (channel, buffer) ->
    switch @step
      when 'LOGIN'
        @login = buffer.toString().trim()
        @step = 'PASSWORD'
        channel.socket.write Messages.password
      when 'PASSWORD'
        @password = buffer.toString().trim()
        self = @
        @verify (err, success, user) ->
          channel.handleError err if err?
          if success
            Logger.info 'User ' + user.login + ' logged in'
            channel.user = user
            if user.character?
              channel.transition new Active(channel)
            else
              channel.transition new CharacterCreation(channel)
          else
            channel.socket.write Messages.badauth
            channel.socket.write Messages.login
            self.step = 'LOGIN'

module.exports = Auth
