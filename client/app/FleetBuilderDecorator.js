$(function(){
  App.FleetBuilderDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.fleetBuilder = opts.fleetBuilder;
    },

    toJSON: function(){
      var json =
        _.extend(
          this.fleetBuilder.toJSON(),
          {
            extra_css_classes: this.extraCSSClasses(),
          }
        );

      return json;
    },

    extraCSSClasses: function(){
      result = "";

      if( this.fleetBuilder.get( "ready_to_go" ) )    result += " ready-to-go";

      return result;
    },

  });
});
