$(function(){
  App.PlanetSmallView = Backbone.View.extend({
    tagName: 'li',
    template  : _.template( $('#planet-small').html() ),

    attributes: {
      "class": "planet-small"
    },

    events: {
      "click .admin #choose-destination": "chooseAsDestination"
    },

    initialize: function(opts){
      this.planet = opts.planet;
      this.planet.on( "change" , this.render, this );
    },

    chooseAsDestination: function(){
      console.log( "PlanetSmallView.chooseAsDestination" );
      this.planet.set( "fleet_destination", true );
    },

    render: function(){
      var planetDecorator = new App.PlanetDecorator({ planet: this.planet });
      this.$el.html( this.template( planetDecorator.toJSON() ) );
      return this;
    },
  });
});