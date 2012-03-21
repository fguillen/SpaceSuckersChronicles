$(function(){
  App.Planet = Backbone.Model.extend({
    initialize: function(){
      this.set( "selected", false );
      this.ships        = new App.Ships();
      this.enemyFleets  = new App.Fleets();
      this.mine         = new App.Silo( this.get( "mine" ) );
      this.silo         = new App.Silo( this.get( "silo" ) );

      this.set( "creatingFleet", false );
      this.set( "possibleFleetDestination", false );
    },

    selectToggle: function(){
      if( this.get( "selected" ) ){
        this.set( "selected", false );
      } else {
        this.set( "selected", true );
      }
    },
  });
});