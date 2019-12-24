Directions  = require '../../game/directions'
Formatter   = require '../formatter'

Character   = require '../../db/models/character'
Exit        = require '../../db/models/exit'
User        = require '../../db/models/user'

writeToOtherOccupants = (server, character, message, callback) ->
  query = Character.find room: character.room
  query.exec (err, occupants) ->
    return callback err if err?
    for occupant in occupants
      continue if occupant == character
      query = User.find character: occupant
      query.exec (err, users) ->
        return callback err if err?
        for user in users
          channel = server.findChannelByUser user._id
          channel.socket.write message if channel?
    callback null

Move =
  process:  (channel, cob, callback) ->
    user = channel.user
    dir = Directions.get cob.args[0]
    query = Character.findById user.character
    query.exec (err, character) ->
      return callback err if err?
      query = Exit
        .findOne
          source: character.room
          direction: dir
        .populate 'destination'
      query.exec (err, exit) ->
        return callback err if err?
        if exit?
          message = "#{character.firstName} just left to the #{dir}.\n"
          writeToOtherOccupants channel.server, character, message, (err) ->
            return callback err if err?
            character.room = exit.destination
            character.save (err) ->
              return callback err if err?
              console.log 'got here'
              Formatter.writeRoom channel, exit.destination, callback
              message = "#{character.firstName} walks into the room from the #{Directions.reverse(dir)}.\n"
              writeToOtherOccupants channel.server, character, message , (err) ->
                return callback err if err?
                callback null
        else
          channel.socket.write 'There is no exit in that direction!\n'
          callback null

module.exports = Move
