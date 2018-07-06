//////////////////////////////////////////
////***         Components         ***////
//////////////////////////////////////////
Vue.component('ride_error_row', {
  // Defining where to look for the HTML template in the index view
  template: '<div class="center error_text">{{ error }}</div>',

  // Passed elements to the component from the Vue instance
  props: {
    error: String
  },
});


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
        errors: []
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
        path = '/rides/' + this.ride.id + '/update'
        ride_data = {
            ride: {
                id: this.ride.id,
                ride_name: this.ride.ride_name,
                ride_description: this.ride.ride_description,
                carts_on_track: this.ride.carts_on_track,
                ride_duration: this.ride.ride_duration,
                cart_occupancy: this.ride.cart_occupancy,
                max_allowed_queue_code: this.ride.max_allowed_queue_code,
                min_height: this.ride.min_height,
                allow_queue: this.ride.allow_queue,
                active: this.ride.active
            }
        }
        console.log()
        run_ajax('PATCH', ride_data, path, this.update_ride_success, this.update_ride_failure);
    },
    update_ride_success: function(res) {
        Materialize.toast(res.message, 1000);
        admin_area_instance.get_rides();
        this.errors = []
    },
    update_ride_failure: function(res) {
        Materialize.toast(res.responseJSON.message, 1000);
        this.errors = res.responseJSON.errors
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
