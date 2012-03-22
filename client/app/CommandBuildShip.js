$(function(){
  App.CommandBuildShip = Backbone.Model.extend({
    url: function() {
      return App.RootUrl + "/build_ship/" + this.hangar.id;
    },

    initialize: function( opts ){
      this.hangar = opts.hangar;
    }
  });
});