$(function(){
  App.Ship = Backbone.Model.extend({
    initialize: function(){
      this.set( "selected", false );
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