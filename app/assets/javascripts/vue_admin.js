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


Vue.component('existing-user-new-park-pass', {
  // Defining where to look for the HTML template in the index view
  template: '#existing-user-new-park-pass-template',

  data: function() {
    return {
        pass_type_id: '',
        first_name: '',
        last_name: '',
        card_number: '',
        height: 0,
        errors: []
    }
  },

  props: {
    user_id: Number,
  },

  mounted: function() {

  },

  methods: {
    create_park_pass: function() {
        path = '/park_passes/create'
        this.pass_type_id = $('#existing_user_new_park_pass_pass_type_id').val();
        pass_data = {
            park_pass: {
                user_id: this.user_id,
                pass_type_id: this.pass_type_id,
                first_name: this.first_name,
                last_name: this.last_name,
                card_number: this.card_number,
                height: this.height,
            }
        }
        run_ajax('POST', pass_data, path, this.create_park_pass_success, this.create_park_pass_failure);
    },
    create_park_pass_success: function(res) {
        Materialize.toast(res.message, 1000);
        this.first_name = '';
        this.last_name = '';
        this.card_number = '';
        this.height = 0;
    },
    create_park_pass_failure: function(res) {
        Materialize.toast(res.responseJSON.message, 1000);
        this.errors = res.responseJSON.errors;
    }
  }
});


Vue.component('existing-user-card', {
  // Defining where to look for the HTML template in the index view
  template: '#existing-user-card-template',

  data: function() {
    return {
        found_user: false,
        details_open: false,
        autocomplete_username: '',
        id: 0,
        username: '',
        email: '',
        phone: '',
        password: '',
        password_confirmation: '',
        role: '',
        active: true,
        errors: []
    }
  },

  mounted: function() {
    $('#existing_user_details').hide();

    $('#existing_user_title_area').click(function() {
        $('#existing_user_details').toggle();
    });

    this.get_usernames();
  },

  methods: {
    get_usernames: function() {
        path = "users/usernames"
        run_ajax('GET', {}, path, this.get_usernames_success, this.get_usernames_failure);
    },
    get_usernames_success: function(res) {
        finder = '#autocomplete_username';
        $(finder).autocomplete({
          onAutocomplete: this.update_vue_username_autocomplete,
          data: res,
        });
    },
    get_user: function() {
        un = this.autocomplete_username;
        if (un == '' || un == null) {
            un = 'l';
        }
        path = 'users/show_by_username/' + un
        run_ajax('GET', {}, path, this.get_user_success, this.get_user_failure);
    },
    get_user_success: function(res) {
        this.found_user = true;

        this.id = res.id;
        this.username = res.username;
        this.email = res.email;
        this.phone = res.phone;
        this.password = '';
        this.password_confirmation = '';
        this.role = res.role;
        this.active = res.active;

        setTimeout(function() {
            Materialize.updateTextFields();
        }, 200);
    },
    get_user_failure: function(res) {
        Materialize.toast(res.responseJSON.message, 1000);
    },
    update_vue_username_autocomplete: function() {
        val = $('#autocomplete_username').val();
        this.autocomplete_username = val;
    },
    get_usernames_failure: function(res) {
        Materialize.toast("Failed To Retrieve Usernames", 1000);
    },
    update_user: function() {
        path = '/users/' + this.id + '/update'
        this.role = $('#existing_user_role').val();
        user_data = {
            user: {
                username: this.username,
                email: this.email,
                phone: this.phone,
                password: this.password,
                password_confirmation: this.password_confirmation,
                role: this.role,
                active: this.active
            }
        }
        run_ajax('PATCH', user_data, path, this.update_user_success, this.update_user_failure);
    },
    update_user_success: function(res) {
        Materialize.toast(res.message, 1000);
        this.username = '';
        this.email = '';
        this.phone = '';
        this.password = '';
        this.password_confirmation = '';
        this.role = '';
        this.active = true;
        this.errors = [];
        this.found_user = false;
        this.get_usernames();
    },
    update_user_failure: function(res) {
        Materialize.toast(res.responseJSON.message, 1000);
        this.errors = res.responseJSON.errors;
    },
    delete_user: function() {
        path = 'users/' + this.id
        run_ajax('DELETE', {}, path, this.delete_user_success, this.delete_user_failure);
    },
    delete_user_success: function(res) {
        Materialize.toast(res.message, 1000);
        this.found_user = false;
        this.get_usernames();
    },
    delete_user_failure: function(res) {
        Materialize.toast(res.responseJSON.message, 1000);
        this.errors = res.responseJSON.errors;
    }
  }
});


Vue.component('new-user-card', {
  // Defining where to look for the HTML template in the index view
  template: '#new-user-card-template',

  data: function() {
    return {
        details_open: false,
        username: '',
        email: '',
        phone: '',
        password: '',
        password_confirmation: '',
        role: '',
        active: true,
        errors: []
    }
  },

  mounted: function() {
    $('#new_user_form_area').hide();

    $('#new_user_title_area').click(function() {
        $('#new_user_form_area').toggle();
    });
  },

  methods: {
    create_user: function() {
        path = '/users/create'
        this.role = $('#new_user_role').val()
        user_data = {
            user: {
                username: this.username,
                email: this.email,
                phone: this.phone,
                password: this.password,
                password_confirmation: this.password_confirmation,
                role: this.role,
                active: this.active
            }
        }
        run_ajax('POST', user_data, path, this.create_user_success, this.create_user_failure);
    },
    create_user_success: function(res) {
        Materialize.toast(res.message, 1000);
        this.username = '';
        this.email = '';
        this.phone = '';
        this.password = '';
        this.password_confirmation = '';
        this.role = '';
        this.active = true;
        this.errors = [];
    },
    create_user_failure: function(res) {
        Materialize.toast(res.responseJSON.message, 1000);
        this.errors = res.responseJSON.errors;
    }

  }
});


Vue.component('new-ride-card', {
  // Defining where to look for the HTML template in the index view
  template: '#new-ride-card-template',

  data: function() {
    return {
        details_open: false,
        ride: {
            ride_name: '',
            ride_description: '',
            carts_on_track: 0,
            ride_duration: 0,
            cart_occupancy: 0,
            max_allowed_queue_code: 'AAAA',
            min_height: 0,
            allow_queue: true,
            ride_image_url: '',
            active: true
        },
        errors: []
    }
  },

  mounted: function() {
    $('#new_ride_form_area').hide();

    $('#new_ride_title_area').click(function() {
        $('#new_ride_form_area').toggle();
    });
  },

  methods: {
    create_ride: function() {
        path = '/rides/create'
        ride_data = {
            ride: this.ride
        }
        run_ajax('POST', ride_data, path, this.create_ride_success, this.create_ride_failure);
    },
    create_ride_success: function(res) {
        Materialize.toast(res.message, 1000);
        admin_area_instance.get_rides();
        this.errors = []
        this.ride = {
            ride_name: '',
            ride_description: '',
            carts_on_track: 0,
            ride_duration: 0,
            cart_occupancy: 0,
            max_allowed_queue_code: 'AAAA',
            min_height: 0,
            allow_queue: true,
            ride_image_url: '',
            active: true
        }
    },
    create_ride_failure: function(res) {
        Materialize.toast(res.responseJSON.message, 1000);
        this.errors = res.responseJSON.errors;
    }

  }
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
        check_in_choice: '',
        check_in_autocomplete_instance: null,
        details_open: false,
        errors: []
    }
  },

  mounted: function() {
    this.finder = '#ride-' + this.ride.id;
    this.summary_finder = this.finder + ' div div.ride_card_summary'
    this.ride_details_finder = this.finder + ' div div.ride_details';
    this.ride_queues_autocomplete_finder = '#ride_' + this.ride.id + '_queues_autocomplete';
    $(this.ride_details_finder).hide();
    this.image_finder = this.finder + ' div.card-image'

    this.init_summary_toggle(this.summary_finder + ',' + this.image_finder, this.ride_details_finder);

    this.get_security_codes();
  },

  methods: {
    init_summary_toggle: function(summary_finder, ride_details_finder) {
        $(summary_finder).click({finder: ride_details_finder, obj: this}, function(event) {
            $(event.data.finder).toggle();
        });
    },
    flip_expand_icon: function() {
        this.details_open = ! this.details_open;
    },
    update_vue_checkin_autocomplete: function() {
        ride_queues_autocomplete_finder = '#ride_' + this.ride.id + '_queues_autocomplete';
        val = $(ride_queues_autocomplete_finder).val();
        this.check_in_choice = val;
    },
    get_security_codes: function() {
        path = '/rides/' + this.ride.id + '/ready_security_codes'
        run_ajax('GET', {}, path, this.set_security_codes, this.get_security_codes_failure);
    },
    set_security_codes: function(res) {
        finder = '#ride_' + this.ride.id + '_queues_autocomplete';
        $(finder).autocomplete({
          onAutocomplete: this.update_vue_checkin_autocomplete,
          data: res,
        });
    },
    check_in_rider: function() {
        choice = this.check_in_choice
        if (choice == '' || choice == null) {
            choice = 'null';
        }
        path = '/rides/' + this.ride.id + '/check_in/' + choice;
        run_ajax('GET', {}, path, this.check_in_rider_success, this.check_in_rider_failure);
    },
    check_in_rider_success: function(res) {
        Materialize.toast(res.message, 1000);
        this.check_in_choice = '';
        this.get_security_codes();
        this.ride.num_not_checked_in -= 1;
    },
    check_in_rider_failure: function (res) {
        Materialize.toast(res.responseJSON.message, 1000);
        this.get_security_codes();
    },
    get_security_codes_failure: function(res) {
        Materialize.toast("Failed To Update Check In Security Codes", 2000);
    },
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
                ride_image_url: this.ride.ride_image_url,
                active: this.ride.active
            }
        }
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
    reset_queue: function() {
        path = '/rides/' + this.ride.id + '/reset_queue'
        run_ajax('GET', {}, path, this.reset_queue_success, this.reset_queue_failure);
    },
    reset_queue_success: function(res) {
        Materialize.toast(res.message, 1000);
        admin_area_instance.get_rides();
    },
    reset_queue_failure: function(res) {
        Materialize.toast(res.responseJSON.message, 1000);
        admin_area_instance.get_rides();
    },
    clear_queue: function() {
        path = '/rides/' + this.ride.id + '/clear_queue'
        run_ajax('GET', {}, path, this.reset_queue_success, this.reset_queue_failure);
    },
    call_queue: function() {
        path = '/rides/' + this.ride.id + '/call/' + this.call_queue_num
        run_ajax('GET', {}, path, this.call_queue_success, this.call_queue_failure);
    },
    call_queue_success: function(res) {
        this.call_queue_num = 0
        Materialize.toast(res.message, 1000);
        admin_area_instance.get_rides();
    },
    call_queue_failure: function(res) {
        Materialize.toast(res.responseJSON.message, 1000);
        admin_area_instance.get_rides();
    },
    delete_ride: function() {
        path = '/rides/' + this.ride.id
        run_ajax('DELETE', {}, path, this.delete_ride_success, this.delete_ride_failure);
    },
    delete_ride_success: function(res) {
        Materialize.toast(res.message, 1000);
        admin_area_instance.get_rides();
    },
    delete_ride_failure: function(res) {
        Materialize.toast(res.responseJSON.message, 1000);
        admin_area_instance.get_rides();
    }
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
