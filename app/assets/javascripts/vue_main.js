//////////////////////////////////////////
////***         Components         ***////
//////////////////////////////////////////
Vue.component('ride-row', {
  // Defining where to look for the HTML template in the index view
  template: '#ride-template',

  // Passed elements to the component from the Vue instance
  props: {
    ride: Object
  },
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
    this.button_finder = this.finder + ' div div div.queue_cancel_wrapper a.btn';
    this.more_vert_finder = this.finder + ' div div div.queue_more_vert_wrapper';
    this.summary_finder = this.finder + ' div div div.queue_summary_wrapper';
    this.queue_details_finder = this.finder + ' div div.queue_details'

    $(this.button_finder).hide();
    $(this.more_vert_finder).click({ finder: this.button_finder }, function(event) {
      $(event.data.finder).toggle();
    });
    $(this.button_finder).click({callback: this.cancel_queue}, function(event) {
      event.data.callback();
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
      if (this.park_pass.current_queue.expected_wait == 0) {
        wait_text = "Ready";
      } else {
        wait_text = this.park_pass.current_queue.expected_wait + " min"
      }
      return wait_text
    },
    is_ready: function() {
      console.log(this.park_pass.current_queue.expected_wait);
      if (this.park_pass.current_queue.expected_wait == 0) {
        return true
      } else {
        return false
      }
    }
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
    },

    methods: {
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

