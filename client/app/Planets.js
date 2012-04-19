$(function(){
  App.Planets = Backbone.Collection.extend({
    model: App.Planet,

    initialize: function() {
      this.on( "change:fleet_destination", this.changeFleetDestination );
      this.on( "change:fleet_origin", this.changeFleetOrigin );
    },

    changeFleetDestination: function( model, val ){
      if( val ){
        this.each( function( e ){
          if( e != model ) {
            e.set( "fleet_destination", false );
          }
        });
      }
    },

    changeFleetOrigin: function( model, val ){
      if( val ){
        this.each( function( e ){
          if( e != model ) {
            e.set( "fleet_origin", false );
          }
        });
      }
    }


  });
});