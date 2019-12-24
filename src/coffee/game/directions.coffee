
Directions =

  NAMES: [
    'north'
    'south'
    'east'
    'west'
    'northeast'
    'southeast'
    'northwest'
    'southwest'
    'up'
    'down'
  ]

  SHORTHAND: [
    'n'
    's'
    'e'
    'w'
    'ne'
    'se'
    'nw'
    'sw'
    'u'
    'd'
  ]

  get: (s) ->
    for d, i in Directions.SHORTHAND
      if s == Directions.SHORTHAND[i]
        return Directions.NAMES[i]
    r = new RegExp '^' + s + '$'
    for d, i in Directions.NAMES
      if Directions.NAMES[i].match r
        return Directions.NAMES[i]
    null

  REVERSES:
    'north': 'south'
    'south': 'north'
    'east': 'west'
    'west': 'east'
    'northeast': 'southwest'
    'southwest': 'northeast'
    'southeast': 'northwest'
    'northwest': 'southeast'
    'up': 'down'
    'down': 'up'

  reverse: (s) -> Directions.REVERSES[s]

module.exports = Directions
