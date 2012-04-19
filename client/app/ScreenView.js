$(function(){
  App.ScreenView = Backbone.View.extend({
    template  : _.template( $('#screen-template').html() ),

    initialize: function( opts ){
      this.universe = opts.universe;

      this.controlsView = new App.ControlsView({ universe: this.universe });

      var loadingView = new App.LoadingView();
      this.actualPage = loadingView;
    },

    render: function(){
      this.$el.html( this.template() );
      this.$el.find( "#controls" ).html( this.controlsView.render().el );
      this.renderPage( this.actualPage );

      return this;
    },

    renderPlanet: function( planet ){
      var planetView = new App.PlanetInfoView({ planet: planet });
      this.replaceActualPage( planetView );
    },

    renderDashboard: function(){
      var dashboardView = new App.DashboardView({ universe: this.universe });
      this.replaceActualPage( dashboardView );
    },

    renderCreateFleet: function( planet ){
      var fleetBuilder      = new App.FleetBuilder({ planet: planet, planetsDestination: this.universe.planets });
      var fleetBuilderView  = new App.FleetBuilderView({ fleetBuilder: fleetBuilder });
      this.replaceActualPage( fleetBuilderView );
    },

    renderPage: function( view ){
      this.$el.find( "#page" ).html( view.render().el );
      view.$el.fadeIn();
    },

    replaceActualPage: function( view ){
      console.log( "ScreenView.replaceActualPage", view, this.actualPage );

      var _self = this;
      this.actualPage.$el.fadeOut(
        "fast",
        function(){
          _self.renderPage( view );
          _self.actualPage.unlink();
          _self.actualPage = view;
        }
      );
    },

  });
});