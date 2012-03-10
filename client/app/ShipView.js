$(function(){
  App.ShipView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#planet-ship").html() ),

    attributes: {
      "class": "ship"
    },

    events: {
      "click": "select"
    },

    select: function(){
      console.log( "ShipView.select" );
      this.ship.selectToggle();
    },

    initialize: function(opts){
      console.log( "ShipView.initialize" );
      this.ship = opts.ship;
      this.ship.on( "change:selected", this.updateSelected, this );
      this.ship.on( "s2c:remove:from_planet", this.remove, this );
    },

    updateSelected: function(){
      this.$el.toggleClass( "selected", this.ship.get( "selected" ) );
    },

    render: function(){
      this.$el.html( this.template( this.ship.toJSON() ) );
      return this;
    }
  });
});