jQuery ->
  `$('.show').ready(function() {
    var clickX;
    var clickY;
    var menu;
    var menuPositionX;
    var menuPositionY;
    var timeStart;
    var formattedTime
    var gameInPlay = true;

    var rect = $('.puzzle-image')[0].getBoundingClientRect();
    scrollLeft = window.pageXOffset;
    scrollTop = window.pageYOffset;
    var puzzleLeft = rect.left + scrollLeft || document.documentElement.scrollLeft;
    var puzzleTop = rect.top + scrollTop || document.documentElement.scrollTOP;
    var puzzleHeight = rect.bottom-rect.top;

    function startTimer() {
      if (gameInPlay) {
        timeStart = timeStart || new Date();
        var timeNow = new Date();
        var displayTime = Math.abs(timeNow - timeStart)/1000;
        var h = Math.floor(displayTime/3600);
        var m = Math.floor(60*(((displayTime)/3600)%1));
        var s = Math.floor(displayTime%60);
        m = checkTime(m);
        s = checkTime(s);
        formattedTime = h + ":" + m + ":" + s;
        $('#timer').text(formattedTime);
        var t = setTimeout(startTimer, 500);
      } else if (gameInPlay == false) {
        submitScore(formattedTime);
      };
    };

    function checkTime(i) {
      // add zero in front of numbers < 10
      if (i < 10) {i = "0" + i};
      return i;
    };

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
      var puzzleID = $('.puzzle').attr('id');
      var characterSelected = characterSelected.text();
      getCharacterObject(characterSelected, puzzleID)
    };

    function getCharacterObject(characterSelected, puzzleID) {
      var characters = [];
      var characterObject = '';
      return $.ajax({
        type: "GET",
        dataType: "json",
        url: "/puzzles/" + puzzleID,
        success: function(data) {
          characters = JSON.parse(JSON.stringify(data))
          characterObject = getValueByKey("name", characterSelected, characters)
          if (clickInCharacterSpace(characterObject)) {
            displaySuccessMessage();
            hideCharacter(characterSelected);
            markCharacter(characterSelected,
                          characterObject["top_left_y"],
                          characterObject["top_left_x"],
                          characterObject["bot_right_y"]-characterObject["top_left_y"],
                          characterObject["bot_right_x"]-characterObject["top_left_x"]);
            checkForGameOver();
          } else {
            displayTryAgainMessage();
          };
        }
      });
    };

    function getValueByKey(key,valueSelected,data) {
      for (i = 0; i < data.length; i++) {
        if (data[i][key] == valueSelected) {
          return data[i];
        }
      }
    }

    function clickInCharacterSpace(characterObject) {
      if (clickX > characterObject["top_left_x"] && clickX < characterObject["bot_right_x"]) {
        if (clickY > characterObject["top_left_y"] && clickY < characterObject["bot_right_y"]) {
          return true;
        };
      } else {
        return false;
      };
    };

    function displaySuccessMessage() {
      var successMessage = $('.success');
      successMessage.removeClass('closed').addClass('open');
      successMessage.css('top', menuPositionY);
      successMessage.css('left', menuPositionX);
    };

    function hideCharacter(characterSelected) {
      $('#' + characterSelected).addClass('closed');
    };

    function markCharacter(characterSelected, top, left, height, width) {
      $('.' + characterSelected).css('top', top + puzzleTop);
      $('.' + characterSelected).css('left', left + puzzleLeft);
      $('.' + characterSelected).height(height);
      $('.' + characterSelected).width(width);
      $('.' + characterSelected).removeClass('closed');
    }

    function checkForGameOver() {
      if($('.remaining-character.closed').length == $('.remaining-character').length) {
        gameInPlay = false;
      };
    };

    function displayTryAgainMessage() {
      tryAgainMessage = $('.try-again');
      tryAgainMessage.css('top', menuPositionY);
      tryAgainMessage.css('left', menuPositionX);
      tryAgainMessage.removeClass('closed').addClass('open');
    };

    function hideOpenMessages() {
      $('.message.open').removeClass('open').addClass('closed');
    };

    function submitScore(formattedScore) {
      $('.submit-score').removeClass('closed');
      $('.score-form div:last-of-type input').val(formattedScore);
    }

    document.addEventListener('click', function(click) {
      if(!$(click.target).is('.selection-menu div, .selection-menu, button')) {
        hideOpenMessages();
        updateMenuAndClickCoords(click);
      }
    });

    $('button').click(function() {
      checkCharacterSelection($(this));
      openCloseMenu();
    });

    $(document).on('turbolinks:load', function() {
      timeStart = new Date();
    });

    startTimer();
  });`
