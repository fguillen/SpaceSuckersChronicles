$(function(){
  App.HangarView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#hangar").html() ),

    events: {
      "click #upgrade": "upgrade",
      "click #build-ship": "buildShip",
    },

    initialize: function(opts){
      this.hangar = opts.hangar;
      this.hangar.on( "change" , this.render, this );
    },

    upgrade: function(){
      this.hangar.upgrade();
    },

    buildShip: function(){
      this.hangar.buildShip();
    },

    render: function(){
      var hangarDecorator = new App.HangarDecorator({ hangar: this.hangar });
      this.$el.html( this.template( hangarDecorator.toJSON() ) );
      return this;
    }
  });
});