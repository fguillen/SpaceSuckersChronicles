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
      return this.planet.enemyFleets.reduce( function( memo, fleet ) { return memo + fleet.ships.size(); }, 0);
    },

    extraCSSClasses: function(){
      result = "";

      if( this.planet.get( "visible" ) )                  result += "visible";

      return result;
    },
  });
});
