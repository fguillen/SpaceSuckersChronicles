$(function(){
  App.PlanetInfoView = Backbone.View.extend({
    template  : _.template( $('#planet-info').html() ),

    events: {
      "click .create-fleet": "createFleet"
    },

    initialize: function(opts){
      this.planet = opts.planet;
      this.planet.on( "change:blackstuff", this.renderByBlackStuff, this );

      this.planet.enemyFleets.on( "all", this.renderByEnemyFleet, this );

      this.shipsView = new App.ShipsView({ ships: this.planet.ships });
    },

    createFleet: function(){
      App.Navigator.navigate( "planet/" + this.planet.id + "/create_fleet", {trigger: true} );
    },

    renderByBlackStuff: function(){
      console.log( "PlanetInfoView.renderByBlackStuff", this.planet.id );
      this.render();
    },

    renderByEnemyFleet: function(){
      console.log( "PlanetInfoView.renderByEnemyFleet", this.planet.id );
      this.render();
    },

    render: function(){
      console.log( "PlanetInfoView.render", this.planet.id );

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
    },

    unlink: function(){
      console.log( "PlanetInfoView.unlink", this.planet.id );
      this.planet.enemyFleets.off( null, null, this );
      this.planet.off( null, null, this );
      this.remove();
    }
  });
});