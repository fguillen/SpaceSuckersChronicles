$(function(){
  App.MineDecorator = Backbone.Model.extend({
    initialize: function( opts ){
      this.mine = opts.mine;
    },

    toJSON: function(){
      var json =
        _.extend(
          this.mine.toJSON(),
          {}
        );

      return json;
    },
  });
});
