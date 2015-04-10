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
//= require_tree .


$(document).ready(function() {

  //this will be triggered by clicking select game
  $('.select-game-link').click( function()  {
    var game_id = $("input[name='game_id']").val();
    if (game_id) {
      var url = '/games/'+game_id;
      $(location).attr('href', url);
    }
  });

  // Navigation
  var menuToggle = $('#js-mobile-menu').unbind();
  $('#js-navigation-menu').removeClass("show");

  menuToggle.on('click', function(e) {
    e.preventDefault();
    $('#js-navigation-menu').slideToggle(function(){
      if($('#js-navigation-menu').is(':hidden')) {
        $('#js-navigation-menu').removeAttr('style');
      }
    });
  });

  // boolean to determine if a piece has been selected
  var piece_selected = false;
  // set up variables for ajax call
  var piece_x_position,
      piece_y_position,
      destination_x_position,
      destination_y_position,
      piecePathUrl;
  
  // set up click listener for all tds on gameboard
  $('#gameboard td').click( function() {
    if (piece_selected) {
      // a piece has already been selected, look for destination
      if ( $(this).hasClass('piece-selected') ) {
        // if this was the piece that was already selected, deselect and reset
        deselectPiece(this);
      } else {
        // this must be the destination, make ajax call for a move
        sendMove(this);
      }
    } else {
      // no piece has been selected, select this piece
      selectPiece(this);
    }
  });

  function deselectPiece( piece ) {
    $(piece).removeClass('piece-selected');
    piece_selected = false;
  }

  // this piece (passed as this from click handler) was 
  // selected, give it a styling class, set 
  // boolean and variables
  function selectPiece( piece ) {
    var pieceId = $(piece).data("piece-id");
    // can't select a square that doesn't have a piece

    var isYourTurn = $('#gameboard').data('your-turn');
    // can only select a square if it's your turn and there's a piece on the square  
    if (isYourTurn && ( pieceId != "" )) {
      $(piece).addClass('piece-selected');
      piece_selected = true; 
      piece_x_position = $(piece).data("x-position");
      piece_y_position = $(piece).data("y-position");
      piecePathUrl = '/pieces/' + pieceId;
    }
  }

  function sendMove( destination ) {
    // source and destination are selected, send ajax call
    destination_x_position = $(destination).data("x-position");
    destination_y_position = $(destination).data("y-position");

    $.ajax({
      type: 'PUT',
      url: piecePathUrl,
      dataType: 'json',
      data: { piece: { 
              x_position: destination_x_position,
              y_position: destination_y_position 
              }
            },
      success: function(data) {
        $(location).attr('href', data.update_url);
      }
    });   
  }

  var gameID = $('#gameboard').data('game-id')
  var fbRef = new Firebase('https://amber-inferno-5356.firebaseio.com/');
  var indexRef = fbRef.child('moves');

  function updateGame(snap, Id) {
    if (snap.key() == 'game')
      console.log('refresh game # ',snap.val() );
      console.log(Id);
  }

  indexRef.on('child_added', updateGame);
  
 
});
