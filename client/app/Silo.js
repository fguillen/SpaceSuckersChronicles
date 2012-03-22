$(function(){
  App.Silo = Backbone.Model.extend({
    upgrade: function(){
      new App.CommandUpgrade({ unit: this }).save();
    }
  });
});