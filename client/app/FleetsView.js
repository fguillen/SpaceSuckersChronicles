$(function(){
  App.FleetsView = Backbone.View.extend({
    initialize: function(opts){
      this.fleets = opts.fleets;
      this.fleets.bind( 'reset', this.addAll, this );
      this.fleets.bind( 'add', this.addOne, this );

      this.addAll();
    },

    addOne: function( model ) {
      var view = new App.FleetView({ fleet: model });
      this.$el.append( view.render().el );
    },

    addAll: function() {
      this.fleets.each( $.proxy( this.addOne, this ) );
    },

    unlink: function() {
      this.fleets.off( null, null, this );
      this.remove();
    }
  });
});