  $(function(){
    App.Router = Backbone.Router.extend({

      routes: {
        "dashboard":  "dashboard",
        "planet/:id": "planet",
      },

      dashboard: function() {
        console.log( "Router.dashboard" );

        $("html,body").animate(
          {
            scrollTop: $("#wrapper > #dashboard").offset().top
          },
            1000,
            "swing"
        );

        console.log( "Router.dashboard END" );
      },

      planet: function( id ) {
        console.log( "Router.planet", id );

        $("html,body").animate(
          {
            scrollTop: $("#planet-info-" + id).offset().top
          },
            1000,
            "swing"
        );

        console.log( "Router.planet END" );
      }

    });
});