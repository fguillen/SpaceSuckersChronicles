$(function(){
  App.FleetView = Backbone.View.extend({
    template  : _.template( $('#fleet').html() ),

    attributes: {
      "class": "fleet"
    },

    events: {
      "click": "select"
    },

    select: function(){
      this.fleet.selectToggle();
    },

    initialize: function(opts){
      this.fleet = opts.fleet;
      this.fleet.on( "change:selected", this.updateSelected, this );
      this.fleet.on( "remove", this.fadeOut, this );

      this.fleet.ships.on( "add remove", this.render, this );

      this.updateAttributes();
    },

    fadeOut: function(){
      var _self = this;
      this.$el.fadeOut( "slow", function() { _self.remove() } );
    },

    updateAttributes: function(){
      this.updateSelected();
    },

    updateSelected: function(){
      if( this.fleet.get( "selected" ) ){
        this.$el.addClass( "selected" );
      } else {
        this.$el.removeClass( "selected" );
      }
    },

    render: function(){
      var fleetDecorator = new App.FleetDecorator({ fleet: this.fleet });
      this.$el.html( this.template( fleetDecorator.toJSON() ) );
      return this;
    }
  });
});