Directions    = require '../../game/directions'
Formatter     = require '../formatter'
Logger        = require '../../logger'

Character     = require '../../db/models/character'
Exit          = require '../../db/models/exit'
Room          = require '../../db/models/room'
User          = require '../../db/models/user'

Look =
  process: (channel, cob, callback) ->
    dir = Directions.get cob.args[0]
    query = User.findById channel.user
    query.exec (err, user) ->
      return callback err if err?
      query = Character.findById user.character
      query.exec (err, character) ->
        return callback err if err?
        if dir?
          query = Exit
            .findOne
              source: character.room
              direction: dir
            .populate 'destination'
          query.exec (err, exit) ->
            return callback err if err?
            if exit?
              Formatter.writeRoom channel, exit.destination, callback
            else
              channel.socket.write 'There is no exit in that direction!\n'
              callback null
        else
          query = Room.findById character.room
          query.exec (err, room) ->
            return callback err if err?
            Formatter.writeRoom channel, room, callback

module.exports = Look
