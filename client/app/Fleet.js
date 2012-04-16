$(function(){
  App.Fleet = Backbone.Model.extend({
    url: App.RootUrl + "/fleets",

    initialize: function(){
      this.ships = new App.Ships();

      var destination = App.Game.planets.get( this.get( "target_id" ) )
      destination.enemyFleets.add( this );
    },
  });
});