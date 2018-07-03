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
    $(this.finder + '.btn').hide();
    $(this.finder + '.queue_more_vert_wrapper').click({ finder: this.finder }, function(event) {
      $(event.data.finder + '.btn').toggle();
    });
    $(this.finder + '.btn').click({callback: this.cancel_queue}, function(event) {
      event.data.callback();
    });
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

