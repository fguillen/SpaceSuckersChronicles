var Game = "pepe";

$(function(){
  var map = $("#map");

  var Fleet = Backbone.Model.extend({
    url: "http://localhost:9292/fleets",

    initialize: function(){
      console.log( "Fleet.initialize", this );
      this.set( "selected", false );

      this.set( "ships",        new Ships().reset( this.get( "shipsData" ) ) );
      this.set( "origin",       Game.planets.get( this.get( "origin_id" ) ) );
      this.set( "destination",  Game.planets.get( this.get( "destination_id" ) ) );

      var coordinates = fleetCoordinates( this, Game.planets );

      this.set( "x", coordinates["x"] );
      this.set( "y", coordinates["y"] );
    },

    selectToogle: function(){
      if( this.get( "selected" ) ){
        this.set( "selected", false );
      } else {
        this.set( "selected", true );
      }
    },
  });

  var FleetView = Backbone.View.extend({
    template  : _.template( $('#fleet').html() ),

    attributes: {
      "class": "fleet"
    },

    events: {
      "click": "select"
    },

    select: function(){
      this.fleet.selectToogle();
    },

    initialize: function(opts){
      this.fleet = opts.fleet;
      this.fleet.on( "change:x change:y", this.updateAttributes, this );
      this.fleet.on( "change:selected", this.updateSelected, this );

      this.updateAttributes();
    },

    updateAttributes: function(){
      this.updatePositions();
      this.updateSelected();
    },

    updatePositions: function(){
      this.$el.css({ "left":  (this.fleet.get("x") - 5) });
      this.$el.css({ "top":   (this.fleet.get("y") - 5) });
    },

    updateSelected: function(){
      if( this.fleet.get( "selected" ) ){
        this.$el.addClass( "selected" );
      } else {
        this.$el.removeClass( "selected" );
      }
    },

    render: function(){
      this.$el.html( this.template( this.fleet.toJSON() ) );
      return this;
    }
  });

  var Fleets = Backbone.Collection.extend({
    model: Fleet,
    url: "http://localhost:9292/fleets",

    initialize: function() {
      this.on( "change:selected", this.changeSelected );
    },

    deselectAll: function(){
      this.each( function( e ){
        e.set( "selected", false );
      });
    },

    anySelected: function(){
      var result =
        this.any( function( fleet ){
          var result = fleet.get( "selected" );
          console.log( "Fleets.anySelected", result );
          return result;
        });

      console.log( "Fleets.anySelected.result", result );

      return result;
    },

    changeSelected: function( model, val, opts ){
      if( val ){
        Game.planets.deselectAll();

        this.each( function( e ){
          if( e != model && e.get( "selected" ) ) {
            e.set( "selected", false );
          }
        });
      };
    },
  });



  var Ship = Backbone.Model.extend({
    initialize: function(){
      this.set( "selected", false );
    },

    selectToogle: function(){
      if( this.get( "selected" ) ){
        this.set( "selected", false );
      } else {
        this.set( "selected", true );
      }
    },
  });

  var ShipView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#planet-ship").html() ),

    attributes: {
      "class": "ship"
    },

    events: {
      "click": "select"
    },

    select: function(){
      this.ship.selectToogle();
    },

    initialize: function(opts){
      this.ship = opts.ship;
      this.ship.on( "change:selected", this.updateSelected, this );
    },

    updateSelected: function(){
      if( this.ship.get( "selected" ) ){
        this.$el.addClass( "selected" );
      } else {
        this.$el.removeClass( "selected" );
      }
    },

    render: function(){
      this.$el.html( this.template( this.ship.toJSON() ) );
      return this;
    }
  });

  var Ships = Backbone.Collection.extend({
    model: Ship,

    selected: function(){
      var result =
        this.filter( function( ship ){
          return ship.get( "selected" );
        });

      return result;
    },
  });

  var ShipsView = Backbone.View.extend({
    tagName: 'ul',

    attributes: {
      "class": "details"
    },

    initialize: function(opts){
      this.ships = opts.ships;
      this.ships.bind( 'remove', this.render, this );
    },

    render: function(){
      console.log( "ShipsView.render" );
      this.$el.html("");
      this.ships.each( $.proxy( this.addOne, this ) );
      return this;
    },

    addOne: function( model ) {
      var view = new ShipView({ ship: model });
      this.$el.append( view.render().el );
    },

  });

  var Planet = Backbone.Model.extend({
    initialize: function(){
      console.log( "Planet.initialize", this );

      this.ships = new Ships().reset( this.get( "shipsData" ) );

      this.set( "selected", false );
    },

    selectToogle: function(){
      if( this.get( "selected" ) ){
        this.set( "selected", false );
      } else {
        this.set( "selected", true );
      }
    },
  });

  var Planets = Backbone.Collection.extend({
    model: Planet,

    url: "http://localhost:9292/planets",

    initialize: function() {
      this.on( "change:selected", this.changeSelected );
      this.on( "change:creatingFleet", this.creatingFleet );
    },

    anySelected: function(){
      return selected().size > 0;
    },

    selected: function(){
      var result =
        this.filter( function( planet ){
          return planet.get( "selected" );
        });

      return result;
    },

    creatingFleet: function( model, val, opts ){
      console.log( "Planets.creatingFleet", val );

      this.each( function( e ){
        if( e != model ) {
          e.set( "selectable", val );
        }
      });
    },

    deselectAll: function(){
      this.each( function( e ){
        e.set( "selected", false );
      });
    },

    changeSelected: function( model, val, opts ){
      if( val ){
        Game.fleets.deselectAll();

        this.each( function( e ){
          if( e != model && e.get( "selected" ) ) {
            e.set( "selected", false );
          }
        });
      };
    },

  });

  var PlanetView = Backbone.View.extend({
    template  : _.template( $('#planet').html() ),

    attributes: {
      "class": "planet"
    },

    events: {
      "click": "select"
    },

    select: function(){
      if( this.planet.get( "selectable" ) ){
        Game.sendFleetToPlanet( this.planet );
      } else {
        this.planet.selectToogle();
      }
    },

    initialize: function(opts){
      this.planet = opts.planet;
      this.planet.on( "change:x change:y", this.updateAttributes, this );
      this.planet.on( "change:selected", this.updateSelected, this );
      this.planet.on( "change:selectable", this.updateSelectable, this );

      this.updateAttributes();
    },

    updateAttributes: function(){
      this.updatePositions();
      this.updateSelected();
    },

    updatePositions: function(){
      this.$el.css({ "left"  : (this.planet.get("x") - 15)  });
      this.$el.css({ "top" : (this.planet.get("y") - 15) });
    },

    updateSelected: function(){
      if( this.planet.get( "selected" ) ){
        this.$el.addClass( "selected" );
      } else {
        this.$el.removeClass( "selected" );
      }
    },

    updateSelectable: function(){
      if( this.planet.get( "selectable" ) ){
        this.$el.addClass( "selectable" );
      } else {
        this.$el.removeClass( "selectable" );
      }
    },

    render: function(){
      this.$el.html( this.template( this.planet.toJSON() ) );
      return this;
    }
  });


  var FleetInfoView = Backbone.View.extend({
    template  : _.template( $('#fleet-info').html() ),

    attributes: {
      "class": "panel-info fleet-info"
    },

    initialize: function(opts){
      console.log( "FleetInfoView.initialize", opts );

      this.fleet = opts.fleet;
      this.fleet.on( "change:selected", this.toogle, this );

      this.$el.attr( "id", "fleet-info-" + this.fleet.id );
    },

    toogle: function(){
      if( this.fleet.get( "selected" ) ){
        this.$el.css({ zIndex: 100 });
        this.$el.animate( { right: 0 }, 500 );
      } else {
        this.$el.css({ zIndex: 0 });
        this.$el.animate( { right: -400 }, 500 );
      }
    },

    render: function(){
      console.log( "FleetInfoView.render", this.fleet );

      this.$el.html( this.template( this.fleet.toJSON() ) );

      return this;
    }
  });

  var PlanetInfoView = Backbone.View.extend({
    template  : _.template( $('#planet-info').html() ),

    attributes: {
      "class": "panel-info planet-info"
    },

    events: {
      "click .create-fleet": "creatingFleet",
      "click .cancel-fleet": "cancelFleet"
    },

    initialize: function(opts){
      console.log( "PlanetInfoView.initialize", opts );

      this.planet = opts.planet;
      this.planet.on( "change:selected", this.toogle, this );

      this.$el.attr( "id", "planet-info-" + this.planet.id );

      this.shipsView = new ShipsView({ ships: this.planet.ships });
    },

    creatingFleet: function(){
      console.log( "PlanetInfoView.creatingFleet" );
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
      console.log( "PlanetInfoView.render" );

      this.$el.html( this.template( this.planet.toJSON() ) );

      this.$el.find( ".navy" ).append( this.shipsView.render().el );


      return this;
    }
  });

  var MapView = Backbone.View.extend({
    el: "#map",

    initialize: function(opts){
      console.log( "MapView.initialize" );

      this.planets = opts.planets;
      this.planets.bind( 'reset', this.addAllPlanets, this );

      this.fleets = opts.fleets;
      this.fleets.bind( 'reset', this.addAllFleets, this );
      this.fleets.bind( 'add', this.addOneFleet, this );
    },

    addOnePlanet: function( model ) {
      var view = new PlanetView({ planet: model });
      this.$el.append( view.render().el );
    },

    addOneFleet: function( model ) {
      var view = new FleetView({ fleet: model });
      this.$el.append( view.render().el );
    },

    addAllPlanets: function() {
      this.planets.each( $.proxy( this.addOnePlanet, this ) );
    },

    addAllFleets: function() {
      this.fleets.each( $.proxy( this.addOneFleet, this ) );
    },
  });

  var InfoPanelView = Backbone.View.extend({
    el: "#info-panel",

    initialize: function(opts){
      this.planets = opts.planets;
      this.planets.bind( 'reset', this.addAllPlanets, this );

      this.fleets = opts.fleets;
      this.fleets.bind( 'reset', this.addAllFleets, this );
      this.fleets.bind( 'add', this.addOneFleet, this );
    },

    addOnePlanet: function( model ) {
      var view = new PlanetInfoView({ planet: model });
      this.$el.append( view.render().el );
    },

    addOneFleet: function( model ) {
      console.log( "InfoPanelView.addOneFleet", model );
      var view = new FleetInfoView({ fleet: model });
      this.$el.append( view.render().el );
    },

    addAllPlanets: function() {
      this.planets.each( $.proxy( this.addOnePlanet, this ) );
    },

    addAllFleets: function() {
      this.fleets.each( $.proxy( this.addOneFleet, this ) );
    },
  });

  var GameView = Backbone.View.extend({
    initialize: function(){
      console.log( "GameView.initialize" );

      this.data = data;
      this.planets = new Planets();
      this.fleets = new Fleets();

      this.map = new MapView({
        planets: this.planets,
        fleets: this.fleets,
      });

      this.infoPanel = new InfoPanelView({
        planets: this.planets,
        fleets: this.fleets,
      });

      console.log( "GameView.initialize END" );
    },

    sendFleetToPlanet: function( planetDestination ){
      console.log( "GameView.sendFleetToPlanet", planetDestination );

      var planetOrigin      = this.planets.selected()[0];
      var planetDestination = planetDestination;
      var ships             = planetOrigin.ships.selected();

      planetOrigin.ships.remove( ships );

      this.fleets.create({
        name:           "F999",
        origin_id:      planetOrigin.id,
        destination_id: planetDestination.id,
        percent:        0,
        shipsData:      new Ships( ships ).toJSON()
      });

      planetOrigin.set( "creatingFleet", false );

      console.log( "GameView.sendFleetToPlanet END" );
    },
  });




  Game = new GameView();
  Game.planets.fetch();
  Game.fleets.fetch();

  // Game.planets.reset( data.planets );
  // Game.fleets.reset( data.fleets );



});