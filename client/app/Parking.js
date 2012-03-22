$(function(){
  App.Parking = Backbone.Model.extend({
    upgrade: function(){
      new App.CommandUpgrade({ unit: this }).save();
    }
  });
});