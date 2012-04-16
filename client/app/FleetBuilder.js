$(function(){
  App.FleetBuilder = Backbone.Model.extend({
    url: App.RootUrl + "/fleets",

    initialize: function( opts ){
      this.planet             = opts.planet;
      this.planetsDestination = opts.planetsDestination;

      this.ships = new App.Ships();

      this.planetsDestination.on( "change:fleet_destination" , this.selectDestination, this );
      this.planet.ships.on( "change:enroled_in_fleet" , this.selectShip, this );

      this.set( "base_id",      this.planet.id );
      this.set( "target_id",    undefined );
      this.set( "ready_to_go",  this.readyToGo() );
      this.set( "ships_count",   0 );
      this.set( "price",        0 );

      this.markAllPlanetShips();
      this.markPlanet();

    },

    planetDestination: function(){
      console.log( "FleetBuilder.planetDestination.find", this.planetsDestination );
      var result =
        this.planetsDestination.find(
          function( planet ) {
            console.log( "planet.fleet_destination", planet.get( "fleet_destination" ) );
            return planet.get( "fleet_destination" );
          }
        );

      console.log( "FleetBuilder.planetDestination.result", result );

      return result;
    },

    unlink: function(){
      console.log( "FleetBuilder.unlink" );

      console.log( "FleetBuilder.planet.fleet_origin 1", this.planet.get( "fleet_origin" ) );

      this.unmarkAllPlanetShips();
      this.unmarkPlanet();
      this.unmarkPlanetDestination();


      console.log( "FleetBuilder.planet.fleet_origin 2", this.planet.get( "fleet_origin" ) );

      this.planetsDestination.off(null, null, this);;
      this.planet.ships.off(null, null, this);;
    },

    readyToGo: function(){
      if(
        this.get( "target_id" ) &&
        this.get( "ships_count" ) > 0
      ) {
        return true;
      } else {
        return false;
      }
    },

    selectDestination: function( model, val ){
      if( val ) this.set( "target_id", model.id );
      this.set( "ready_to_go", this.readyToGo() );
    },

    selectShip: function( model, val ){
      if( val ){
        this.ships.add( model )
      } else {
        this.ships.remove( model )
      }

      this.set( "ships_count", this.ships.size() );
      this.set( "price", ( this.ships.size() * 10 ) );
      this.set( "ready_to_go", this.readyToGo() );

      console.log( "FleetBuilder.selectShip", this.get( "ships_count" ) );
    },

    markAllPlanetShips: function(){
      this.planet.ships.each( function( ship ){
        ship.set( "creating_fleet", true );
      });
    },

    unmarkAllPlanetShips: function(){
      console.log( "FleetBuilder.unmarkAllPlanetShips" );
      this.planet.ships.each( function( ship ){
        console.log( "FleetBuilder.unmarkAllPlanetShips.ship.creating_fleet 1", ship.get( "creating_fleet" ) );
        ship.set( "creating_fleet", false );
        ship.pullOutOfFleet();
        console.log( "FleetBuilder.unmarkAllPlanetShips.ship.creating_fleet 2", ship.get( "creating_fleet" ) );
      });
    },

    markPlanet: function(){
      this.planet.set( "fleet_origin", true );
    },

    unmarkPlanet: function(){
      this.planet.set( "fleet_origin", false );
    },

    unmarkPlanetDestination: function(){
      console.log( "FleetBuilder.unmarkPlanetDestination", this.planetDestination() );
      if( this.planetDestination() ) this.planetDestination().set( "fleet_destination", false );
    },
  });
});