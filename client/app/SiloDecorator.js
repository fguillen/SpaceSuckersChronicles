$(function(){
  App.SiloDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.silo = opts.silo;
    },

    toJSON: function(){
      var json =
        _.extend(
          this.silo.toJSON(),
          {
            capacity_percent: this.capacityPercent()
          }
        );

      return json
    },

    capacityPercent: function(){
      return toPercent( this.silo.get( "stuff" ), this.silo.get( "capacity" ) )
    }
  });
});
