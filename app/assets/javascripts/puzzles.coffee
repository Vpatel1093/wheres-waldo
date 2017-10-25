jQuery ->
  `$(document).ready(function() {
    var clickX;
    var clickY;

    var rect = $('.puzzle-image')[0].getBoundingClientRect();
    var puzzleTop = rect.top;
    var puzzleLeft = rect.left;

    function wheresWaldo(click) {
      getClickCoords(click);
      evaluateClick();
    };

    function getClickCoords(click) {
      clickX = click.pageX - puzzleLeft;
      clickY = click.pageY - puzzleTop;
      console.log(clickX, clickY);
    };

    function evaluateClick() {

    };

    document.addEventListener('click', function(click) {
      wheresWaldo(click);
    });
  });`
