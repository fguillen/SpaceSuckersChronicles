$(function(){
  App.Fleet = Backbone.Model.extend({
    url: App.RootUrl + "/fleets",

    initialize: function(){
      this.ships =
        new App.AutoUpdatedCollection({
          name:             "Fleet-" + this.id + "-ships",
          sourceCollection: App.Game.ships,
          filterField:      "base_id",
          filterValue:      this.id
        }).filteredCollection;

      // var destination = App.Game.planets.get( this.get( "target_id" ) )
      // destination.enemyFleets.add( this );
    },
  });
});