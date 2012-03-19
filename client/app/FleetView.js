$(function(){
  App.FleetView = Backbone.View.extend({
    template  : _.template( $('#fleet').html() ),

    attributes: {
      "class": "fleet"
    },

    events: {
      "click": "openPlanetInfo"
    },

    initialize: function(opts){
      this.fleet = opts.fleet;
      this.fleet.on( "remove", this.fadeOut, this );

      this.fleet.on( "change", this.render, this );
      this.fleet.ships.on( "all", this.render, this );
    },

    fadeOut: function(){
      var _self = this;
      this.$el.fadeOut( "slow", function() { _self.remove() } );
    },

    openPlanetInfo: function(){
      App.Navigator.navigate( "planet/" + this.fleet.get( "destination_id" ), {trigger: true} );
    },

    render: function(){
      console.log( "FleetView.render", this.fleet.ships.size() );
      var fleetDecorator = new App.FleetDecorator({ fleet: this.fleet });
      this.$el.html( this.template( fleetDecorator.toJSON() ) );
      return this;
    }
  });
});