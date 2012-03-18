$(function(){
  App.FleetDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.fleet = opts.fleet;
      this.job = this.fleet.get( "job" ) || {};
    },

    toJSON: function(){
      var json =
        _.extend(
          this.fleet.toJSON(),
          {
            id:             ( this.fleet.id || "?" ),
            units_count:    this.fleet.ships.size(),
            travel_percent: this.travelPercent(),
            display_travel: this.displayTravel(),
            display_combat: this.displayCombat(),
          }
        );

      return json;
    },

    displayTravel: function(){
      if( this.job.type == "travel" ){
        return "block";
      } else {
        return "none";
      }
    },

    displayCombat: function(){
      if( this.job.type == "combat" ){
        return "block";
      } else {
        return "none";
      }
    },

    travelPercent: function(){
      if( this.job.type == "travel" ){
        return toPercent( ( this.job.ticks_total - this.job.ticks_remain ), this.job.ticks_total );
      } else {
        return 100;
      }
    }
  });
});
