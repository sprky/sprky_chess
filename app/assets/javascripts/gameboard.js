$(document).ready(function () {
  // Moves

  $('#gameboard td').click( function() {
    $this = $(this);
    var pieceIsSelected = $this.hasClass('piece-selected');
    var squareHasPiece = $this.find('img').length;

    if (squareHasPiece) {
      selectPiece($this);
    } 

    if (pieceIsSelected) {
      deselectPiece($this);
    }
  });

  function togglePieceSelect(piece) {

  }

  function selectPiece(piece) {
    console.log('selected a ' + piece.data('piece-type'));
    piece.addClass('piece-selected');
    return piece;
  }

  function deselectPiece(piece) {
    console.log('deslected a ' + piece.data('piece-type'));
    piece.removeClass('piece-selected');
  }

  function selectDestination() {

  }

  // Pawn Promotion
  function isPawn(piece) {

  }

  function isMovingToLastRank(piece, y) {

  }

  function isPawnPromotion(piece, y) {
    if(isPawn(piece) && isMovingToLastRank(piece, y)) {
      return true;
    } else {
      return false;
    }
  }

  // Logic Methods
  function isPlayersTurn() {
    if ($('#gameboard').data('your-turn')) {
      return true;
    } else {
      return false;
    }
  }

});
