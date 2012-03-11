$(function(){
  App.Planet = Backbone.Model.extend({
    initialize: function(){
      this.set( "selected", false );
      this.ships = new App.Ships( App.Game.ships.get_by_ids( this.get( "ship_ids" ) ) );

      this.on( "change:ship_ids", this.updateShips, this );
    },

    updateShips: function(){
      console.log( "Planet.updateShips", this.id );

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

      console.log( "actual_ship_ids", actual_ship_ids );
      console.log( "ship_ids_to_remove", ship_ids_to_remove );

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