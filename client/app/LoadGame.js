$(function(){
  App.Game = new App.Universe();
  new App.UniverseView({ universe: App.Game });
  new App.ControlsView({ universe: App.Game });

  App.Game.synch();
});