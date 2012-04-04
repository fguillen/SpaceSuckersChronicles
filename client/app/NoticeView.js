$(function(){
  App.NoticeView = Backbone.View.extend({
    template  : _.template( $('#notice').html() ),

    attributes: {
      "class": "notice"
    },

    initialize: function( opts ){
      this.notice = opts.notice;
    },

    render: function(){
      this.$el.html( this.template( this.notice.toJSON() ) );
      return this;
    }
  });
});