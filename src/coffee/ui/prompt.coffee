
Prompt =

  SYMBOL_MAP:
    'h': (context) -> context.currentHP()
    'y': (context) -> context.totalHP()
    'm': (context) -> context.currentMP()
    'j': (context) -> context.maxMana()

  evaluate: (token, context) ->
    f = Prompt.SYMBOL_MAP[token]
    f.call null, context if f?

  format: (s, context) ->
    result = ''
    token = false
    for char, index in s.split ''
      switch (char)
        when '%'
          if token
            throw "Unexpected token % at index #{i}"
          else
            token = true
        else
          if token
            result += Prompt.evaluate char, context
            token = false
          else
            result += char
    result

module.exports = Prompt
