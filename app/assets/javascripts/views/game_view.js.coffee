class @PP.Views.GameView extends Backbone.View

  events: ->
    'click [data-action=start]'             : 'startGame'
    'click [data-action=finish]'            : 'finishGame'
    'change [data-action=select-player-1]'  : 'selectPlayer1'
    'change [data-action=select-player-2]'  : 'selectPlayer2'
    'click [data-action=register]'          : 'registerGame'
    'click [data-action=cancel]'            : 'initGame'

  initialize: (options) ->
    @$intructions   = @$('[data-item=instructions]')
    @$player1Select = @$('[data-action=select-player-1]')
    @$player2Select = @$('[data-action=select-player-2]')
    @players        = options.properties.players
    @initGame()

  startGame: (event) ->
    event.preventDefault()
    @$('[data-action=start]').hide()
    @$('[data-action=finish]').show()
    @$intructions.text('Stop the game when complete')
    @lockPlayers()

  finishGame: (event) ->
    event.preventDefault()
    @$('[data-action=finish]').hide()
    @$('[data-item=score]').show()
    @$intructions.text('Enter the scores')
    @$('[data-item=score-1]').focus()

  loadPlayers: ($select, omition) ->
    $select.children().remove()
    for player in @players
      unless player[1] is parseInt(omition)
        $select.append("<option value=#{player[1]}>#{player[0]}</option>")

  selectPlayer1: (event) ->
    currentVal = @$player2Select.val()
    @loadPlayers(@$player2Select, @$player1Select.val())
    @$player2Select.val(currentVal)

  selectPlayer2: (event) ->
    currentVal = @$player1Select.val()
    @loadPlayers(@$player1Select, @$player2Select.val())
    @$player1Select.val(currentVal)

  registerGame: ->
    return unless @scoresComplete()
    @$intructions.text('Registered, GG!')
    document.location.href = '/games'

  initGame: ->
    @loadPlayers(@$player1Select, @players[1][1])
    @loadPlayers(@$player2Select, @players[0][1])
    @unlockPlayers()
    @$('[data-action=start]').show()
    @$('[data-action=finish]').hide()
    @$('[data-item=score]').hide()
    @$intructions.text('Select players and start a game!')

  scoresComplete: ->
    # debugger
    @$('[data-item=score-1]').val() isnt '' and @$('[data-item=score-1]').val() isnt ''

  lockPlayers: ->
    @$player1Select.attr('disabled', true)
    @$player2Select.attr('disabled', true)

  unlockPlayers: ->
    @$player1Select.attr('disabled', false)
    @$player2Select.attr('disabled', false)
