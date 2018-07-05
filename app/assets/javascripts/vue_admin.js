//////////////////////////////////////////
////***         Components         ***////
//////////////////////////////////////////
Vue.component('admin-ride-row', {
  // Defining where to look for the HTML template in the index view
  template: '#admin-ride-template',

  // Passed elements to the component from the Vue instance
  props: {
    ride: Object
  },

  data: function() {
    return {
        call_queue_num: 0,
    }
  },

  mounted: function() {
    this.finder = ('#' + this.ride.ride_name).replace(' ', '-').replace("'", '');
    this.summary_finder = this.finder + ' div div.ride_summary'
    this.ride_details_finder = this.finder + ' div div.ride_details';
    $(this.ride_details_finder).hide();

    $(this.summary_finder).click({finder: this.ride_details_finder }, function(event) {
      $(event.data.finder).toggle();
    })
  },

  methods: {
    update_ride: function() {

    },
    update_ride_success: function() {

    },
    update_ride_failure: function() {

    },
  }
});

//////////////////////////////////////////
////***   The Vue instance itself  ***////
//////////////////////////////////////////
var admin_area_instance = new Vue({

    el: '#admin_area',

    data: {
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
        });

        admin_area_instance.get_all();
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
        this.get_rides();
      },
      get_rides: function() {
        run_ajax('GET', {}, '/rides/index', this.set_rides, this.get_rides_failure);
      },
      set_rides: function(res) {
        this.rides = res;
      },
      get_rides_failure(res) {
        this.rides = [];
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
