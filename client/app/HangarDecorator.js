$(function(){
  App.HangarDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.hangar = opts.hangar;
    },

    toJSON: function(){
      var json =
        _.extend(
          this.hangar.toJSON(),
          {}
        );

      return json;
    },
  });
});
