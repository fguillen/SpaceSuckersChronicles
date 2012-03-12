$(function(){
  App.Fleets = Backbone.Collection.extend({
    model: App.Fleet,

    initialize: function() {
      this.on( "change:selected", this.changeSelected );
    },

    deselectAll: function(){
      this.each( function( e ){
        e.set( "selected", false );
      });
    },

    anySelected: function(){
      var result =
        this.any( function( fleet ){
          var result = fleet.get( "selected" );
          return result;
        });

      return result;
    },

    changeSelected: function( model, val, opts ){
      if( val ){
        App.Game.planets.deselectAll();

        this.each( function( e ){
          if( e != model && e.get( "selected" ) ) {
            e.set( "selected", false );
          }
        });
      };
    },
  });
});