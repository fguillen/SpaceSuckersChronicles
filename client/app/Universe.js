$(function(){
  App.Universe = Backbone.Model.extend({
    url: App.RootUrl + "/universe",

    initialize: function( opts ){
      this.ships    = new App.Ships();
      this.planets  = new App.Planets();
      this.fleets   = new App.Fleets();
      this.notices  = new App.Notices();

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
      App.Utils.refreshCollection( this.notices,  this.get( "events" ) );
    },

    createFleet: function( planet ){
      console.log( "Universe.createFleet", planet );

      var fleetBuilder      = new App.FleetBuilder({ planet: planet, planetsDestination: this.planets });
      var fleetBuilderView  = new App.FleetBuilderView({ fleetBuilder: fleetBuilder });

      fleetBuilderView.render();
      fleetBuilderView.show();
    },

    sendFleetToPlanet: function( planetDestination ){
      var planetOrigin      = this.planets.creating_fleet()[0];
      var planetDestination = planetDestination;
      var ships             = planetOrigin.ships.selected();

      planetOrigin.ships.remove( ships );

      var ship_ids =
        ships.map(function( ship, index ) {
          ship.set( "selected", false );
          return ship.get( "id" )
        });

      this.fleets.create({
          base_id:         planetOrigin.id,
          destination_id:  planetDestination.id,
          ship_ids:        ship_ids
        },
        { wait: true }
      );

      planetOrigin.set( "creating_fleet", false );
    },
  })
});