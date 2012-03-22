  $(function(){
    App.Router = Backbone.Router.extend({

      routes: {
        "dashboard":  "dashboard",
        "planet/:id": "planet",
      },

      dashboard: function() {
        $("html,body").animate(
          {
            scrollTop: $("#wrapper > #dashboard").offset().top
          },
            1000,
            "swing"
        );
      },

      planet: function( id ) {
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