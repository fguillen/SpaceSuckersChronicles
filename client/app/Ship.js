$(function(){
  App.Ship = Backbone.Model.extend({
    initialize: function(){
      this.set( "selected", false );
      this.on( "change:base_id", this.updateBase, this );
      this.updateBase();
    },

    updateBase: function(){
      console.log( "Ship.updateBase", this );
      var base = App.Game.planets.get( this.get( "base_id" ) )

      console.log( "Ship.updateBase base1", base );

      if( !base ) base = App.Game.fleets.get( this.get( "base_id" ) )

      console.log( "Ship.updateBase base2", base );

      base.ships.add( this );
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