$(function(){
  App.CommandUpgrade = Backbone.Model.extend({
    url: function() {
      return App.RootUrl + "/upgrade/" + this.unit.id;
    },

    initialize: function( opts ){
      this.unit = opts.unit;
    }
  });
});