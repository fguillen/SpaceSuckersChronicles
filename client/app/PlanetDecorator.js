$(function(){
  App.PlanetDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.planet = opts.planet
    },

    toJSON: function(){
      var json =
        _.extend(
          this.planet.toJSON(),
          {
            units_count: this.planet.ships.size(),
            units_enemy_count: 0,
          }
        );

      return json
    }
  });
});
