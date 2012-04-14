$(function(){
  App.ShipView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#ship").html() ),

    events: {
      "click .admin .enrol-in-fleet .pay-button": "enrolInFleet",
      "click .admin .pull-out-of-fleet .pay-button": "pullOutOfFleet"
    },

    enrolInFleet: function(){
      this.ship.enrolInFleet();
    },

    pullOutOfFleet: function(){
      this.ship.pullOutOfFleet();
    },

    initialize: function(opts){
      this.ship = opts.ship;
      this.ship.on( "change" , this.render, this );
      this.ship.on( "s2c:remove:from_planet", this.remove, this );
    },

    render: function(){
      var shipDecorator = new App.ShipDecorator({ ship: this.ship });
      this.$el.html( this.template( shipDecorator.toJSON() ) );

      return this;
    }
  });
});