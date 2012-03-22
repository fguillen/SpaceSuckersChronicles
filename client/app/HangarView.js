$(function(){
  App.HangarView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#hangar").html() ),

    events: {
      "click #upgrade": "upgrade",
    },

    initialize: function(opts){
      console.log( "HangarView.initialize", opts );

      this.hangar = opts.hangar;
      this.hangar.on( "change" , this.render, this );
    },

    upgrade: function(){
      this.hangar.upgrade();
    },

    render: function(){
      console.log( "HangarView.render", this.hangar );

      var hangarDecorator = new App.HangarDecorator({ hangar: this.hangar });
      this.$el.html( this.template( hangarDecorator.toJSON() ) );
      return this;
    }
  });
});