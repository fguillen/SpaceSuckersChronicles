$(function(){
  App.Mine = Backbone.Model.extend({
    initialize: function(opts){
      console.log( "Mine.initialize", this );
    },

    upgrade: function(){
      new App.CommandUpgrade({ unit: this }).save();
    }
  });
});