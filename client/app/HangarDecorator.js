$(function(){
  App.HangarDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.hangar = opts.hangar;
      this.job = this.hangar.get( "job" ) || {};
    },

    toJSON: function(){
      var json =
        _.extend(
          this.hangar.toJSON(),
          {
            extra_css_classes: this.extraCSSClasses(),
            upgrade_percent: this.upgradePercent(),
            build_percent: this.buildPercent()
          }
        );

      return json;
    },

    extraCSSClasses: function(){
      result = "";

      if( this.job.type == "upgrade" ) result += "upgrading";
      if( this.job.type == "build_ship" ) result += "building";

      return result;
    },

    upgradePercent: function(){
      if( this.job.type == "upgrade" ){
        return toPercent( ( this.job.ticks_total - this.job.ticks_remain ), this.job.ticks_total );
      } else {
        return 100;
      }
    },

    buildPercent: function(){
      if( this.job.type == "build_ship" ){
        return toPercent( ( this.job.ticks_total - this.job.ticks_remain ), this.job.ticks_total );
      } else {
        return 100;
      }
    }
  });
});
