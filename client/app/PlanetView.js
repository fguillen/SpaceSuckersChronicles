$(function(){
  App.PlanetView = Backbone.View.extend({
    template  : _.template( $('#planet').html() ),

    attributes: {
      "class": "planet"
    },

    events: {
      "click": "select"
    },

    select: function(){
      if( this.planet.get( "selectable" ) ){
        App.Game.sendFleetToPlanet( this.planet );
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
      this.$el.css({ "left"  : (this.planet.get("position")[0] - 15)  });
      this.$el.css({ "top" : (this.planet.get("position")[1] - 17) });
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
});