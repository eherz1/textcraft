
Character = require '../../db/models/character'
Room      = require '../../db/models/room'
User      = require '../../db/models/user'

Name =
  process: (channel, cob, callback) ->
    name = cob.argstring
    console.log cob.argstring
    unless name?
      channel.socket.write "You must provide a name for the room!\n"
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
            room.name = name
            room.save (err) ->
              return callback err if err?
              channel.socket.write "You touch your magic wand on the ground and it transforms!\n"
              callback null

module.exports = Name
