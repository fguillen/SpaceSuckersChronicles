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
            units_enemy_count: this.unitsEnemyCount(),
            extra_css_classes: this.extraCSSClasses(),
          }
        );

      return json
    },

    unitsEnemyCount: function() {
      console.log( "PlanetDecorator.unitsEnemyCount", this.planet.id );
      var result =
        this.planet.enemyFleets.reduce(
          function( memo, fleet ) {
            return memo + fleet.ships.size();
          },
          0
        );

      console.log( "PlanetDecorator.unitsEnemyCount.result", result );

      return result;
    },

    extraCSSClasses: function(){
      result = "";

      if( this.planet.get( "fleet_destination" ) )  result += " fleet-destination";
      if( this.planet.get( "fleet_origin" ) )       result += " fleet-origin";

      return result;
    },
  });
});
