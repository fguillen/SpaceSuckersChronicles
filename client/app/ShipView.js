$(function(){
  App.ShipView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#ship").html() ),

    events: {
      "click": "select"
    },

    select: function(){
      this.ship.selectToggle();
    },

    initialize: function(opts){
      this.ship = opts.ship;
      this.ship.on( "change" , this.render, this );
      this.ship.on( "s2c:remove:from_planet", this.remove, this );
    },

    render: function(){
      var shipDecorator = new App.ShipDecorator({ ship: this.ship });
      this.$el.html( this.template( shipDecorator.toJSON() ) );
      this.$el.find( "div.ship" ).toggleClass( "selected", this.ship.get( "selected" ) );
      return this;
    }
  });
});