$(function(){
  App.Ships = Backbone.Collection.extend({
    model: App.Ship,

    selected: function(){
      var result =
        this.filter( function( ship ){
          return ship.get( "selected" );
        });

      return result;
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