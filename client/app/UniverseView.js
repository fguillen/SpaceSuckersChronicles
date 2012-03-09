$(function(){
  App.UniverseView = Backbone.View.extend({
    initialize: function( opts ){
      this.universe = opts.universe;

      this.map = new App.MapView({
        planets: this.universe.planets,
        fleets: this.universe.fleets,
      });

      this.infoPanel = new App.InfoPanelView({
        planets: this.universe.planets,
        fleets: this.universe.fleets,
      });
    },

  });
});