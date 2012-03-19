$(function(){
  App.Universe = Backbone.Model.extend({
    url: "http://localhost:4567/universe",

    initialize: function( opts ){
      this.ships    = new App.Ships();
      this.planets  = new App.Planets();
      this.fleets   = new App.Fleets();

      this.interval;

      this.on( "change", this.setup, this );
    },

    synch: function(){
      this.refresh();

      var _self = this;
      this.interval =
        setInterval(function() {
          _self.refresh();
        }, 1000);
    },

    refresh: function(){
      console.log( "Refresh Universe..." );
      this.fetch();
    },

    pause: function(){
      clearInterval( this.interval );
    },

    setup: function(){
      App.Utils.refreshCollection( this.planets,  this.get( "planets" ) );
      App.Utils.refreshCollection( this.fleets,   this.get( "fleets" ) );
      App.Utils.refreshCollection( this.ships,    this.get( "ships" ) );
    },

    sendFleetToPlanet: function( planetDestination ){
      var planetOrigin      = this.planets.creatingFleet()[0];
      var planetDestination = planetDestination;
      var ships             = planetOrigin.ships.selected();

      planetOrigin.ships.remove( ships );

      var ship_ids =
        ships.map(function( ship, index ) {
          return ship.get( "id" )
        });

      console.log( "creatingFleet" );
      this.fleets.create(
        {
          base_id:         planetOrigin.id,
          destination_id:  planetDestination.id,
          ship_ids:        ship_ids
        },
        {
          wait: true
        }
      );
      console.log( "creatingFleet:END" );

      planetOrigin.set( "creatingFleet", false );
    },
  })
});