$(function(){
  App.ControlsView = Backbone.View.extend({
    template  : _.template( $('#controls-template').html() ),

    events: {
      "click #synch":       "synch",
      "click #pause":       "pause",
      "click #step":        "step",
      "click #dashboard":   "dashboard",
    },

    initialize: function(opts){
      this.universe = opts.universe;
    },

    synch: function(){
      this.universe.synch();
      this.$el.find("#synch").hide();
      this.$el.find("#pause").show();
    },

    pause: function(){
      this.universe.pause();
      this.$el.find("#synch").show();
      this.$el.find("#pause").hide();
    },

    step: function(){
      console.log( "ControlsView.step" );
      App.Game.refresh();
    },

    dashboard: function(){
      App.Navigator.navigate( "dashboard", {trigger: true} );
    },

    render: function(){
      this.$el.html( this.template() );
      this.ajaxWatcher();

      return this;
    },


    ajaxWatcher: function() {
      this.$el.find('#ajax-loading').ajaxStart( function() {
        $(this).fadeIn();
      });

      this.$el.find('#ajax-loading').ajaxStop( function() {
        $(this).fadeOut();
      });
    }

  });
});