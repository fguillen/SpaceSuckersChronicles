$(function(){
  App.PlanetsSmallView = Backbone.View.extend({
    tagName: 'ul',

    initialize: function(opts){
      this.planets = App.Game.planets;
      this.planets.bind( 'reset', this.addAll, this );
      this.planets.bind( 'add', this.addOne, this );

      this.addAll();
    },

    addOne: function( model ) {
      var view = new App.PlanetSmallView({ planet: model });
      this.$el.append( view.render().el );
    },

    addAll: function() {
      this.planets.each( $.proxy( this.addOne, this ) );
    },

    unlink: function(){
      this.planets.off(null, null, this);
      this.remove();
    }

  });
});