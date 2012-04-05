$(function(){
  App.Planets = Backbone.Collection.extend({
    model: App.Planet,

    initialize: function() {
      this.on( "change:creatingFleet", this.changeCreatingFleet );
    },

    creatingFleet: function(){
      var result =
        this.filter( function( planet ){
          return planet.get( "creatingFleet" );
        });

      return result;
    },

    changeCreatingFleet: function( model, val, opts ){
      if( val ){
        this.each( function( e ){
          if( e == model ) {
            e.set( "possibleFleetDestination", false );
          } else {
            e.set( "possibleFleetDestination", true );
            e.set( "creatingFleet", false );
          }
        });
      } else {
        this.each( function( e ){
          e.set( "possibleFleetDestination", false );
        });
      }
    },
  });
});