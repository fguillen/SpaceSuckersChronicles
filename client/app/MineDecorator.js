$(function(){
  App.MineDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.mine = opts.mine;
      this.job = this.mine.get( "job" ) || {};
    },

    toJSON: function(){
      var json =
        _.extend(
          this.mine.toJSON(),
          {
            extra_css_classes: this.extraCSSClasses(),
            upgrade_percent: this.upgradePercent(),

          }
        );

      return json;
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
