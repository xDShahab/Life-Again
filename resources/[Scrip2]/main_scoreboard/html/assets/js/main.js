$(document).ready(function() {
    $(".fox-block").css({
        "background-color": "rgba(0, 0, 0, 0.54)",
        "width": "38.1vw",
        "height": "18.2vw",
        "border-radius": "2vw 0.5vw 0.5vw 0vw",
    });
    $(".fox-block-11").css({
        "width": "18vw",
        "margin-right": "15vw",
        "margin-left": "18.75vw",
        "padding-left": "0vw",
        "border-radius": "0.2vw",
        "background-color": "#1e1e1e",
        "transform": "translate(-2vw, 1.9vw)",
    })
    $(".heading").css({
        "font-family": "Exo, sans-serif",
        "color": "#fafafa",
        "font-size": "1.3vw",
        "text-align": "center",
        "text-transform": "uppercase",
    })
    $(".fox-block-2").css({
        "position": "absolute",
        "display": "-webkit-box",

        "align-items": "center",
        "border": "0.1vw none #000",
        "border-radius": "13vw",
        "background-color": "#1e1e1e",
        "transform": "translate(-9.1vw, -0.3vw)",
    })
    $(".fox-block-17").css({
        "width": "5.65vw",
        "height": "5.65vw",
        "border-radius": "0.71vw",
        "background-image": "linear-gradient(18deg, #444343, #1b1a1b)",
        "box-shadow": "0 0 0.47vw -0.059vw #000",
    })
    $(".fox-block-18").css({
        "width": "60vw",
        "height": "60vw",
        "transform": "translate(3.09vw, -0.83vw)",
    })
    $(".fox-block-16").css({
        "margin-top": "30vw",
        "margin-left": "290vw",
    })
    $(".heading-6").css({
        "margin-top": " 0.14vw",
        "font-family": "Exo, sans-serif",
        "color": "rgb(202, 5, 5)",
        "font-size": "1.90vw",
        "line-height": "0vw",
        "font-weight": "500",
        "text-align": "center",
    })
    $(".heading-7").css({
        "transform": "translate(10vw, -5.11vw)",
        "font-family": "Exo, sans-serif",
        "color": "#b2b0ba0",
        "font-size": "0.89vw",
        "line-height": "0vw",
        "font-weight": "400",
    })
    $(".fox-block-20").css({
        "width": "10.038095238095238vw",
        "height": "8.65vw",
        "border-radius": " 0.514vw",
        "background-image": "linear-gradient(18deg, #444343, #1b1a1b)",
        "box-shadow": "0 0 0.9000007vw -0.059vw #000",
    })
    $(".fox-block-25").css({
        "width": "6.25vw",
        "height": "0.47vw",
        "margin-top": "2.47vw",
        "margin-left": "1.89vw",
        "border-radius": "1.95vw",
        "background-color": "rgb(202, 5, 5)",
    })
    $(".fox-block-26").css({
        "width": "2.8vw",
        "height": "0.47vw",
        "margin-top": "0.47vw",
        "margin-left": "0.41vw",
        "border-radius": "1.19vw",
        "background-color": "#36e28b",
        "color": "#333",
    })

    $(".fox-block-27").css({
        "margin-left": "3.0vw",
        "-webkit-box-pack": "center",
        "-webkit-justify-content": "center",
        "-ms-flex-pack": "center",
        "justify-content": "center",
        "-webkit-box-align": "center",
        "-webkit-align-items": "center",
        "-ms-flex-align": "center",
        "margin-top": "1vw",
        "align-items": "center",
        "transform": "translate(0vw, -11.904761904761905vw)",
    })
    $(".fox-block-28").css({
        "width": "16vw",
        "height": "5vw",
        "border-radius": "0.714vw",
        "background-position": "0vw 0vw",
        "background-size": "cover",
        "box-shadow": "0.359vw 0 0.47vw -0.059vw #000"
    })
    $(".text-block-2").css({
        "font-family": "Exo, sans-serif",
        "color": "#b2b0b0",
        "font-weight": "700",
        "text-transform": "uppercase",
    })
});


var visable = false;
let shows = {
    "mechanic": true,
    "police": true,
    "weazel": true,
    "ambulance": true,
    "taxi": true,
    "government": true,
    "sheriff": true
};

// Designed BY XS


function getOnlineAdmins(admins) {
    $('#admins').text(admins);
};


window.addEventListener('message', (event) => {
    let data = event.data;



    switch (data.action) {




        case 'toggle':
            if (visable) {

                $('#mainbody').css("display", "none");

            } else {
                $('#mainbody').css("display", "block");



            }

            visable = !visable;
            break;

        case 'close':
            {
                $('#mainbody').fadeOut();
                break;
            };




        case 'getOnlineAdmins':
            {
                getOnlineAdmins(data.admins);
                break;
            };

        case 'updateServerInfo':
            {
                $('#timeplay').text(data.playTime);
                break;
            };

        case 'setID':
            {
                $('#pid').text(data.source);
                break;
            };




        case 'updatePlayerJobs':
            var jobs = event.data.jobs;
            $('#slot').text(jobs.player_count + '/240');
            break;

        case 'updateInfo':
            if (event.data.data) {
                var JobData = event.data.data;

                $('#ambulance').html(JobData.medic);
                $('#police').html(JobData.police);
                $('#taxi').html(JobData.taxi);
                $('#dadgostari').html(JobData.dadgostari);
                $('#sheriff').html(JobData.sheriff);
                $('#mechanic').html(JobData.mechanic);

                $('#dadgostari').html(JobData.dadgostari);

                Jewelery(JobData.police);
                Bank(JobData.police);
                Shop(JobData.police);
                MBank(JobData.police);
                LIRob(JobData.police);
            };
            break;
            // Designed BY XS
    };
});



function Jewelery(cops) {
    if (cops >= 1) {
        $('#jewelry').addClass("fox-active-block-12");
        $('#jewelry').removeClass('fox-deactive-block-12');
    } else {
        $('#jewelry').addClass("fox-deactive-block-12");
        $('#jewelry').removeClass('fox-active-block-12');
    };
};

function MBank(cops) {
    if (cops >= 1) {
        $('#bank').addClass("fox-active-block-12");
        $('#bank').removeClass('fox-deactive-block-12');
    } else {
        $('#bank').addClass("fox-deactive-block-12");
        $('#bank').removeClass('fox-active-block-12');
    };
};

function Shop(cops) {
    if (cops >= 1) {
        $('#shop').addClass("fox-active-block-12");
        $('#shop').removeClass('fox-deactive-block-12');
    } else {
        $('#shop').addClass("fox-deactive-block-12");
        $('#shop').removeClass('fox-active-block-12');
    };
};

function Bank(cops) {
    if (cops >= 1) {
        $('#cbank').addClass("fox-active-block-12");
        $('#cbank').removeClass('fox-deactive-block-12');
    } else {
        $('#cbank').addClass("fox-deactive-block-12");
        $('#cbank').removeClass('fox-active-block-12');
    };
};

function LIRob(cops) {
    if (cops >= 1) {
        $('#bimeh').addClass("fox-active-block-12");
        $('#bimeh').removeClass('fox-deactive-block-12');
    } else {
        $('#bimeh').addClass("fox-deactive-block-12");
        $('#bimeh').removeClass('fox-active-block-12');
    };
};



var visable = false;

$(function () {
	window.addEventListener('message', function (event) {

		switch (event.data.action) {
			case 'scrollUP':
				$("#style-1").scrollTop($("#style-1").scrollTop()-100);
				break;

			case 'scrollDOWN':
				$("#style-1").scrollTop($("#style-1").scrollTop()+100);
				break;

			case 'updatePlayerJobs':
				var jobs = event.data.jobs;

				$('#player_count').html(jobs.player_count);

				$('#ambulance').html(jobs.ems);
				$('#police').html(jobs.police);
				$('#taxi').html(jobs.taxi);
				$('#mechanic').html(jobs.mechanic);
				$('#sheriff').html(jobs.sheriff);
                $('#dadgostari').html(jobs.dadgostari);
                $('#bahamas').html(jobs.bahamas);
				break;

			case 'updatePlayerList':
				$('#playerlist tr:gt(0)').remove();
				$('#playerlist').append(event.data.players);
				applyPingColor();
				//sortPlayerList();
				break;

			case 'updatePoliceCount': // #e94444 | #4fca4f
				var count = event.data.policeCount;
				if (count >= 8) {
					$("#SHOP").css("color","#4fca4f");
					$("#JAVAHERI").css("color","#4fca4f");
					$("#BANK1").css("color","#4fca4f");
					$("#BANK2").css("color","#4fca4f");
					$("#updatetext").text("Centeral Bank Robbery Allowed");
					// 4 green
				} else if (count >= 8) {
					$("#SHOP").css("color","#4fca4f");
					$("#JAVAHERI").css("color","#4fca4f");
					$("#BANK1").css("color","#4fca4f");
					$("#BANK2").css("color","#e94444");
					$("#updatetext").text("Normal Bank Robbery Allowed");
					// 3 green 1 red
				} else if (count >= 4) {
					$("#SHOP").css("color","#4fca4f");
					$("#JAVAHERI").css("color","#4fca4f");
					$("#BANK1").css("color","#e94444");
					$("#BANK2").css("color","#e94444");
					$("#updatetext").text("Javaheri Robbery Allowed");
					// 2 green 2 red
				} else if (count >= 2) {
					$("#SHOP").css("color","#4fca4f");
					$("#JAVAHERI").css("color","#e94444");
					$("#BANK1").css("color","#e94444");
					$("#BANK2").css("color","#e94444");
					$("#updatetext").text("Shop Robbery Allowed");
					// 1 green 3 red
				} else {
					$("#SHOP").css("color","#c2c2c2");
					$("#JAVAHERI").css("color","#c2c2c2");
					$("#BANK1").css("color","#c2c2c2");
					$("#BANK2").css("color","#c2c2c2");
					$("#updatetext").text("No Robbery Allowed");
					// 4 red
				}
				break;

			case 'updatePing':
				updatePing(event.data.players);
				applyPingColor();
				break;



			default:
				break;
		}
	}, false);
});

function applyPingColor() {
    $('#playerlist tr').each(function () {
        $(this).find('td:nth-child(3),td:nth-child(6),td:nth-child(9)').each(function () {
            var ping = $(this).html();
            var color = 'green';
        
            if (ping > 150 && ping < 190) {
                color = 'orange';
            } else if (ping >= 240) {
                color = 'red';
            }

            $(this).css('color', color);
            $(this).html(ping + " <span style='color:white;'>ms</span>");
        });

    });
}


// Todo: not the best code
function updatePing(players) {
	jQuery.each(players, function (index, element) {
		if (element != null) {
			$('#playerlist tr:not(.heading)').each(function () {
				$(this).find('td:nth-child(2):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(2).html(element.ping);
				});

				$(this).find('td:nth-child(5):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(5).html(element.ping);
				});

				$(this).find('td:nth-child(8):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(8).html(element.ping);
				});
			});
		}
	});
}

function sortPlayerList() {
	var table = $('#playerlist'),
		rows = $('tr:not(.heading)', table);

	rows.sort(function(a, b) {
		var keyA = $('td', a).eq(1).html();
		var keyB = $('td', b).eq(1).html();

		return (keyA - keyB);
	});

	rows.each(function(index, row) {
		table.append(row);
	});
}
