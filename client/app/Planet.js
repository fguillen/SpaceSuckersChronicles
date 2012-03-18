$(function(){
  App.Planet = Backbone.Model.extend({
    initialize: function(){
      this.set( "selected", false );
      this.ships = new App.Ships( App.Game.ships.get_by_ids( this.get( "ship_ids" ) ) );
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