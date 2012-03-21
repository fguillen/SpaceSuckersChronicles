$(function(){
  App.MineView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#silo").html() ),

    initialize: function(opts){
      console.log( "MineView.initialize", opts );

      this.mine = opts.mine;
      this.mine.on( "change" , this.render, this );
    },

    render: function(){
      var mineDecorator = new App.SiloDecorator({ mine: this.mine });
      this.$el.html( this.template( mineDecorator.toJSON() ) );
      return this;
    }
  });
});