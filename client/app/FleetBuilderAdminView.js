$(function(){
  App.FleetBuilderAdminView = Backbone.View.extend({
    template: _.template( $("#fleet-builder-admin").html() ),

    events: {
      "click .pay-button": "createFleet",
    },

    createFleet: function(){
      console.log( "FleetBuilderView.createFleet" );
    },

    initialize: function(opts){
      this.fleetBuilder = opts.fleetBuilder;
      this.fleetBuilder.on( "change", this.render, this );
    },

    render: function(){
      console.log( "FleetBuilderAdminView.render" );
      var fleetBuilderDecorator = new App.FleetBuilderDecorator({ fleetBuilder: this.fleetBuilder });
      this.$el.html( this.template( fleetBuilderDecorator.toJSON() ) );

      return this;
    }
  });
});