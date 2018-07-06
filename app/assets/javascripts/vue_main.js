//////////////////////////////////////////
////***         Components         ***////
//////////////////////////////////////////
Vue.component('ride-row', {
  // Defining where to look for the HTML template in the index view
  template: '#ride-template',

  // Passed elements to the component from the Vue instance
  props: {
    ride: Object,
    park_passes: Array
  },

  mounted: function() {
    this.finder = ('#ride-' + this.ride.id);
    this.image_finder = this.finder + ' div.card-image'
    this.summary_finder = this.finder + ' div.card-content div.ride_summary'
    this.ride_details_finder = this.finder + ' div.card-content div.ride_details';
    $(this.ride_details_finder).hide();

    $(this.summary_finder + ',' + this.image_finder).click({finder: this.ride_details_finder }, function(event) {
      $(event.data.finder).toggle();
    });
  },

  methods: {
    create_queue: function(pass_id) {
      path = '/queues/' + this.ride.id + '/create/' + pass_id
      run_ajax('GET', {}, path, this.create_queue_success, this.create_queue_failure);
    },
    create_queue_success: function(res) {
      Materialize.toast(res.message, 1000);
      main_area_instance.get_park_passes();
      main_area_instance.get_rides();
    },
    create_queue_failure: function(res) {
      Materialize.toast(res.responseJSON.message, 1000);
      main_area_instance.get_park_passes();
      main_area_instance.get_rides();
    },
    has_eligible_passes: function() {
      if (get_eligible_passes(this.park_passes).length > 0) {
        return true
      } else {
        return false;
      }
    }
  }
});

Vue.component('current-queue-row', {
  // Defining where to look for the HTML template in the index view
  template: '#current-queue-template',

  // Passed elements to the component from the Vue instance
  props: {
    park_pass: Object
  },

  mounted: function() {
    this.finder = '#' + this.park_pass.current_queue.security_code;
    this.cancel_icon_finder = this.finder + ' div div div.queue_more_vert_wrapper div div i.cancel_queue_button';
    this.more_vert_finder = this.finder + ' div div div.queue_more_vert_wrapper';
    this.summary_finder = this.finder + ' div div div.queue_summary_wrapper';
    this.queue_details_finder = this.finder + ' div div.queue_details'

    $(this.cancel_icon_finder).hide();
    $(this.more_vert_finder).click({ finder: this.cancel_icon_finder }, function(event) {
      $(event.data.finder).toggle();
    });

    $(this.summary_finder).click({ finder: this.queue_details_finder }, function(event) {
      $(event.data.finder).toggle();
    });

    $(this.queue_details_finder).hide();
  },

  methods: {
    cancel_queue: function() {
      path = '/queues/' + this.park_pass.current_queue.id + '/cancel'
      run_ajax('GET', {}, path, this.cancel_queue_success, this.cancel_queue_failure);
    },
    cancel_queue_success: function(res) {
      Materialize.toast(res.message, 1000);
      main_area_instance.get_park_passes();
    },
    cancel_queue_failure: function(res) {
      Materialize.toast('Failed To Cancel Queue', 1000);
      main_area_instance.get_park_passes();
    },
    queue_context_text: function() {
      return this.park_pass.first_name + " - " + this.park_pass.current_queue.ride_name + " "
    },
    queue_wait_text: function() {
      if (this.park_pass.current_queue.is_ready) {
        wait_text = "Ready";
      }
      else if (this.park_pass.current_queue.expected_wait == 0) {
        wait_text = "< 1 min"
      } else {
        wait_text = this.park_pass.current_queue.expected_wait + " min"
      }
      return wait_text
    },
  },
});

//////////////////////////////////////////
////***   The Vue instance itself  ***////
//////////////////////////////////////////
var main_area_instance = new Vue({

    el: '#main_area',

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
        main_area_instance.get_rides();
        main_area_instance.get_users();
        main_area_instance.get_park_passes();

        $('#logout_button').click(function() {
          main_area_instance.logout();
        })
      });

      $('#refresh_button').click(function() {
        if (!main_area_instance.recent_refresh) {
          main_area_instance.get_users();
          main_area_instance.get_park_passes();
          main_area_instance.get_rides();

          // start the cooldown so users dont slow the server
          // from spamming the refresh button
          main_area_instance.recent_refresh = true;
          setTimeout(function() {
            main_area_instance.recent_refresh = false;
          }, 5000);
        } else {
          console.log("refresh too soon");
        }
      })
    },

    methods: {
      has_queues: function() {
        for (var i = 0; i < this.park_passes.length; i++) {
          this_pass = this.park_passes[i]
          if (this_pass.current_queue) {
            return true;
          }
          return false;
        }
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
      get_users: function() {
        run_ajax('GET', {}, '/users/index', this.set_users, this.get_users_failure);
      },
      set_users: function(res) {
        this.users = res;
      },
      get_park_passes: function() {
        run_ajax('GET', {}, '/park_passes/index', this.set_park_passes, this.get_park_passes_failure);
      },
      set_park_passes: function(res) {
        this.park_passes = res;
      },
      get_park_passes_failure: function() {
        this.park_passes = [];
      },
      get_users_failure(res) {
        this.users = [];
      },
      post_success: function(res) {
        this.errors = []
        Materialize.toast(res.message, 1000);
      },
      post_failure: function(res) {
        this.errors = res.responseJSON.errors
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

