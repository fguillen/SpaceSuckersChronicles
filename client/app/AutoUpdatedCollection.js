$(function(){
  App.AutoUpdatedCollection = Backbone.Model.extend({
    initialize: function( opts ){
      this.name                 = opts.name;
      this.sourceCollection     = opts.sourceCollection;
      this.filterField          = opts.filterField;
      this.filterValue          = opts.filterValue;
      this.filteredCollection   = new Backbone.Collection;

      this.filteredCollection.reset( this.filterCollection() );

      this.sourceCollection.on( "change:" + this.filterField, this.filterModel, this );
      this.sourceCollection.on( "remove", this.removeModel, this );
      this.sourceCollection.on( "add", this.addModel, this );
    },

    filterCollection: function(){
      console.log( "AutoUpdatedCollection.filterCollection", this.name );

      // var _self = this;
      var result =
        this.sourceCollection.filter( function( model ) {
          return model.get( this.filterField ) == this.filterValue;
        }, this);

      console.log( "AutoUpdatedCollection.filterCollection.result", this.name, result.length, result );

      return result;
    },

    filterModel: function( model, val ){
      console.log( "AutoUpdatedCollection.filterModel", this.name, model.id, val );

      if( val == this.filterValue ){
        this.addModel( model );
      } else {
        this.removeModel( model );
      }
    },

    removeModel: function( model ){
      if( this.filteredCollection.get( model.id ) ){
        console.log( "AutoUpdatedCollection.removeModel", this.name, model.id );
        this.filteredCollection.remove( model );
      }
    },

    addModel: function( model ){



      if( model.get( this.filterField ) == this.filterValue ){
        console.log( "AutoUpdatedCollection.addModel", this.name, model.id, Math.random() );

        this.filteredCollection.each( function( _model ){
          console.log( "model.id", _model.id )
        });


        this.filteredCollection.add( model );
      }
    }
  });
});