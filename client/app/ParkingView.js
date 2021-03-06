$(function(){
  App.ParkingView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#parking").html() ),

    events: {
      "click #upgrade": "upgrade",
    },

    initialize: function(opts){
      this.parking = opts.parking;
      this.parking.on( "change" , this.render, this );
    },

    upgrade: function(){
      this.parking.upgrade();
    },

    render: function(){
      var parkingDecorator = new App.ParkingDecorator({ parking: this.parking });
      this.$el.html( this.template( parkingDecorator.toJSON() ) );
      return this;
    }
  });
});