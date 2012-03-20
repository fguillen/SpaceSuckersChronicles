$(function(){
  App.Silo = Backbone.Model.extend({
    initialize: function(opts){
      console.log( "Silo.initialize", this );
    }
  });
});