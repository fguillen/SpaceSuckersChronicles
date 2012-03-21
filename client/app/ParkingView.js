$(function(){
  App.ParkingView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#parking").html() ),

    initialize: function(opts){
      console.log( "ParkingView.initialize", opts );

      this.parking = opts.parking;
      this.parking.on( "change" , this.render, this );
    },

    render: function(){
      var parkingDecorator = new App.ParkingDecorator({ parking: this.parking });
      console.log( "ParkingView.render.parkingDecorator.toJSON()", parkingDecorator.toJSON() );
      this.$el.html( this.template( parkingDecorator.toJSON() ) );
      return this;
    }
  });
});