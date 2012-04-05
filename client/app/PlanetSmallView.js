$(function(){
  App.PlanetSmallView = Backbone.View.extend({
    tagName: 'li',
    template  : _.template( $('#planet-small').html() ),

    attributes: {
      "class": "planet-small"
    },

    events: {
      "click": "click"
    },

    initialize: function(opts){
      this.planet = opts.planet;
    },

    click: function(){
      console.log( "small planet click" );
    },

    render: function(){
      this.$el.html( this.template( this.planet.toJSON() ) );
      return this;
    }
  });
});