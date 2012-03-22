$(function(){
  App.Planet = Backbone.Model.extend({
    initialize: function(){
      this.set( "selected", false );
      this.ships        = new App.Ships();
      this.enemyFleets  = new App.Fleets();

      this.set( "creatingFleet", false );
      this.set( "possibleFleetDestination", false );

      this.on( "change:mine change:silo change:hangar change:parking", this.updateConstructions, this );

      this.updateConstructions();
    },

    updateConstructions: function(){
      if( !this.mine ) this.mine = new App.Mine();
      if( !this.silo ) this.silo = new App.Silo();
      if( !this.hangar ) this.hangar = new App.Hangar();
      if( !this.parking ) this.parking = new App.Parking();

      this.mine.set( this.get( "mine" ) );
      this.silo.set( this.get( "silo" ) );
      this.hangar.set( this.get( "hangar" ) );
      this.parking.set( this.get( "parking" ) );
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