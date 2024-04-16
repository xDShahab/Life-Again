$(document).ready(function()

{

	window.addEventListener("message", function(event)

	{

		if(event.data.topKillers)

		{

			for(var i = 0; i < 4; i++)

			{

				if (event.data.topKillers[i] != undefined) {

					var gangName = event.data.topKillers[i].gang;

					if(gangName != "") gangName = "(" + gangName + ")";

					$('#hud #top' + (i + 1)).text(event.data.topKillers[i].name + ' ' + gangName);

					$('#hud #top' + (i + 1) + 'a #top' + (i + 1) + 'b').text(event.data.topKillers[i].kills);

				}

			}

		}

		else if(event.data.update == true)

		{

			clearInterval(x);
			if (event.data.Number) {
				if (event.data.Number == 1) {
					$(".capturedby1").text(event.data.Handeler);
				} 
				else if(event.data.Number == 2) {
					$(".capturedby2").text(event.data.Handeler);
				}
				else if(event.data.Number == 3) {
					$(".capturedby3").text(event.data.Handeler);
				}

			}
			else {
				$(".capturedby1").text(event.data.Handeler);
				$(".capturedby2").text(event.data.Handeler);
				$(".capturedby3").text(event.data.Handeler);
			}

			setProgress(event.data.Time);

		}

		else if(event.data.start == true)

		{

			$(".capturename").text(titleCase(event.data.CapName));

			// $(".captureimg").css('background-image', 'url(assets/imgs/' + event.data.CapName.toLowerCase() + '.jpg');

			$("body").fadeIn(400);

		}

		else if(event.data.stop == true)

		{

			$("body").fadeOut(400);

		}

	});



	var x

	function setProgress(time)

	{
		var distance = time+1;    
		x = setInterval(function() {
		  distance += -1;
		  var percent =  100 - (distance/12);
		  $('#myProgress').css("background-size", percent+"% 100%");
	
		  var mins = ("0" + Math.floor(distance/60)).slice(-2);
		  var secs = ("0" + Math.floor(distance%60)).slice(-2);
		  $(".time").html(mins + ":" + secs); 
	
		  if (distance <= 0) {
			clearInterval(x);
		  }
		}, 1000);

	}



	function titleCase(str) 

	{

		var splitStr = str.toLowerCase().split('_');

		for (var i = 0; i < splitStr.length; i++) 

		{

			splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     

		}

		return splitStr.join(' '); 

	}

});