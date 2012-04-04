  $(function(){
    App.Router = Backbone.Router.extend({

      routes: {
        "dashboard":  "dashboard",
        "planet/:id": "planet",
      },

      dashboard: function() {
        console.log( "Router.dashboard" );
        $("#wrapper #infos .planet").fadeOut( "fast", function(){
          $("#wrapper #dashboard").fadeIn( "slow" );
        });

        console.log( "Router.dashboard END" );
      },

      planet: function( id ) {
        console.log( "Router.planet", id );

        $("#wrapper #dashboard").fadeOut( "fast", function(){
          $("#wrapper #infos #planet-info-" + id).fadeIn( "slow" );
        });

        console.log( "Router.planet END" );
      }

    });
});