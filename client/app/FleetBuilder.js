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

    remove: function(){
      this.unmarkAllPlanetShips();
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
      this.planet.ships.each( function( ship ){
        ship.set( "creating_fleet", false );
      });
    },

    markPlanet: function(){
      this.planet.set( "fleet_origin", true );
    }
  });
});