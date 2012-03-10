$(function(){
  App.ShipsView = Backbone.View.extend({
    tagName: 'ul',

    attributes: {
      "class": "details"
    },

    initialize: function(opts){
      this.ships = opts.ships;
      this.ships.bind( 'remove', this.removeOne, this );
      this.ships.bind( 'add', this.addOne, this );
      this.ships.each( $.proxy( this.addOne, this ) );
    },

    render: function(){
      return this;
    },

    removeOne: function( model ) {
      model.trigger( "s2c:remove:from_planet" );
    },

    addOne: function( model ) {
      var view = new App.ShipView({ ship: model });
      this.$el.append( view.render().el );
    },

  });
});