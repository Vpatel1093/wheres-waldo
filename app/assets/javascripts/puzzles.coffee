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
      clickCorrect = correctCharacterAndClickLocation(characterSelected)
      if (clickCorrect) {
          successMessage();
          hideCharacter();
          checkForGameOver();
      } else {
        tryAgainMessage();
      };
    };

    function correctCharacterAndClickLocation(characterSelected) {
      var puzzleID = $('.puzzle').attr('id');
      var characterSelected = characterSelected.text();
      var characters = [];
      var character = '';
      $.ajax({
        type: "GET",
        dataType: "json",
        url: "/puzzles/" + puzzleID,
        success: function(data) {
          characters = JSON.parse(JSON.stringify(data))
          character = getValueByKey("name", characterSelected, characters)
        }
      });
      if (character && clickInCharacterSpace(character)) {
        return true;
      } else {
        return false;
      };
    };

    function getValueByKey(key,valueSelected,data) {
      for (i = 0; i < data.length; i++) {
        if (data[i][key] == valueSelected) {
          return data[i];
        }
      }
    }

    function clickInCharacterSpace(character) {
      if (clickX > character["top_left_x"] && clickX < character["bot_right_x"]) {
        if (clickY > character["top_left_y"] && clickY < character["bot_right_y"]) {
          return true;
        };
      } else {
        return false;
      };
    };

    function successMessage() {
      alert("success");
    };

    function hideCharacter() {

    };

    function checkForGameOver() {

    };

    function tryAgainMessage() {

    };

    document.addEventListener('click', function(click) {
      if(!$(click.target).is('.selection-menu div, .selection-menu')) {
        updateMenuAndClickCoords(click);
      }
    });

    $('button').click(function() {
      checkCharacterSelection($(this));
    });
  });`
