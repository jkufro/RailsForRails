//////////////////////////////////////////
////***         Components         ***////
//////////////////////////////////////////
Vue.component('login_signup_error_row', {
  // Defining where to look for the HTML template in the index view
  template: '<div class="center error-text">{{ error }}</div>',

  // Passed elements to the component from the Vue instance
  props: {
    error: String
  },
});


//////////////////////////////////////////
////***  The Vue instance itself   ***////
//////////////////////////////////////////
var login_instance = new Vue({

    el: '#login_signup_area',

    data: {
      username: '',
      email: '',
      phone: '',
      password: '',
      password_confirmation: '',
      errors: []
    },

    mounted: function() {
      $('#login_area').keypress(function(e) {
        if(e.which == 13) {
          login_instance.submit_login();
        }
      });

      $('#signup_area').keypress(function(e) {
        if(e.which == 13) {
          login_instance.submit_signup();
        }
      });
    },

    methods: {
    submit_login: function(event) {
      new_post = {
        username: this.username,
        password: this.password
      }
      run_ajax('POST', {login_form: new_post}, '/login', this.post_success, this.post_failure);
    },
    submit_signup: function(event) {
      new_post = {
        username: this.username,
        email: this.email,
        phone: this.phone,
        password: this.password,
        password_confirmation: this.password_confirmation,
      }
      run_ajax('POST', {user: new_post}, '/users/create', this.post_success, this.post_failure);
    },
    post_success: function(res) {
      this.errors = []
      Materialize.toast(res.message, 1000);
      setTimeout(function(){window.location.reload();}, 1200);
    },
    post_failure: function(res) {
      this.errors = res.responseJSON.errors
      Materialize.toast(res.responseJSON.message, 3000);
    }
  }
});

