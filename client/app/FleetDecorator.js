$(function(){
  App.FleetDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.fleet = opts.fleet
    },

    toJSON: function(){
      var json =
        _.extend(
          this.fleet.toJSON(),
          {
            units_count: this.fleet.ships.size(),
            travel_percent: this.travelPercent()
          }
        );

      return json
    },

    travelPercent: function(){
      var job = this.fleet.get( "job" );

      console.log( "travelPercent", job );

      if( job.type == "travel" ){
        return toPercent( ( job.ticks_total - job.ticks_remain ), job.ticks_total );
      } else {
        return 100;
      }
    }
  });
});
