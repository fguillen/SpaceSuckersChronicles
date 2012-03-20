$(function(){
  App.SiloView = Backbone.View.extend({
    tagName: 'li',
    template: _.template( $("#silo").html() ),

    initialize: function(opts){
      console.log( "SiloView.initialize", opts );

      this.silo = opts.silo;
      this.silo.on( "change" , this.render, this );
    },

    render: function(){
      var siloDecorator = new App.SiloDecorator({ silo: this.silo });
      this.$el.html( this.template( siloDecorator.toJSON() ) );
      return this;
    }
  });
});