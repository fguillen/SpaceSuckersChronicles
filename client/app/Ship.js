$(function(){
  App.Ship = Backbone.Model.extend({
    initialize: function(){
      this.set( "selected", false );
      this.on( "change:base_id", this.updateBase, this );
      this.updateBase();
    },

    updateBase: function(){
      var base = App.Game.planets.get( this.get( "base_id" ) )
      if( !base ) base = App.Game.fleets.get( this.get( "base_id" ) )
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