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
      this.ship.selectToogle();
    },

    initialize: function(opts){
      console.log( "ShipView.initialize", opts );

      this.ship = opts.ship;
      this.ship.on( "change:selected", this.updateSelected, this );
    },

    updateSelected: function(){
      if( this.ship.get( "selected" ) ){
        this.$el.addClass( "selected" );
      } else {
        this.$el.removeClass( "selected" );
      }
    },

    render: function(){
      console.log( "ShipView.render", this.ship );
      this.$el.html( this.template( this.ship.toJSON() ) );
      return this;
    }
  });
});