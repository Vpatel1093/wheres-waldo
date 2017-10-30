jQuery ->
  `$(document).ready(function() {
    var clickX;
    var clickY;
    var menu;
    var menuPositionX;
    var menuPositionY;

    var rect = $('.puzzle-image')[0].getBoundingClientRect();
    var puzzleTop = rect.top;
    var puzzleLeft = rect.left;
    var puzzleHeight = rect.bottom;

    function updateMenuAndClickCoords(click) {
      menu = $('.selection-menu')
      // Only update click coordinates if character selection menu is not open
      if (menu.hasClass('closed')) {
        getClickCoords(click);
      };
      openCloseMenu();
    };

    function getClickCoords(click) {
      menuPositionX = click.pageX;
      menuPositionY = click.pageY;
      clickX = click.pageX - puzzleLeft;
      clickY = click.pageY - puzzleTop;
    };

    function openCloseMenu() {
      if (clickX > 0 && clickX < 1104) {
        if (clickY > 0 && clickY < puzzleHeight) {
          if (menu.hasClass('closed')) {
            menu.removeClass('closed').addClass('open');
            menu.css('top', menuPositionY);
            menu.css('left', menuPositionX);
          } else if (menu.hasClass('open')) {
            menu.removeClass('open').addClass('closed');
          };
        };
      };
    };

    function checkCharacterSelection(characterSelected) {
      alert((characterSelected).text());
    };

    document.addEventListener('click', function(click) {
      if(!$(click.target).is('.selection-menu div, .selection-menu')) {
        updateMenuAndClickCoords(click);
      }
    });

    $('button').click(function() {
      checkCharacterSelection($(this));
    });

    $(document).on("click", function(event) {
      alert("x: " + (event.pageX-puzzleLeft) + " y: " + (event.pageY-puzzleTop))
    })
  });`
