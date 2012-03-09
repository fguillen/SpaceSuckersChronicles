$(function(){
  App.MapView = Backbone.View.extend({
    el: "#map",

    initialize: function(opts){
      this.planets = opts.planets;
      this.planets.bind( 'reset', this.addAllPlanets, this );
      this.planets.bind( 'add', this.addOnePlanet, this );

      this.fleets = opts.fleets;
      this.fleets.bind( 'reset', this.addAllFleets, this );
      this.fleets.bind( 'add', this.addOneFleet, this );

      this.addAllPlanets();
      this.addAllFleets();
    },

    addOnePlanet: function( model ) {
      var view = new App.PlanetView({ planet: model });
      this.$el.append( view.render().el );
    },

    addOneFleet: function( model ) {
      var view = new App.FleetView({ fleet: model });
      this.$el.append( view.render().el );
    },

    addAllPlanets: function() {
      this.planets.each( $.proxy( this.addOnePlanet, this ) );
    },

    addAllFleets: function() {
      this.fleets.each( $.proxy( this.addOneFleet, this ) );
    },
  });
});