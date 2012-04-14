$(function(){
  App.ControlsView = Backbone.View.extend({
    el: "#universe-controls",

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
      App.Game.refresh();
    },

    dashboard: function(){
      App.Navigator.navigate( "dashboard", {trigger: true} );
    }

  });
});