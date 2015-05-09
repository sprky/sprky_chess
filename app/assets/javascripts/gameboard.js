$(document).ready(function () {

  // Selecting & Moving Pieces
  $( '#gameboard td' ).click( function() {
    $this = $(this);
    var pieceIsSelected = $( '#gameboard td' ).hasClass( 'selected' );
    var squareHasPiece = $this.find( 'img' ).length;
    var $pieceSelected = pieceSelected();

    if ( pieceIsSelected ) {
      if ( $pieceSelected.data( 'piece-id' ) == $this.data( 'piece-id' ) ) {
        deselectPiece( $this );
      } else {
          sendMove ( $pieceSelected, $this );
        }
    } else {
      selectPiece( $this );
    }

  });

  function pieceSelected() {
    return $( '#gameboard td.selected' );
  }

  function sendMove ( $pieceSelected, $destination ) {
    var piece = {
      id: $pieceSelected.data( 'piece-id' ),
      x_position: $destination.data( 'x-position' ),
      y_position: $destination.data( 'y-position' )
    }

    if ( isPawnPromotion( $pieceSelected, piece.y_position ) ) {
      openModal('#promo-modal', function( pieceType ) {
        piece.type = pieceType;
        submitAjax( piece );
      });

    } else {
      submitAjax( piece );
    }
  }

  function submitAjax( piece ) {
    $.ajax({
      type: 'PATCH',
      url: '/pieces/' + piece.id,
      dataType: 'json',
      data: { 
        piece: piece
      },
      success: function(data) {
        $(location).attr('href', data.update_url);
      }
    });
  }

  function selectPiece( $piece ) {
    var isPlayersTurn = $( '#gameboard' ).data( 'your-turn' );

    if ( isPlayersTurn ) {
      $piece.addClass( 'selected' );
    }
  }

  function deselectPiece( $piece ) {
    $piece.removeClass( 'selected' );
  }

  // Pawn Promotion
  function isPawn( $piece ) {
    return ( $piece.data('piece-type') == 'Pawn');
  }

  function isMovingToLastRank( y ) {
    return ( ( y == 0 ) || ( y == 7 ) );
  }

  function isPawnPromotion( $piece, y) {
    return ( isPawn( $piece ) && isMovingToLastRank( y ) ); 
  }

  // Modal
  function openModal ( modalId, callback ) {
    var $modal = $(modalId);

    $modal.prop("checked", true);

    if ($modal.is(":checked")) {
      $("body").addClass("modal-open");
    } else {
      $("body").removeClass("modal-open");
    }

    $(".modal-fade-screen, .modal-close").on("click", function() {
      $(".modal-state:checked").prop("checked", false).change();
    });

    $(".modal-inner").on("click", function(e) {
      e.stopPropagation();
    });

    $('.promo-selection-submit input').on('click', function() {
      callback( $('.promo-selection-choice input').val() );
    });
  }

  function isPlayersTurn() {
    return ( $( '#gameboard' ).data( 'your-turn' ) );
  }

});
