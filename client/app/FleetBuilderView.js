$(function(){
  App.FleetBuilderView = Backbone.View.extend({
    template  : _.template( $('#fleet-builder').html() ),

    initialize: function( opts ){
      this.planet     = opts.planet;
      this.shipsView  = new App.ShipsView({ ships: this.planet.ships });
      this.planetsView
    },

    fadeOut: function(){
      var _self = this;
      this.$el.animate( { right: -400 }, 500, function(){ _self.remove(); } );
    },

    render: function(){
      var fleetDecorator = new App.FleetDecorator({ fleet: this.fleet });
      this.$el.html( this.template( fleetDecorator.toJSON() ) );
      this.$el.find( "ul" ).append( this.shipsView.render().el );

      return this;
    }
  });
});