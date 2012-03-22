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

    anyCreatingFleet: function(){
      return this.creatingFleet().length > 0;
    },

    changeCreatingFleet: function( model, val, opts ){
      if( val ){
        this.each( function( e ){
          if( e == model ) {
            e.set( "possibleFleetDestination", false );
          } else {
            e.set( "possibleFleetDestination", true );
            if( e.get( "creatingFleet" ) ) e.set( "creatingFleet", false );
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