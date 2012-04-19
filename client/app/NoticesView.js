$(function(){
  App.NoticesView = Backbone.View.extend({
    initialize: function(opts){
      this.notices = opts.notices;
      this.notices.bind( 'reset', this.addAll, this );
      this.notices.bind( 'add', this.addOne, this );

      this.addAll();
    },

    addOne: function( model ) {
      var view = new App.NoticeView({ notice: model });
      view.render()
      view.$el.hide();
      this.$el.prepend( view.$el );
      view.$el.fadeIn();
    },

    addAll: function() {
      this.notices.each( $.proxy( this.addOne, this ) );
    },

    unlink: function(){
      this.notices.off( null, null, this );
      this.remove();
    }
  });
});