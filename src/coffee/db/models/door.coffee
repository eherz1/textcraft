Mongoose = require 'mongoose'

Room     = require './room'

unless 'Door' in Mongoose.modelNames()
	schema = new Mongoose.Schema
		type: String
		direction: String
		source: { type: Mongoose.Schema.Types.ObjectId, ref: 'Room' }
		destination: { type: Mongoose.Schema.Types.ObjectId, ref: 'Room' }
	Mongoose.model 'Door', schema

module.exports = Mongoose.model 'Door'
