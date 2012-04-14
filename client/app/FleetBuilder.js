$(function(){
  App.FleetBuilder = Backbone.Model.extend({
    url: App.RootUrl + "/fleets",

    initialize: function( opts ){
      this.planet = opts.planet;
      this.ships = new App.Ships();

      this.destination;
    },
  });
});