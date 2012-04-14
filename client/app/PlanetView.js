$(function(){
  App.PlanetView = Backbone.View.extend({
    template  : _.template( $('#planet').html() ),

    attributes: {
      "class": "planet"
    },

    events: {
      "click #see-details": "seeDetails"
    },

    initialize: function(opts){
      this.planet = opts.planet;
      this.planet.ships.on( "add remove", this.render, this );
      this.planet.enemyFleets.on( "all", this.render, this );
    },

    seeDetails: function(){
      console.log( "see details" );
      App.Navigator.navigate( "planet/" + this.planet.id, {trigger: true} );
    },

    sendFleet: function(){
      App.Game.sendFleetToPlanet( this.planet );
    },

    render: function(){
      var planetDecorator = new App.PlanetDecorator({ planet: this.planet });
      this.$el.html( this.template( planetDecorator.toJSON() ) );
      return this;
    }
  });
});