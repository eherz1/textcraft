Character = require '../../db/models/character'
Room      = require '../../db/models/room'
User      = require '../../db/models/user'

Describe =
  process: (channel, cob, callback) ->
    description = cob.argstring
    unless description?
      channel.socket.write "You must provide a description for the room!\n"
      callback null
    else
      query = User.findById channel.user
      query.exec (err, user) ->
        return callback err if err?
        query = Character.findById user.character
        query.exec (err, character) ->
          return callback err if err?
          query = Room.findById character.room
          query.exec (err, room) ->
            return callback err if err?
            room.description = description
            room.save (err) ->
              return callback err if err?
              channel.socket.write "You wave your magic wand and the room transforms!\n"
              callback null

module.exports = Describe
