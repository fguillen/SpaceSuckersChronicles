$(function(){
  App.Mine = Backbone.Model.extend({
    upgrade: function(){
      new App.CommandUpgrade({ unit: this }).save();
    }
  });
});