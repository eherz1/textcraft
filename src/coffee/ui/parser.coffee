
Parser =
  parse: (s) ->
    trimmed = s.trim()
    space = trimmed.indexOf ' '
    cmd = if space == -1 then trimmed else trimmed.substr 0, space
    argstring = if space < trimmed.length then trimmed.substr space + 1 else ''
    args = argstring.split ' '
    object =
      command: cmd
      args: args
      fullstring: s
      argstring: argstring

module.exports = Parser
