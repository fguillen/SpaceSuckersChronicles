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
      },

      planet: function( id ) {
        console.log( "Router.planet", id );
        $("html,body").animate(
          {
            scrollTop: $("#infos #" + id).offset().top
          },
            1000,
            "swing"
        );
      }

    });
});