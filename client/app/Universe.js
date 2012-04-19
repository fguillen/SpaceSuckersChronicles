$(function(){
  App.Universe = Backbone.Model.extend({
    url: App.RootUrl + "/universe",

    initialize: function( opts ){
      this.ships    = new App.Ships();
      this.planets  = new App.Planets();
      this.fleets   = new App.Fleets();
      this.notices  = new App.Notices();

      this.interval;

      this.actualStep = 1;

      this.actualView;

      this.on( "change", this.setup, this );
    },

    replaceActualView: function( view ){
      if( this.actuaView ) this.actualView.unlink();
      this.actualView = view;
    },

    synch: function(){
      this.refresh();

      var _self = this;
      this.interval =
        setInterval(
          function() { _self.refresh(); },
          1000
        );
    },

    refresh: function(){
      console.log( "Refresh Universe..." );
      // if( this.actualStep == 1 ) {
      //   this.set( data1 );
      //   this.actualStep = 2;
      // } else {
      //   this.set( data2 );
      //   this.actualStep = 1;
      // }
      this.fetch();
    },

    pause: function(){
      clearInterval( this.interval );
    },

    setup: function(){
      console.log( "Universe.setup" );

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