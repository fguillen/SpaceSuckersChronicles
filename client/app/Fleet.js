$(function(){
  App.Fleet = Backbone.Model.extend({
    url: "http://localhost:4567/fleets",

    initialize: function(){
      this.on( "change:destination_id", this.updateDestination, this );

      this.ships = new App.Ships( App.Game.ships.get_by_ids( this.get( "ship_ids" ) ) );

      this.updateDestination();
    },

    updateDestination: function(){
      console.log( "Fleet.updateDestination", this, this.id, this.get( "destination_id" ) );
      var destination = App.Game.planets.get( this.get( "destination_id" ) )
      destination.enemyFleets.add( this );
    }
  });
});