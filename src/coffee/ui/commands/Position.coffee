
Character = require '../../db/models/character'
User      = require '../../db/models/user'

Position =
	process: (channel, cob, callback) ->
		query = User.findById channel.user
		query.exec (err, user) ->
			return callback err if err?
			query = Character
				.findById user.character
				.populate 'room'
			query.exec (err, character) ->
				return callback err if err?
				channel.socket.write "<" + character.room.coordinates.x + ", " + \
					character.room.coordinates.y + ", " + \
					character.room.coordinates.z + ">\n"
				callback null

module.exports = Position
