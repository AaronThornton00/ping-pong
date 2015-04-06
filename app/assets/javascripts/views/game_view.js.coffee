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
    @$intructions.text('Game on, click finish once game is complete')
    @startAt = Date.now()
    @lockPlayers()

  finishGame: (event) ->
    event.preventDefault()
    @$('[data-action=finish]').hide()
    @$('[data-item=score]').show()
    @$intructions.text('Enter the scores')
    @endAt = Date.now()
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
    $.ajax
      url: "/games"
      type: 'POST'
      data:
        game:
          start_at: @startAt
          end_at: @endAt
          player_1: { id: @$player1Select.val(), score: @$('[data-item=score-1]').val() }
          player_2: { id: @$player2Select.val(), score: @$('[data-item=score-2]').val() }
      success: (response, status, xhr) =>
        @$intructions.text('Registered, GG!')
        document.location.href = '/games'
      error: ->
        console.log 'error'


  initGame: ->
    @loadPlayers(@$player1Select, @players[1][1])
    @loadPlayers(@$player2Select, @players[0][1])
    @unlockPlayers()
    @$('[data-action=start]').show()
    @$('[data-action=finish]').hide()
    @$('[data-item=score]').hide()
    @$intructions.text('Select players and start a game!')

  scoresComplete: ->
    notADrawer = @$('[data-item=score-1]').val() isnt @$('[data-item=score-2]').val()
    complete = @$('[data-item=score-1]').val() isnt '' and @$('[data-item=score-1]').val() isnt ''
    @$intructions.text('Someones got to win!') unless notADrawer
    @$intructions.text('Both scores must be entered...') unless complete
    complete and notADrawer

  lockPlayers: ->
    @$player1Select.attr('disabled', true)
    @$player2Select.attr('disabled', true)

  unlockPlayers: ->
    @$player1Select.attr('disabled', false)
    @$player2Select.attr('disabled', false)
