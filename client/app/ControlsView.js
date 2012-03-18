$(function(){
  App.ControlsView = Backbone.View.extend({
    el: "#universe-controls",

    events: {
      "click #synch": "synch",
      "click #pause": "pause"
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
    }

  });
});