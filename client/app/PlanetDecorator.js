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
            creating_fleet_class: this.creatingFleetClass(),
            possible_fleet_destination_class: this.possibleFleetDestinationClass()
          }
        );

      return json
    },

    unitsEnemyCount: function() {
      return this.planet.enemyFleets.reduce( function( memo, fleet ) { return memo + fleet.ships.size(); }, 0);
    },

    creatingFleetClass: function(){
      if( this.planet.get( "creatingFleet" ) ) {
        return "creating-fleet";
      } else {
        return "no-creating-fleet";
      }
    },

    possibleFleetDestinationClass: function(){
      if( this.planet.get( "possibleFleetDestination" ) ) {
        return "possible-fleet-destination";
      } else {
        return "no-possible-fleet-destination";
      }
    }
  });
});
