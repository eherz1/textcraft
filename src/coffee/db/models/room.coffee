Mongoose = require 'mongoose'

Item = require './item'

unless 'Room' in Mongoose.modelNames()
	schema = new Mongoose.Schema
		name: String
		description: String
		coordinates:
			x: Number
			y: Number
			z: Number
		items: [ Item.schema ]
	Mongoose.model 'Room', schema

module.exports = Mongoose.model 'Room'
