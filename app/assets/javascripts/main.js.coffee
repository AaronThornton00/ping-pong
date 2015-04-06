PP = @PP =
  Settings: {}
  Views: {}
  Controllers: {}

PP.App = class App
  constructor: (controller, action, properties) ->
    jQuery =>
      if PP.Controllers[controller]?
        PP.runtime.controller = new PP.Controllers[controller]()
        PP.runtime.controller[action](properties) if PP.runtime.controller[action]?
