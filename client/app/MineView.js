$(function(){
  App.MineView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#mine").html() ),

    events: {
      "click #upgrade": "upgrade",
    },

    initialize: function(opts){
      console.log( "MineView.initialize", opts );

      this.mine = opts.mine;
      this.mine.on( "change" , this.render, this );
    },

    upgrade: function(){
      this.mine.upgrade();
    },

    render: function(){
      var mineDecorator = new App.MineDecorator({ mine: this.mine });
      console.log( "MineView.render.mineDecorator.toJSON()", mineDecorator.toJSON() );
      this.$el.html( this.template( mineDecorator.toJSON() ) );
      return this;
    }
  });
});