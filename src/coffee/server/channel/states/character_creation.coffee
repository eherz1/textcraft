Mongoose          = require 'mongoose'

Active            = require './Active'
Config            = require '../../../Config'
Logger            = require '../../../Logger'

Character         = require '../../../db/models/Character'

class CharacterCreation
  constructor: ->
    @name = 'CharacterCreation'
    @state = 'FIRSTNAME'
  enter: (channel) ->
    channel.socket.write "\nI see this is your first time on this realm.\n\n"
    channel.socket.write "What shall be your first name? "
  exit: (channel) ->
  data: (channel, buffer) ->
    switch @state
      when 'FIRSTNAME'
        @firstName = buffer.toString().trim()
        channel.socket.write "What shall be your last name? "
        @state = 'LASTNAME'
      when 'LASTNAME'
        @lastName = buffer.toString().trim()
        query = Mongoose.model 'Room'
          .findOne _id: Config.game.origin
        query.exec (err, origin) ->
          return channel.handleError err if err?
          character = new Character
            firstName: @firstName
            lastName: @lastName
            room: origin
          character.save (err) ->
            return channel.handleError err if err?
            channel.user.character = character.id
            channel.user.save (err, user) ->
              return channel.handleError err if err?
              channel.transition new Active()

module.exports = CharacterCreation
