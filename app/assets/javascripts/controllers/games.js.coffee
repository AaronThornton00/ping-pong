class @PP.Controllers.Games

  new: (properties) ->
    PP.runtime.gameView = new PP.Views.GameView
      el: $('[data-item=game]')
      properties: properties
