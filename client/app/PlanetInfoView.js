$(function(){
  App.PlanetInfoView = Backbone.View.extend({
    template  : _.template( $('#planet-info').html() ),

    attributes: {
      "class": "panel-info planet-info"
    },

    events: {
      "click .create-fleet": "creatingFleet",
      "click .cancel-fleet": "cancelFleet"
    },

    initialize: function(opts){
      this.planet = opts.planet;
      this.planet.on( "change:selected", this.toogle, this );
      this.planet.on( "change", this.render, this );

      this.$el.attr( "id", "planet-info-" + this.planet.id );

      this.shipsView = new App.ShipsView({ ships: this.planet.ships });
    },

    creatingFleet: function(){
      this.planet.set( "creatingFleet", true );
    },

    cancelFleet: function(){
      this.planet.set( "creatingFleet", false );
    },

    toogle: function(){
      if( this.planet.get( "selected" ) ){
        this.$el.css({ zIndex: 100 });
        this.$el.animate( { right: 0 }, 500 );
      } else {
        this.$el.css({ zIndex: 0 });
        this.$el.animate( { right: -400 }, 500 );
      }
    },

    render: function(){
      this.$el.html( this.template( this.planet.toJSON() ) );
      this.$el.find( ".navy" ).append( this.shipsView.render().el );

      return this;
    }
  });
});