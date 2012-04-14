$(function(){
  App.FleetBuilderView = Backbone.View.extend({
    el: $("#fleet-builder-wrapper"),

    template  : _.template( $('#fleet-builder').html() ),

    initialize: function( opts ){
      this.fleetBuilder  = opts.fleetBuilder;
      this.shipsView     = new App.ShipsView({ ships: this.fleetBuilder.planet.ships });
      this.planetsView   = new App.PlanetsSmallView();
    },

    render: function(){
      console.log( "FleetBuilderView.render" );

      var fleetBuilderDecorator = new App.FleetBuilderDecorator({ fleetBuilder: this.fleetBuilder });
      this.$el.html( this.template( fleetBuilderDecorator.toJSON() ) );
      this.$el.find( "#navy ul" ).append( this.shipsView.render().el );
      this.$el.find( "#planets ul" ).append( this.planetsView.render().el );

      return this;
    }
  });
});