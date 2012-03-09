$(function(){
  App.Utils = {
    refreshCollection: function( collection, dataJSON ){
      // update/add
      _(dataJSON).each( function( modelJSON ) {
        var model = collection.get( modelJSON.id );
        if( model ) {
          model.set( modelJSON );
        } else {
          collection.add( modelJSON );
        }
      });

      // remove
      var model_ids_to_keep = _(dataJSON).pluck( "id" );
      var model_ids = collection.pluck( "id" );
      var model_ids_to_remove = _(model_ids).difference(model_ids_to_keep)

      _(model_ids_to_remove).each( function( model_id_to_remove ){
        collection.remove( model_id_to_remove );
      });
    },
  }
});