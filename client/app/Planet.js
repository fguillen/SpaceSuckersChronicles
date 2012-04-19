$(function(){
  App.Planet = Backbone.Model.extend({
    initialize: function(){
      this.ships =
        new App.AutoUpdatedCollection({
          name:             "Planet-" + this.id + "-ships",
          sourceCollection: App.Game.ships,
          filterField:      "base_id",
          filterValue:      this.id
        }).filteredCollection;

      this.enemyFleets =
        new App.AutoUpdatedCollection({
          name:             "Planet-" + this.id + "-enemyFleets",
          sourceCollection: App.Game.fleets,
          filterField:      "target_id",
          filterValue:      this.id
        }).filteredCollection;

      this.set( "visible", false );

      this.on( "change:mine change:silo change:hangar change:parking", this.updateConstructions, this );

      this.updateConstructions();
    },

    updateConstructions: function(){
      if( !this.mine )    this.mine = new App.Mine();
      if( !this.silo )    this.silo = new App.Silo();
      if( !this.hangar )  this.hangar = new App.Hangar();
      if( !this.parking ) this.parking = new App.Parking();

      this.mine.set( this.get( "mine" ) );
      this.silo.set( this.get( "silo" ) );
      this.hangar.set( this.get( "hangar" ) );
      this.parking.set( this.get( "parking" ) );
    },
  });
});