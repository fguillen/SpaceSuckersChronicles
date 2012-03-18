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
            life_percent: this.ship.get( "life" )
          }
        );

      return json
    }
  });
});
