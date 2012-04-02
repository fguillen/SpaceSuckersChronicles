$(function(){
  App.SiloDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.silo = opts.silo;
      this.job = this.silo.get( "job" ) || {};
    },

    toJSON: function(){
      var json =
        _.extend(
          this.silo.toJSON(),
          {
            capacity_percent: this.capacityPercent(),
            extra_css_classes: this.extraCSSClasses(),
            upgrade_percent: this.upgradePercent(),
          }
        );

      return json
    },

    capacityPercent: function(){
      return toPercent( this.silo.get( "stuff" ), this.silo.get( "capacity" ) )
    },

    extraCSSClasses: function(){
      result = "";

      if( this.job.name == "upgrade" ) result += "upgrading";

      return result;
    },

    upgradePercent: function(){
      if( this.job.name == "upgrade" ){
        return toPercent( ( this.job.ticks_total - this.job.ticks_remain ), this.job.ticks_total );
      } else {
        return 100;
      }
    }
  });
});
