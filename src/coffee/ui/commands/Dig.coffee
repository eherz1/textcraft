Async           = require 'async'

Coordinates     = require '../../game/coordinates'
Directions      = require '../../game/directions'
Logger          = require '../../logger'

Character       = require '../../db/models/character'
Exit            = require '../../db/models/exit'
Room            = require '../../db/models/room'
User            = require '../../db/models/user'

Dig =
  process: (channel, cob, callback) ->
    to = Directions.get cob.args[0]
    unless to?
      channel.socket.write "You must specify a valid direction to dig in!\n"
      callback null
    else
      query = User.findById channel.user
      query.exec (err, user) ->
        return callback err if err?
        query = Character
          .findById user.character
          .populate 'room'
        query.exec (err, character) ->
          return callback err if err?
          query = Exit
            .findOne
              source: character.room
              direction: to
          query.exec (err, exit) ->
            return callback err if err?
            if exit?
              channel.socket.write "There is nothing to dig in that direction!\n"
              callback null
            else
              coordinates = Coordinates.add character.room.coordinates, \
                Coordinates.direction(to)
              query = Room
                .findOne
                  'coordinates.x': coordinates.x
                  'coordinates.y': coordinates.y
                  'coordinates.z': coordinates.z
              query.exec (err, room) ->
                return callback err if err?
                if room?
                  # Existing room, simply supply new exits
                  outgoing = new Exit
                    type: 'exit'
                    direction: to
                    source: character.room
                    destination: room
                  incoming = new Exit
                    type: 'exit'
                    direction: Directions.reverse to
                    source: room
                    destination: character.room
                  Async.parallel [
                    (callback) -> outgoing.save callback
                    (callback) -> incoming.save callback
                  ], (err) ->
                    return callback err if err?
                    channel.socket.write "You dig into an existing room at #{coordinates.x}, #{coordinates.y}, #{coordinates.z}\n"
                    callback null
                else
                  # Need to create a new room
                  room = new Room
                    name: "New Room #{coordinates.x}, #{coordinates.y}, #{coordinates.z}"
                    description: "A freshly dug room."
                    coordinates: coordinates
                  room.save (err) ->
                    return callback err if err?
                    outgoing = new Exit
                      type: 'exit'
                      direction: to
                      source: character.room
                      destination: room
                    incoming = new Exit
                      type: 'exit'
                      direction: Directions.reverse to
                      source: room
                      destination: character.room
                    Async.parallel [
                      (callback) -> outgoing.save callback
                      (callback) -> incoming.save callback
                    ], (err) ->
                      return callback err if err?
                      channel.socket.write "You dig out a new room at #{coordinates.x}, #{coordinates.y}, #{coordinates.z}.\n"
                      callback null

module.exports = Dig
