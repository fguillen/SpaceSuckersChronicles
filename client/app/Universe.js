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
  })
});