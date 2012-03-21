$(function(){
  App.Planet = Backbone.Model.extend({
    initialize: function(){
      console.log( "Planet.initialize", this );

      this.set( "selected", false );
      this.ships        = new App.Ships();
      this.enemyFleets  = new App.Fleets();

      this.set( "creatingFleet", false );
      this.set( "possibleFleetDestination", false );

      this.on( "change:mine change:silo", this.updateConstructions, this );

      this.updateConstructions();
    },

    updateConstructions: function(){
      console.log( "Planet.updateConstructions", this );
      if( !this.mine ) this.mine = new App.Mine();
      if( !this.silo ) this.silo = new App.Silo();

      this.mine.set( this.get( "mine" ) );
      this.silo.set( this.get( "silo" ) );
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