

//////////////////////////////////////////
////***   The Vue instance itself  ***////
//////////////////////////////////////////
var admin_area_instance = new Vue({

    el: '#admin_area',

    data: {
      users: [],
      park_passes: [],
      rides: [],
      recent_refresh: false,
      errors: []
    },

    mounted: function() {
      // Thinks the Vue instance's methods are undefined
      // if we don't wait for the doc to load
      $( document ).ready(function() {
        $('#logout_button').click(function() {
          admin_area_instance.logout();
        })
      });

      $('#refresh_button').click(function() {
        if (!admin_area_instance.recent_refresh) {
          admin_area_instance.get_all();

          // start the cooldown so users dont slow the server
          // from spamming the refresh button
          admin_area_instance.recent_refresh = true;
          setTimeout(function() {
            admin_area_instance.recent_refresh = false;
          }, 5000);
        } else {
          console.log("refresh too soon");
        }
      })
    },

    methods: {
      get_all: function() {

      },
      logout: function() {
        run_ajax('GET', {}, '/logout', this.logout_success);
      },
      logout_success: function(res) {
        Materialize.toast(res.message, 1000);
        setTimeout(function(){window.location.reload();}, 1200);
      }
    }
});
