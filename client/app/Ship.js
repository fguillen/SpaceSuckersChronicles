$(function(){
  App.Ship = Backbone.Model.extend({
    initialize: function(){
      this.set( "enroled_in_fleet", false );
      this.on( "change:base_id", this.updateBase, this );
      this.updateBase();
    },

    updateBase: function(){
      var base = App.Game.planets.get( this.get( "base_id" ) )
      if( !base ) base = App.Game.fleets.get( this.get( "base_id" ) )
      base.ships.add( this );
    },

    enrolInFleet: function(){
      this.set( "enroled_in_fleet", true );
    },

    pullOutOfFleet: function(){
      this.set( "enroled_in_fleet", false );
    },
  });

});