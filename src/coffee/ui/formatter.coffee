
Character = require '../db/models/character'
Exit      = require '../db/models/exit'
User      = require '../db/models/user'

Formatter =
  writeRoom: (channel, room, callback) ->
    channel.socket.write room.name + '\n'
    channel.socket.write '    ' + room.description + '\n'
    #query = User
    #  .findById channel.user
    #  .populate 'character'
    #query.exec (err, user) ->
    #  return callback err if err?
    #  query = Character.where room: room
    #  query.exec (err, characters) ->
    #    return callback err if err?
    #    for character, i in characters
    #      if character.id != user.character.id
    #        if i == 0
    #          channel.socket.write 'Also here: '
    #        channel.socket.write character.firstName
    #        channel.socket.write ', ' if i + 1 < characters.length
    #      channel.socket.write '\n' if i > 0
    query = Exit.where source: room
    query.exec (err, exits) ->
      return callback err if err?
      channel.socket.write 'Exits: '
      if exits.length < 1
        channel.socket.write '<NONE>\n'
      else
        for exit, i in exits
          channel.socket.write exit.direction
          channel.socket.write ', ' if i + 1 < exits.length
        channel.socket.write "\n"
      callback null

module.exports = Formatter

