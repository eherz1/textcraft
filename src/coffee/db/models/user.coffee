Mongoose = require 'mongoose'

Character = require './character'

unless 'User' in Mongoose.modelNames()
	schema = new Mongoose.Schema
		login: String
		password: String
		character: { type: Mongoose.Schema.Types.ObjectId, ref: 'Character' }
	Mongoose.model 'User', schema

module.exports = Mongoose.model 'User'
