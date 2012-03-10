$(function(){
  App.Fleet = Backbone.Model.extend({
    url: "http://localhost:4567/fleets",

    initialize: function(){
      this.set( "selected", false );

      this.set( "ships", new App.Ships( App.Game.ships.get_by_ids( this.get( "ship_ids" ) ) ) );
      this.set( "origin", App.Game.planets.get( this.get( "planet_id" ) ) );
      this.set( "destination", App.Game.planets.get( this.get( "traveling_to" ) ) );

      this.on( "change:process_percent", this.updatePosition, this );

      this.updatePosition();
    },

    updatePosition: function(){
      var coordinates = fleetCoordinates( this, App.Game.planets );
      this.set( "position", [ coordinates["x"], coordinates["y"] ] );
    },

    selectToggle: function(){
      if( this.get( "selected" ) ){
        this.set( "selected", false );
      } else {
        this.set( "selected", true );
      }
    },
  });
});