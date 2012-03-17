$(function(){
  App.FleetView = Backbone.View.extend({
    template  : _.template( $('#fleet').html() ),

    attributes: {
      "class": "fleet"
    },

    events: {
      "click": "select"
    },

    select: function(){
      this.fleet.selectToggle();
    },

    initialize: function(opts){
      this.fleet = opts.fleet;
      this.fleet.on( "change:selected", this.updateSelected, this );
      this.fleet.on( "remove", this.fadeOut, this );

      this.updateAttributes();
    },

    fadeOut: function(){
      var _self = this;
      this.$el.fadeOut( "slow", function() { _self.remove() } );
    },

    updateAttributes: function(){
      this.updateSelected();
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
});