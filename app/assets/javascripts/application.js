// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require rails-ujs
//= require materialize-sprockets
//= require materialize-form
//= require vue

function run_ajax(method, data, link, callback=function(res){}, err_callback=function(res){}){
  $.ajax({
    method: method,
    data: data,
    url: link,
    success: function(res) {
      console.log(res);
      callback(res);
      return true;
    },
    error: function(res) {
      console.log("error");
      console.log(res);
      err_callback(res);
      return false;
    }
  })
}

function get_eligible_passes(all_passes) {
  // get the park passes that can enter a new queue
  eligible_passes = []
  for (var i = 0; i < all_passes.length; i++) {
    this_pass = all_passes[i]
    if ((this_pass.at_park) && (!this_pass.current_queue)) {
      eligible_passes.push(this_pass);
    }
  }
  return eligible_passes;
}


$( document ).ready(function() {

});
