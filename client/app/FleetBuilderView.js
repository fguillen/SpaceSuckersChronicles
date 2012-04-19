$(function(){
  App.FleetBuilderView = Backbone.View.extend({
    template  : _.template( $('#fleet-builder-template').html() ),

    attributes: {
      id: "fleet-builder"
    },

    events: {
      "click #send-fleet": "sendFleet",
      "click #cancel-fleet": "backToPlanet",
    },

    initialize: function( opts ){
      this.fleetBuilder  = opts.fleetBuilder;
      this.ships         = this.fleetBuilder.planet.ships;
      this.shipsView     = new App.ShipsView({ ships: this.ships });
      this.planetsView   = new App.PlanetsSmallView();
    },

    render: function(){
      console.log( "FleetBuilderView.render" );

      var fleetBuilderDecorator = new App.FleetBuilderDecorator({ fleetBuilder: this.fleetBuilder });
      this.$el.html( this.template( fleetBuilderDecorator.toJSON() ) );
      this.$el.find( "#navy ul" ).append( this.shipsView.render().el );
      this.$el.find( "#planets ul" ).append( this.planetsView.render().el );

      var fleetBuilderAdminView = new App.FleetBuilderAdminView({ fleetBuilder: this.fleetBuilder });
      this.$el.find( "#admin" ).append( fleetBuilderAdminView.render().el );

      return this;
    },

    show: function(){
      this.$el.fadeIn();
    },

    backToPlanet: function(){
      App.Navigator.navigate( "planet/" + this.fleetBuilder.planet.id, {trigger: true} );
    },

    sendFleet: function(){
      console.log( "FleetBuilderView.sendFleet XXX" );
      var _self = this;
      this.fleetBuilder.save({}, {
        wait: true,
        success: function(){ console.log( "fleetBuilder.save.SUCCESS" ); _self.backToPlanet() },
        error: function(){ console.log( "fleetBuilder.save.ERROR" ); }
      });
    },

    unlink: function(){
      this.shipsView.unlink();
      this.planetsView.unlink();
      this.fleetBuilder.unlink();
      this.$el.empty();
    },

  });
});