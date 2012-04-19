App.RootUrl = "http://localhost:4567";

$(function(){
  console.log( "Loading Game..." );

  App.Game = new App.Universe();

  App.Screen = new App.ScreenView({ universe: App.Game });
  $("#wrapper").html( App.Screen.render().el );

  App.Navigator = new App.Router();

  // App.Game.synch();
  // App.Game.fetch({ success: function(){ Backbone.history.start() } });
  Backbone.history.start();
});