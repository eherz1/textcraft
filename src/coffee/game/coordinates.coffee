
Coordinates =

  ZERO:
    x: 0
    y: 0
    z: 0

  get: (x, y, z) ->
    x: x,
    y: y,
    z: z

  equals: (c1, c2) -> c1.x == c2.x && c1.y == c2.y && c1.z == c2.z

  add: (c1, c2) ->
    x: c1.x + c2.x
    y: c1.y + c2.y
    z: c1.z + c2.z

  subtract: (c1, c2) ->
    x: c1.x - c2.x
    y: c1.y - c2.y
    z: c1.z - c2.z

  DIRECTIONS:
    north:
      x: 0
      y: 1
      z: 0
    east:
      x: 1
      y: 0
      z: 0
    south:
      x: 0
      y: -1
      z: 0
    west:
      x: -1
      y: 0
      z: 0
    northwest:
      x: -1
      y: 1
      z: 0
    northeast:
      x: 1
      y: 1
      z: 0
    southeast:
      x: 1
      y: -1
      z: 0
    southwest:
      x: -1
      y: -1
      z: 0
    up:
      x: 0
      y: 0
      z: 1
    down:
      x: 0
      y: 0
      z: -1

  direction: (c) -> Coordinates.DIRECTIONS[c]

module.exports = Coordinates
