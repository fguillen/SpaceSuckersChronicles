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
      this.ship.on( "change" , this.renderByChange, this );
      this.ship.on( "s2c:remove:from_planet", this.unlink, this );
    },

    unlink: function(){
      this.ship.off( null, null, this );
      _self = this;
      this.$el.fadeOut( "fast", function(){ _self.remove } )
    },

    renderByChange: function( model, val ){
      console.log( "ShipView.renderByChange", model, val );
      this.render();
    },

    render: function(){
      console.log( "ShipView.render.ship", this.ship.id );

      var shipDecorator = new App.ShipDecorator({ ship: this.ship });
      this.$el.html( this.template( shipDecorator.toJSON() ) );

      return this;
    }
  });
});