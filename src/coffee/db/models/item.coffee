Mongoose = require 'mongoose'

unless 'Item' in Mongoose.modelNames()
	schema = new Mongoose.Schema
		name: String
		description: String
	Mongoose.model 'Item', schema

module.exports = Mongoose.model 'Item'
