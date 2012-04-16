$(function(){
  App.PlanetsView = Backbone.View.extend({
    el: "#dashboard #planets ul",

    initialize: function(opts){
      this.planets = opts.planets;
      this.planets.bind( 'reset', this.addAll, this );
      this.planets.bind( 'add', this.addOne, this );

      this.addAll();
    },

    addOne: function( model ){
      var view = new App.PlanetView({ planet: model });
      this.$el.append( view.render().el );
    },

    addAll: function(){
      this.planets.each( $.proxy( this.addOne, this ) );
    },

  });
});