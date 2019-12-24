Mongoose = require 'mongoose'

unless 'Exit' in Mongoose.modelNames()
	schema = new Mongoose.Schema
		type: String
		direction: String
		source: { type: Mongoose.Schema.Types.ObjectId, ref: 'Room' }
		destination: { type: Mongoose.Schema.Types.ObjectId, ref: 'Room' }
	Mongoose.model 'Exit', schema

module.exports = Mongoose.model 'Exit'
