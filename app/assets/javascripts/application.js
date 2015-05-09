// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require prism
//= require navigation
//= require gameboard
//= require_tree .

$(document).ready(function() {
  var load_time_stamp = $('body').data('time-stamp');
  var gameID = "game"+ $('#gameboard').data('game-id')
  var fbRef = new Firebase('https://amber-inferno-5356.firebaseio.com/');
  var indexRef = fbRef.child(gameID);

  indexRef.on('value', function(snapshot) {
    data = snapshot.val();
    updated_time_stamp = data['time_stamp'];
    if (updated_time_stamp > load_time_stamp) {
      location.reload();
    }
  }); 

});