Mongoose      = require 'mongoose'

{randInt}     = require '../../util/general'

unless 'Class' in Mongoose.modelNames()
  schema = new Mongoose.Schema
    name: String
    strengthGrowthMin: Number
    strengthGrowthMax: Number
    agilityGrowthMin: Number
    agilityGrowthMax: Number
    intellectGrowthMin: Number
    intellectGrowthMax: Number
    wisdomGrowthMin: Number
    wisdomGrowthMax: Number
    vitalityGrowthMin: Number
    vitalityGrowthMax: Number
  	skillsPerLevel: [
  		level: Number, skillId: mongoose.Schema.Types.ObjectId
  	]

  schema.methods.levelUp = (character, callback) ->
    strmod = randInt this.strengthGrowthMin, this.strengthGrowthMax
    agimod = randInt this.agilityGrowthMin, this.agilityGrowthMax
    intmod = randInt this.intellectGrowthMin, this.intellectGrowthMax
    wismod = randInt this.wisdomGrowthMin, this.wisdomGrowthMax
    vitmod = randInt this.vitalityGrowthMin, this.vitalityGrowthMax
    character.strength += strmod
    character.agility += agimod
    character.intellect += intmod
    character.wisdom += wismod
    character.vitality += vitmod
    character.save callback

  Mongoose.model 'Class', schema

module.exports = mongoose.model 'Class'

