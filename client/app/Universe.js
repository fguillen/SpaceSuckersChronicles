$(function(){
  App.Universe = Backbone.Model.extend({
    url: "http://localhost:4567/universe",

    initialize: function( opts ){
      this.ships = new App.Ships();
      this.planets = new App.Planets();
      this.fleets = new App.Fleets();

      this.interval;

      this.on( "change", this.setup, this );
    },

    synch: function(){
      console.log( "Universe.synch" );
      this.fetch();

      _self = this;
      this.interval =
        setInterval(function() {
          _self.fetch();
        }, 1000);
    },

    pause: function(){
      clearInterval( this.interval );
    },

    setup: function(){
      App.Utils.refreshCollection( this.ships, this.get( "ships" ) );
      App.Utils.refreshCollection( this.planets, this.get( "planets" ) );
      App.Utils.refreshCollection( this.fleets, this.get( "fleets" ) );



      // this.get( "planets" ).each( function( dataJSON ) {
      //   var model = this.planets.get( dataJSON.id );
      //   model.set( dataJSON )
      // });

      // this.get( "fleets" ).each( function( dataJSON ) {
      //   var model = this.fleets.get( dataJSON.id );
      //   model.set( dataJSON )
      // });
    },

    sendFleetToPlanet: function( planetDestination ){
      var planetOrigin      = this.planets.selected()[0];
      var planetDestination = planetDestination;
      var ships             = planetOrigin.ships.selected();

      console.log( "Universe.sendFleetToPlanet.ships", ships );

      planetOrigin.ships.remove( ships );


      var ship_ids =
        ships.map(function( ship, index ) {
          return ship.get( "id" )
        });

      this.fleets.create({
        planet_id:        planetOrigin.id,
        traveling_to:     planetDestination.id,
        process_percent:  0,
        ship_ids:         ship_ids
      });

      planetOrigin.set( "creatingFleet", false );
    },
  })
});