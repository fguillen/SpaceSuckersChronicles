$(function(){
  App.Hangar = Backbone.Model.extend({
    upgrade: function(){
      new App.CommandUpgrade({ unit: this }).save();
    },

    buildShip: function(){
      new App.CommandBuildShip({ hangar: this }).save();
    }
  });
});