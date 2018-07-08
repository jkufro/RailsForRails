
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
      run_ajax('POST', {login_form: new_post}, '/login', this.post_success, this.set_errors);
    },
    submit_signup: function(event) {
      new_post = {
        username: this.username,
        email: this.email,
        phone: this.phone,
        password: this.password,
        password_confirmation: this.password_confirmation,
      }
      run_ajax('POST', {user: new_post}, '/users/create', this.post_success, this.set_errors);
    },
    post_success: function(res) {
      this.errors = []
      setTimeout(function(){window.location.reload();}, 1200);
    },
    set_errors: set_errors
  }
});

