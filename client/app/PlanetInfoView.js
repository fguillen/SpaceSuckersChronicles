$(function(){
  App.PlanetInfoView = Backbone.View.extend({
    tagName   : "li",
    template  : _.template( $('#planet-info').html() ),

    events: {
      "click .create-fleet": "creatingFleet",
      "click .cancel-fleet": "cancelFleet"
    },

    initialize: function(opts){
      this.planet = opts.planet;
      this.planet.on( "change:selected", this.toggle, this );
      this.planet.on( "change:blackstuff", this.render, this );
      this.planet.on( "change:creatingFleet", this.updateNavyControls, this );
      this.planet.ships.on( "change:selected", this.updateNavyControls, this );

      this.planet.enemyFleets.on( "all", this.render, this );

      this.shipsView = new App.ShipsView({ ships: this.planet.ships });
    },

    updateNavyControls: function(){
      var _self = this;

      if( this.planet.ships.anySelected() && !this.planet.get( "creatingFleet" ) ){
        this.$el.find( ".cancel-fleet" ).fadeOut( "fast", function(){
          _self.$el.find( ".create-fleet" ).fadeIn();
        } );

      } else if( this.planet.ships.anySelected() && this.planet.get( "creatingFleet" ) ){
        this.$el.find( ".create-fleet" ).fadeOut( "fast", function(){
          _self.$el.find( ".cancel-fleet" ).fadeIn();
        } );

      } else {
        this.$el.find( ".create-fleet" ).fadeOut();
        this.$el.find( ".cancel-fleet" ).fadeOut();
      }
    },

    creatingFleet: function(){
      this.planet.set( "creatingFleet", true );
      this.planet.set( "selected", true );
    },

    cancelFleet: function(){
      this.planet.set( "creatingFleet", false );
      this.planet.set( "selected", false );
    },

    toggle: function(){
      if( this.planet.get( "selected" ) ){
        this.$el.css({ zIndex: 100 });
        this.$el.animate( { right: 0 }, 500 );
      } else {
        this.$el.css({ zIndex: 0 });
        this.$el.animate( { right: -400 }, 500 );
      }
    },

    render: function(){
      console.log( "PlanetInfoView.render" );
      this.$el.html( this.template( this.planet.toJSON() ) );
      this.$el.find( "#navy h1" ).after( this.shipsView.render().el );

      var _self = this;
      this.planet.enemyFleets.each( function( fleet ){
        var view = new App.FleetInfoView({ fleet: fleet });
        _self.$el.find( "#enemy-fleets ul" ).append( view.render().el );
      });

      return this;
    }
  });
});