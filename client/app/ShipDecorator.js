$(function(){
  App.ShipDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.ship = opts.ship;
    },

    toJSON: function(){
      var json =
        _.extend(
          this.ship.toJSON(),
          {
            life_percent: this.ship.get( "life" ),
            extra_css_classes: this.extraCssClasses(),
          }
        );

      return json
    },

    extraCssClasses: function(){
      result = "";

      if( this.ship.get( "creating_fleet" ) ) result += " creating-fleet";
      if( this.ship.get( "enroled_in_fleet" ) ) result += " enroled-in-fleet";

      return result;
    },
  });
});
