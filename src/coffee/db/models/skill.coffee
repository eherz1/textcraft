Mongoose = require 'mongoose'

unless 'Skill' in Mongoose.modelNames()
  schema = new Mongoose.Schema
    name: String
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
    room: Mongoose.Schema.Types.ObjectId
  Mongoose.model 'Skill', schema

module.exports = Mongoose.model 'Skill'
