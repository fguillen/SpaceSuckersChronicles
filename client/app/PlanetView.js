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
      this.planet.enemyFleets.on( "all", this.renderByEnemyFleets, this );
    },

    seeDetails: function(){
      console.log( "see details" );
      App.Navigator.navigate( "planet/" + this.planet.id, {trigger: true} );
    },

    sendFleet: function(){
      App.Game.sendFleetToPlanet( this.planet );
    },

    renderByEnemyFleets: function(){
      console.log( "PlanetView.renderByEnemyFleets", this.planet.id );

      this.render();
    },

    render: function(){
      console.log( "PlanetView.render", this.planet.id );

      var planetDecorator = new App.PlanetDecorator({ planet: this.planet });
      this.$el.html( this.template( planetDecorator.toJSON() ) );
      return this;
    }
  });
});