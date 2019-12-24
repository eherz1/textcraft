Mongoose = require 'mongoose'

Item     = require './item'
Room     = require './room'

unless 'Character' in Mongoose.modelNames()
  schema = new Mongoose.Schema
    firstName: String
    lastName: String
    strength: Number
    agility: Number
    intellect: Number
    wisdom: Number
    vitality: Number
    hp: Number
    hpmax: Number
    mp: Number
    mpmax: Number
    experience: Number
    tnl: Number
    room: { type: Mongoose.Schema.Types.ObjectId, ref: 'Room' }
    items: [{ type: Mongoose.Schema.Types.ObjectId, ref: 'Room' }]
  Mongoose.model 'Character', schema

module.exports = Mongoose.model 'Character'

