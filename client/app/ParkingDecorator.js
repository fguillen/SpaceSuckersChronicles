$(function(){
  App.ParkingDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.parking = opts.parking;
    },

    toJSON: function(){
      var json =
        _.extend(
          this.parking.toJSON(),
          {
            capacity_percent: this.capacityPercent()
          }
        );

      return json;
    },

    capacityPercent: function(){
      return toPercent( this.parking.get( "ships" ), this.parking.get( "capacity" ) )
    }
  });
});
