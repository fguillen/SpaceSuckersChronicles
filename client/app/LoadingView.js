$(function(){
  App.LoadingView = Backbone.View.extend({
    template  : _.template( $('#loading-template').html() ),

    render: function(){
      console.log( "LoadingView.render" );
      this.$el.html( this.template({}) );

      return this;
    },

    unlink: function(){
      this.remove();
    }
  });
});