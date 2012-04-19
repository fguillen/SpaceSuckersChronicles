$(function(){
  App.DashboardView = Backbone.View.extend({
    template  : _.template( $('#dashboard-template').html() ),

    initialize: function( opts ){
      this.universe = opts.universe;
      this.planetsView = new App.PlanetsView({ planets: this.universe.planets });
      this.fleetsView = new App.FleetsView({ fleets: this.universe.fleets });
      this.noticesView = new App.NoticesView({ notices: this.universe.notices });
    },

    render: function(){
      console.log( "DashboardView.render" );

      this.$el.html( this.template() );

      this.$el.find( "#planets ul" ).html( this.planetsView.render().el );
      this.$el.find( "#fleets ul" ).html( this.fleetsView.render().el );
      this.$el.find( "#notices ul" ).html( this.noticesView.render().el );

      return this;
    },

    unlink: function(){
      this.planetsView.unlink();
      this.fleetsView.unlink();
      this.noticesView.unlink();
      this.remove();
    }

  });
});