$(function(){
  App.Planets = Backbone.Collection.extend({
    model: App.Planet,

    initialize: function() {
      this.on( "change:selected", this.changeSelected );
      this.on( "change:creatingFleet", this.creatingFleet );
    },

    anySelected: function(){
      return this.selected().length > 0;
    },

    selected: function(){
      var result =
        this.filter( function( planet ){
          return planet.get( "selected" );
        });

      return result;
    },

    creatingFleet: function( model, val, opts ){
      this.each( function( e ){
        if( e != model ) {
          e.set( "selectable", val );
        }
      });
    },

    deselectAll: function(){
      this.each( function( e ){
        e.set( "selected", false );
      });
    },

    changeSelected: function( model, val, opts ){
      if( val ){
        App.Game.fleets.deselectAll();

        this.each( function( e ){
          if( e != model && e.get( "selected" ) ) {
            e.set( "selected", false );
          }
        });
      };
    },
  });
});