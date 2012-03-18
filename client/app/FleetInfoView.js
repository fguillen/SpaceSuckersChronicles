$(function(){
  App.FleetInfoView = Backbone.View.extend({
    tagName: "li",
    template  : _.template( $('#fleet-info').html() ),

    initialize: function(opts){
      this.fleet = opts.fleet;
      this.fleet.on( "change", this.render, this );
      this.fleet.on( "remove", this.fadeOut, this );

      this.shipsView = new App.ShipsView({ ships: this.fleet.ships });
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