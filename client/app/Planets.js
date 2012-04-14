$(function(){
  App.Planets = Backbone.Collection.extend({
    model: App.Planet,

    initialize: function() {
      this.on( "change:visible", this.changeVisible );
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


  });
});