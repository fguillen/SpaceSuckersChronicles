$(function(){
  App.PlanetsView = Backbone.View.extend({
    initialize: function(opts){
      this.planets = opts.planets;
      this.planets.on( 'reset', this.addAll, this );
      this.planets.on( 'add', this.addOne, this );

      this.addAll();
    },

    addOne: function( model ){
      var view = new App.PlanetView({ planet: model });
      this.$el.append( view.render().el );
    },

    addAll: function(){
      this.planets.each( $.proxy( this.addOne, this ) );
    },

    unlink: function(){
      this.planets.off( null, null, this );
      this.remove();
    }

  });
});