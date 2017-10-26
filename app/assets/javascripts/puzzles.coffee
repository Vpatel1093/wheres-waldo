jQuery ->
  `$(document).ready(function() {
    var clickX;
    var clickY;
    var menuPositionX;
    var menuPositionY;

    var rect = $('.puzzle-image')[0].getBoundingClientRect();
    var puzzleTop = rect.top;
    var puzzleLeft = rect.left;
    var puzzleHeight = rect.bottom;

    function wheresWaldo(click) {
      getClickCoords(click);
      evaluateClick();
    };

    function getClickCoords(click) {
      menuPositionX = click.pageX;
      menuPositionY = click.pageY;
      clickX = click.pageX - puzzleLeft;
      clickY = click.pageY - puzzleTop;
    };

    function evaluateClick() {
      // Show and move select menu
      if (clickX > 0 && clickX < 1100) {
        if (clickY > 0 && clickY < puzzleHeight) {
          $('.selection-menu').show();
          $('.selection-menu').css('top', menuPositionY);
          $('.selection-menu').css('left', menuPositionX);
        }
      }
    };

    document.addEventListener('click', function(click) {
      wheresWaldo(click);
    });
  });`
