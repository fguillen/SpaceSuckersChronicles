$(function(){
  App.SiloView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#silo").html() ),

    events: {
      "click #upgrade": "upgrade",
    },

    initialize: function(opts){
      this.silo = opts.silo;
      this.silo.on( "change" , this.render, this );
    },

    upgrade: function(){
      console.log( "SiloView.upgrade" );
      this.silo.upgrade();
    },

    render: function(){
      var siloDecorator = new App.SiloDecorator({ silo: this.silo });
      this.$el.html( this.template( siloDecorator.toJSON() ) );
      return this;
    }
  });
});