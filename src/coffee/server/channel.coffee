Logger = require '../Logger'

class Channel
  # @param socket The socket this channel owns
  # @param state The initial state object (usually some sort of auth)
  constructor: (@server, @socket, @state) ->
    self = @
    @socket.on 'data', (buffer) -> self.onRead.call self, buffer
    @socket.on 'close', (buffer) -> self.onClose.call self, buffer
    @state.enter this
  onRead: (buffer) -> @state.data this, buffer
  onClose: ->
    Logger.info "User #{@user.login} closed connection"
    @state.close this
  transition: (state) ->
    Logger.debug "User #{@user.login} transitioned: #{@state.name} => #{@state.name}"
    @state.exit this
    @state = state
    @state.enter this
  handleError: (err) ->
    Logger.error "#{@user.login} encountered an error: #{err}"
  close: ->
    # TODO

module.exports = Channel
