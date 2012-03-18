$(function(){
  App.Ships = Backbone.Collection.extend({
    model: App.Ship,

    initialize: function(){
      this.on( "app:removed", this.removeModel, this );
    },

    removeModel: function( model ){
      console.log( "Ships.removeModel", model );
      this.remove( model );
    },

    selected: function(){
      var result =
        this.filter( function( ship ){
          return ship.get( "selected" );
        });

      return result;
    },

    anySelected: function(){
      return this.selected().length > 0;
    },

    get_by_ids: function( ids ){
      var result =
        this.filter( function( ship ){
          return _.include( ids, ship.get( "id" ) );
        });

      return result;
    }
  });
});