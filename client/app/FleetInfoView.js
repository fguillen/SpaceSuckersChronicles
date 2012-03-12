$(function(){
  App.FleetInfoView = Backbone.View.extend({
    template  : _.template( $('#fleet-info').html() ),

    attributes: {
      "class": "panel-info fleet-info"
    },

    initialize: function(opts){
      this.fleet = opts.fleet;
      this.fleet.on( "change:selected", this.toggle, this );
      this.fleet.on( "change", this.render, this );
      this.fleet.on( "remove", this.fadeOut, this );

      this.$el.attr( "id", "fleet-info-" + this.fleet.id );

      this.shipsView = new App.ShipsView({ ships: this.fleet.ships });
    },

    fadeOut: function(){
      var _self = this;
      this.$el.animate( { right: -400 }, 500, function(){ _self.remove(); } );
    },

    toggle: function(){
      if( this.fleet.get( "selected" ) ){
        this.$el.css({ zIndex: 100 });
        this.$el.animate( { right: 0 }, 500 );
      } else {
        this.$el.css({ zIndex: 0 });
        this.$el.animate( { right: -400 }, 500 );
      }
    },

    render: function(){
      this.$el.html( this.template( this.fleet.toJSON() ) );
      this.$el.find( ".navy" ).append( this.shipsView.render().el );

      return this;
    }
  });
});