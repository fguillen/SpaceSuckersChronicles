$(function(){
  App.Utils = {
    refreshCollection: function( collection, collectionJSON ){
      // update/add
      _( collectionJSON ).each( function( modelJSON ) {
        var model = collection.get( modelJSON.id );
        if( model ) {
          console.log( "refreshCollection.model", model.id, model.get( "base_id" ) );
          console.log( "refreshCollection.modelJSON", modelJSON.id, modelJSON.base_id );
          model.set( modelJSON );
        } else {
          collection.add( modelJSON );
        }
      });

      // remove
      var model_ids_to_keep     = _( collectionJSON ).pluck( "id" );
      var model_ids             = collection.pluck( "id" );
      var model_ids_to_remove   = _( model_ids ).difference( model_ids_to_keep )

      _( model_ids_to_remove ).each( function( model_id_to_remove ){
        var model = collection.get( model_id_to_remove );
        model.trigger( "app:removed", model );
        collection.remove( model_id_to_remove );
      });
    },
  }
});