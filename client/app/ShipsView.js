$(function(){
  App.ShipsView = Backbone.View.extend({
    tagName: 'ul',

    attributes: {
      "class": "details"
    },

    initialize: function(opts){
      console.log( "ShipsView.initialize", opts );

      this.ships = opts.ships;
      this.ships.bind( 'remove', this.render, this );
      // this.ships.bind( 'add', this.render, this );
    },

    render: function(){
      console.log( "ShipsView.render" );
      this.$el.html("");
      this.ships.each( $.proxy( this.addOne, this ) );
      return this;
    },

    addOne: function( model ) {
      var view = new App.ShipView({ ship: model });
      this.$el.append( view.render().el );
    },

  });
});