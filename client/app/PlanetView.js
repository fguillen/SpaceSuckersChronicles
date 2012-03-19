$(function(){
  App.PlanetView = Backbone.View.extend({
    template  : _.template( $('#planet').html() ),

    attributes: {
      "class": "planet"
    },

    events: {
      "click": "click"
    },

    initialize: function(opts){
      this.planet = opts.planet;
      this.planet.ships.on( "add remove", this.render, this );
      this.planet.on( "change:creatingFleet", this.render, this );
      this.planet.on( "change:possibleFleetDestination", this.render, this );
    },

    click: function(){
      if( this.planet.get( "possibleFleetDestination" ) ){
        this.sendFleet();
      } else {
        this.openPlanetInfo();
      }
    },

    openPlanetInfo: function(){
      console.log( "PlanetView.openPlanetInfo" );
      App.Navigator.navigate( "planet/" + this.planet.id, {trigger: true} );
    },

    sendFleet: function(){
      console.log( "send fleet here" );
      App.Game.sendFleetToPlanet( this.planet );
    },

    render: function(){

      console.log( "PlanetView.creatingFleet", this.planet.id, this.planet.get( "creatingFleet" ) );
      console.log( "PlanetView.possibleFleetDestination", this.planet.id, this.planet.get( "possibleFleetDestination" ) );

      var planetDecorator = new App.PlanetDecorator({ planet: this.planet });
      this.$el.html( this.template( planetDecorator.toJSON() ) );
      return this;
    }
  });
});