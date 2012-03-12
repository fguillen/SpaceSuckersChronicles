$(function(){
  App.Fleet = Backbone.Model.extend({
    url: "http://localhost:4567/fleets",

    initialize: function(){
      this.set( "selected", false );

      this.set( "origin", App.Game.planets.get( this.get( "planet_id" ) ) );
      this.set( "destination", App.Game.planets.get( this.get( "traveling_to" ) ) );

      this.ships = new App.Ships( App.Game.ships.get_by_ids( this.get( "ship_ids" ) ) );

      this.on( "change:process_percent", this.updatePosition, this );
      this.on( "change:ship_ids", this.updateShips, this );

      this.updatePosition();
    },

    updatePosition: function(){
      if( this.get( "status" ) == "traveling" ) {
        var coordinates = fleetCoordinates( this, App.Game.planets );
        this.set( "position", [ coordinates["x"], coordinates["y"] ] );
      } else {
        var planetX = this.get( "destination" ).get( "position" )[0];
        var planetY = this.get( "destination" ).get( "position" )[1];
        this.set( "position", [ planetX, planetY ] );
      }
    },

    updateShips: function(){
      var ship_ids = this.get( "ship_ids" );
      var _self = this;

      // add
      _(ship_ids).each( function( ship_id ) {
        var ship = _self.ships.get( ship_id );
        if( !ship ) {
          var ship_to_add = App.Game.ships.get( ship_id );
          _self.ships.add( ship_to_add );
        }
      });

      // remove
      var actual_ship_ids = this.ships.pluck( "id" );
      var ship_ids_to_remove = _( actual_ship_ids ).difference( ship_ids )

      _( ship_ids_to_remove ).each( function( ship_id_to_remove ){
        _self.ships.remove( ship_id_to_remove );
      });
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