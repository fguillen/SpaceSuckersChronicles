$(function(){
  App.UniverseView = Backbone.View.extend({
    initialize: function( opts ){
      this.universe = opts.universe;

      this.planetsView =
        new App.PlanetsView({
          planets: this.universe.planets,
        });

      this.fleetsView =
        new App.FleetsView({
          fleets: this.universe.fleets,
        });

      this.noticesView =
        new App.NoticesView({
          notices: this.universe.notices,
        });

      this.planetInfos = new App.PlanetInfosView({
        planets: this.universe.planets
      });
    },

  });
});