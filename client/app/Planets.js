$(function(){
  App.Planets = Backbone.Collection.extend({
    model: App.Planet,

    initialize: function() {
      this.on( "change:visible", this.changeVisible );
      this.on( "change:fleet_destination", this.changeFleetDestination );
      this.on( "change:fleet_origin", this.changeFleetOrigin );
    },

    changeVisible: function( model, val ){
      if( val ){
        this.each( function( e ){
          if( e != model ) {
            e.set( "visible", false );
          }
        });
      }
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