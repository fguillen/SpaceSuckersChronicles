$(function(){
  App.FleetBuilderView = Backbone.View.extend({
    el: $("#fleet-builder-wrapper"),

    template  : _.template( $('#fleet-builder').html() ),

    events: {
      "click #cancel-fleet": "cancelFleet",
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

    cancelFleet: function(){
      var _self = this;
      this.$el.fadeOut( "fast", function(){
        _self.unlink();
      });
    },

    unlink: function(){
      this.shipsView.unlink();
      this.planetsView.unlink();
      this.fleetBuilder.unlink();
      this.$el.empty();
    }
  });
});