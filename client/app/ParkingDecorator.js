$(function(){
  App.ParkingDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.parking = opts.parking;
      this.job = this.parking.get( "job" ) || {};
    },

    toJSON: function(){
      var json =
        _.extend(
          this.parking.toJSON(),
          {
            capacity_percent: this.capacityPercent(),
            extra_css_classes: this.extraCSSClasses(),
            upgrade_percent: this.upgradePercent(),
          }
        );

      return json;
    },

    capacityPercent: function(){
      return toPercent( this.parking.get( "ships" ), this.parking.get( "capacity" ) )
    },

    extraCSSClasses: function(){
      result = "";

      if( this.job.type == "upgrade" ) result += "upgrading";

      return result;
    },

    upgradePercent: function(){
      if( this.job.type == "upgrade" ){
        return toPercent( ( this.job.ticks_total - this.job.ticks_remain ), this.job.ticks_total );
      } else {
        return 100;
      }
    }
  });
});
