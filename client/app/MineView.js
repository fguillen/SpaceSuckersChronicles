$(function(){
  App.MineView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#mine").html() ),

    events: {
      "click #upgrade": "upgrade",
    },

    initialize: function(opts){
      this.mine = opts.mine;
      this.mine.on( "change" , this.render, this );
    },

    upgrade: function(){
      console.log( "upgrade mine" );
      this.mine.upgrade();
    },

    render: function(){
      var mineDecorator = new App.MineDecorator({ mine: this.mine });
      this.$el.html( this.template( mineDecorator.toJSON() ) );
      return this;
    }
  });
});