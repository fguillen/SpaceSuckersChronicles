  $(function(){
    App.Router = Backbone.Router.extend({

      routes: {
        "dashboard":  "dashboard",
        "planet/:id": "planet",
      },

      dashboard: function() {
        console.log( "Router.dashboard" );

        console.log( "fadeout planet" );
        $("#wrapper #infos .planet.visible").fadeOut( "fast", function(){
          console.log( "fadein dashboard" );
          $("#wrapper #dashboard").fadeIn( "slow" );
        });

        console.log( "Router.dashboard END" );
      },

      planet: function( id ) {
        console.log( "Router.planet", id );

        App.Game.planets.get( id ).set( "visible", true );

        console.log( "fadeout dashboard" );
        $("#wrapper #dashboard").fadeOut( "fast", function(){
          console.log( "fadein planet" );
          $("#wrapper #infos #planet-info-" + id).fadeIn( "slow" );
        });

        console.log( "Router.planet END" );
      }

    });
});