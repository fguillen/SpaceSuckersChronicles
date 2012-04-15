App.RootUrl = "http://localhost:4567";

$(function(){
  App.Game = new App.Universe();
  new App.UniverseView({ universe: App.Game });
  new App.ControlsView({ universe: App.Game });
  App.Navigator = new App.Router();

  // App.Game.synch();
  App.Game.fetch({ success: function(){ Backbone.history.start() } });
});