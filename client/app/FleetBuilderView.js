$(function(){
  App.FleetBuilderView = Backbone.View.extend({
    el: $("#fleet-builder-wrapper"),

    template  : _.template( $('#fleet-builder').html() ),

    initialize: function( opts ){
      this.fleetBuilder  = opts.fleetBuilder;
      this.ships         = this.fleetBuilder.planet.ships;
      this.shipsView     = new App.ShipsView({ ships: this.ships });
      this.planetsView   = new App.PlanetsSmallView();

      this.markAllShips( this.ships );
    },

    markAllShips: function(){
      this.ships.each( function( ship ){
        ship.set( "creatingFleet", true );
      });
    },

    unmarkAllShips: function(){
      this.ships.each( function( ship ){
        ship.set( "creatingFleet", false );
      });
    },

    remove: function(){
      this.unmarkAllShips();
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