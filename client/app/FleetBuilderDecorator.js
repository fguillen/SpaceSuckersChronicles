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
            base_id: this.fleetBuilder.planet.id,
            destination_id: "unknown",
          }
        );

      return json;
    },

  });
});
