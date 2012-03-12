$(function(){
  App.ShipView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#ship").html() ),

    attributes: {
      "class": "ship"
    },

    events: {
      "click": "select"
    },

    select: function(){
      this.ship.selectToggle();
    },

    initialize: function(opts){
      this.ship = opts.ship;
      this.ship.on( "change:selected", this.updateSelected, this );
      this.ship.on( "change" , this.refresh, this );
      this.ship.on( "s2c:remove:from_planet", this.remove, this );
    },

    refresh: function(){
      this.$el.html( "" );
      this.render();
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