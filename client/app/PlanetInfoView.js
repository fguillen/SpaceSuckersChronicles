$(function(){
  App.PlanetInfoView = Backbone.View.extend({
    tagName   : "li",
    template  : _.template( $('#planet-info').html() ),

    events: {
      "click .create-fleet": "createFleet"
    },

    initialize: function(opts){
      this.planet = opts.planet;
      this.planet.on( "change:blackstuff", this.render, this );
      this.planet.on( "change:visible", this.render, this );
      this.planet.ships.on( "change:selected", this.updateNavyControls, this );

      this.planet.enemyFleets.on( "all", this.render, this );

      this.shipsView = new App.ShipsView({ ships: this.planet.ships });
    },

    updateNavyControls: function(){
      if( this.planet.ships.anySelected() ){
        this.$el.find( ".create-fleet" ).fadeIn();
      } else {
        this.cancelFleet();
        this.$el.find( ".create-fleet" ).fadeOut();
      }
    },

    createFleet: function(){
      App.Game.createFleet( this.planet );
    },


    render: function(){
      var planetDecorator = new App.PlanetDecorator({ planet: this.planet });
      this.$el.html( this.template( planetDecorator.toJSON() ) );

      // constructions
      // mine
      var mineView = new App.MineView({ mine: this.planet.mine });
      this.$el.find( "#constructions ul" ).append( mineView.render().el );

      // silo
      var siloView = new App.SiloView({ silo: this.planet.silo });
      this.$el.find( "#constructions ul" ).append( siloView.render().el );

      // hangar
      var hangarView = new App.HangarView({ hangar: this.planet.hangar });
      this.$el.find( "#constructions ul" ).append( hangarView.render().el );

      // parking
      var parkingView = new App.ParkingView({ parking: this.planet.parking });
      this.$el.find( "#constructions ul" ).append( parkingView.render().el );

      // navy
      this.$el.find( "#navy h1" ).after( this.shipsView.render().el );

      // enemy fleets
      var _self = this;
      this.planet.enemyFleets.each( function( fleet ){
        var view = new App.FleetInfoView({ fleet: fleet });
        _self.$el.find( "#enemy-fleets > ul" ).append( view.render().el );
      });

      return this;
    }
  });
});