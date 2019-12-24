
Commands =
  map:
    '':             require './commands/look'
    'l':            require './commands/look'
    'look':         require './commands/look'
    'touch':        require './commands/touch'
    'dig':          require './commands/dig'
    'name':         require './commands/name'
    'describe':     require './commands/describe'
    'n':            require './commands/move'
    'e':            require './commands/move'
    's':            require './commands/move'
    'w':            require './commands/move'
    'nw':           require './commands/move'
    'ne':           require './commands/move'
    'se':           require './commands/move'
    'sw':           require './commands/move'
    'u':            require './commands/move'
    'd':            require './commands/move'
    'pos':          require './commands/position'
    'position':     require './commands/position'
  get: (command) -> Commands.map[command]

module.exports = Commands
