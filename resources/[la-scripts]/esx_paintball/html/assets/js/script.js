
let ResourceName = 'esx_paintball';
let weapons = [
    'advancedrifle.png',      
    'assaultrifle.png',                 
    'bullpuprifle.png', 
    'carbinerifle.png',       
    'combatpdw.png',          
    'combatpistol.png',         
    'gusenberg.png',
    'heavypistol.png',                 
    'microsmg.png',
    'minismg.png',     
    'pistol.png',
    'pistol50.png',           
    'smg.png',
    'specialcarbine.png',

];

let weaponsprice = {
    "pumpshotgun.png":13000,       "snspistol.png":5000,
    "pistol_mk2.png":5000,         "revolver_mk2.png":12000,
    "bullpuprifle.png":15000,      "mg.png":20000,
    "combatmg_mk2.png":22000,      "appistol.png":7000,
    "minigun.png":25000,           "revolver.png":10000,
    "carbinerifle.png":10000,      "bullpupshotgun.png":15000,
    "assaultrifle_mk2.png":12000,  "gusenberg.png":16000,
    "advancedrifle.png":10000,     "assaultrifle.png":10000,
    "combatmg.png":20000,          "heavypistol.png":5000,
    "snspistol_mk2.png":6000,      "heavysniper_mk2.png":25000,
    "combatpistol.png":5000,       "specialcarbine_mk2.png":16000,
    "assaultsmg.png":11000,        "carbinerifle_mk2.png":13000,
    "marksmanpistol.png":12000,    "vintagepistol.png":5000,
    "specialcarbine.png":15000,    "bullpuprifle_mk2.png":18000,
    "smg_mk2.png":12000,           "marksmanrifle.png":16000,
    "compactrifle.png":11000,      "sawnoffshotgun.png":13000,
    "mpshotgun_mk2.png":18000,     "pistol50.png":8000,
    "pistol.png":5000,             "smg.png":10000,
    "minismg.png":15000,           "microsmg.png":13000,
    "marksmanrifle_mk2.png":18000, "musket.png":25000,
    "machinepistol.png":10000,     "heavysniper.png":23000,
    "doubleaction.png":10000,      "autoshotgun.png":18000,
    "assaultshotgun.png":13000,    "heavyshotgun.png":25000,
    "dbshotgun.png":16000,         "combatpdw.png":13000,
    "pumpshotgun_mk2.png":15000
};

let maps = {"bank":"bank.jpg","bimeh":"bimeh.jpg","cargo":"cargo.jpg","skyscraper":"skyscraper.jpg","shop1":"shop1.jpg","shop2":"shop2.jpg","javaheri":"javaheri.jpg","1v1":"1v1.jpg","island":"island.jpg","jail":"jail.jpg"}
var lobbyID, TeamID, mapping, SWeapon, lobbyname, friendlyFire, roundNum, TotalPlayers,timer, head, armor;
var page = 0;

// Create Lobby Functions
function onCreateLobby(){
    $('.question').css('display', 'none');
    $('div[name="createlobby"]').css('display', 'block');
};
function onChangeMap(){
    var newSelect = $('input[name=map]:checked', '#map').val()
    $('.map-img').attr('src', './assets/imgs/'+maps[newSelect])
};
function LeftWeaponButton() {
    var nowSelect = $('.weapon-select img').attr('src').split('/');
    if(weapons.indexOf(nowSelect[3]) > 0){
        $('.weapon-select img').attr('src', './assets/weapons/'+weapons[weapons.indexOf(nowSelect[3])-1]);
        $('.weapon-name').attr('id', weapons[weapons.indexOf(nowSelect[3])-1].split('.')[0]);
        $('.weapon-name').html(weapons[weapons.indexOf(nowSelect[3])-1].split('.')[0].replace('_', ' '));
        $('.weapon-price').html('$'+weaponsprice[weapons[weapons.indexOf(nowSelect[3])-1]]);
    }else{
        $('.weapon-select img').attr('src', './assets/weapons/'+weapons[weapons.length-1]);
        $('.weapon-name').attr('id', weapons[weapons.length-1].split('.')[0]);
        $('.weapon-name').html(weapons[weapons.length-1].split('.')[0].replace('_', ' '));
        $('.weapon-price').html('$'+weaponsprice[weapons[weapons.length-1]]);
    };
};
function RightWeaponButton() {
    var nowSelect = $('.weapon-select img').attr('src').split('/');
    if(weapons.indexOf(nowSelect[3]) == weapons.length-1){
        $('.weapon-select img').attr('src', './assets/weapons/'+weapons[0]);
        $('.weapon-name').attr('id', weapons[0].split('.')[0]);
        $('.weapon-name').html(weapons[0].split('.')[0].replace('_', ' '));
        $('.weapon-price').html('$'+weaponsprice[weapons[0]]);
    }else{
        $('.weapon-select img').attr('src', './assets/weapons/'+weapons[weapons.indexOf(nowSelect[3])+1]);
        $('.weapon-name').attr('id', weapons[weapons.indexOf(nowSelect[3])+1].split('.')[0]);
        $('.weapon-name').html(weapons[weapons.indexOf(nowSelect[3])+1].split('.')[0].replace('_', ' '));
        $('.weapon-price').html('$'+weaponsprice[weapons[weapons.indexOf(nowSelect[3])+1]]);
    };
};
function onSubmit(){
    lobbyname = $('#lname');
    lobbypass = $('#lbpass');
    friendlyFire = $('#fire').val();
    roundNum = $('#round');
	timer = $('#timer');
    head = $('#head').find(":selected").val();
    armor = $('#armor');
    if(lobbyname.length != 0 && lobbyname.val().length > lobbyname.attr('minlength')){
        var max = roundNum.attr('max');
		    if (parseInt(timer.val()) < parseInt(timer.attr('min')) || parseInt(timer.val()) > parseInt(timer.attr('max'))) {
        if(timer.val() > timer.attr('min'))
        {
            timer.val(timer.attr('max'));
            $('#timer').css('border-color', 'red');
        }
        else
        {
            timer.val(timer.attr('min'));
            $('#timer').css('border-color', 'red');
        }
        submit = false;
    }
    if (parseInt(armor.val()) < 0 || parseInt(armor.val()) > parseInt(armor.attr('max'))) {
        armor.val(armor.attr('max'));
        $('#armor').css('border-color', 'red');
        submit = false;
    }
        if(roundNum.val() > 0 && parseInt(roundNum.val()) <= parseInt(max)){
            fetch(`https://${ResourceName}/CreateLobby`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    mapName: mapping,
                    weaponModel: SWeapon,
                    lobbyName: lobbyname.val(),
                    friendlyFire: friendlyFire,
                    roundNum: roundNum.val(),
                    Password: lobbypass.val(),
					armor:armor.val(),
					timer:timer.val(),
					head:head,
                })
            }).then(resp => resp.json()).then(lobid => {
                lobbyID = lobid
            });
            page = 100;
            TeamID = 0;
            $('div[name="createlobby"]').css('display', 'none');
            $('#startButton').css('display', 'block');
            $('div[name="main"]').css('display', 'block');
        }else{
            roundNum.val(max);
            $('#round').css('border-color', 'red');
        };
    }else{
        $('#lname').css('border-color', 'red');
    };
};

// Join In Lobby Functions
function onJoinLobby(){
    $('.question').css('display', 'none');
    $('.list').css('display', 'block');
    fetch(`https://${ResourceName}/LobbyList`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(data => {
        var jdata = JSON.parse(data);
        if(jdata.length != 0){
            for(var i=0;i<jdata.length;i++){
                if(jdata[i].pass == null || jdata[i].pass == ""){
                    $('.boxlobbeys').append('<h1 class="lobbeys" id="Lobby-'+jdata[i].LobbyId+'" onclick="onSelectLobby(this.id)">'+jdata[i].name+' | '+jdata[i].map+' | '+jdata[i].weapon+'</h1>');
                }else{
                    $('.boxlobbeys').append('<h1 class="lobbeys" id="Lobby-'+jdata[i].LobbyId+'-locked" onclick="onSelectLobby(this.id)">'+jdata[i].name+' | '+jdata[i].map+' | Locked</h1>');
                };
            };
        }else{
            $('.boxlobbeys').append('<h1 class="lobbeys">No Lobby!</h1>');
        };
    });
};
function onSelectLobby(id){
    var lid = id.split('-');
    lobbyID = lid[1];
    if(lid[2] == 'locked'){
        $('.lobby-password').css('display', 'block');
        $('.lobbeys').css('display', 'none');
        page = 85;
    }else{
        page = 0;
        TeamID = 0;
        $('.list').css('display', 'none');
        $('#startButton').css('display', 'none');
        $('div[name="main"]').css('display', 'block');
        fetch(`https://${ResourceName}/JoinLobby`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                LobbyId: lobbyID
            })
        }).then(resp => resp.json()).then(data => {
            var jdata = JSON.parse(data);
            for(var i=0;i<3;i++){
                var team = jdata[i];
                for(var i2=0;i2<team.length;i2++){
                    if(i == 0){
                        $('.joiners').append(team[i2].value);
                    }else if(i == 1){
                        $('.teamone').append(team[i2].value);
                    }else{
                        $('.teamtwo').append(team[i2].value);
                    };
                };
            };
        });
    };
};
function onJoin(id){
    var tid = id.split('-')[1];
    fetch(`https://${ResourceName}/SwitchTeam`, 
	{
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            LobbyId: lobbyID,
            LastTeam: TeamID,
            JoinTeam: tid
        })
    }).then(resp => resp.json()).then(data => 
	{
        if(data)
		{
            if(TeamID != 0){
                $('#TM-'+TeamID).css('display', 'block');
            };
            $('#'+id).css('display', 'none');
            page = 100;
            TeamID = tid;
        };
    })
};

// In Lobby Functions
function onStart(){
    page = 0;
    fetch(`https://${ResourceName}/StartMatch`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            LobbyId: lobbyID
        })
    }).then(resp => resp.json());
};
function onReady(){
    $('#ReadyButton').css('display', 'none');
    $('#UnReadyButton').css('display', 'block');
    fetch(`https://${ResourceName}/ToggleReadyPlayer`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            LobbyId: lobbyID,
            Team: TeamID,
            ready: true
        })
    }).then(resp => resp.json());
};
function onUnready(){
    $('#UnReadyButton').css('display', 'none');
    $('#ReadyButton').css('display', 'block');
    fetch(`https://${ResourceName}/ToggleReadyPlayer`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            LobbyId: lobbyID,
            Team: TeamID,
            ready: false
        })
    }).then(resp => resp.json());
};
function onLeave(){
    page = 0;
    $('.lobby').css('display', 'none');
    fetch(`https://${ResourceName}/QuitLobby`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            LobbyId: lobbyID,
            Team: TeamID
        })
    }).then(resp => resp.json());
    TeamID = 0;
    lobbyID = 0;
    location.reload();
};

// Other Functions
function onNext(){
    if(page == 0){
        $('#cancelButton').css('display', 'none');
        $('#backButton').css('display', 'block');
        $('.selectmap').css('display', 'none');
        $('.selectmap2').css('display', 'none');
        $('.weapon-select').css('display', 'block');
        mapping = $('input[name=map]:checked', '#map').val()
        page = page+1;
    }else{
        $('#nextButton').css('display', 'none');
        $('#submitButton').css('display', 'block');
        $('.weapon-select').css('display', 'none');
        $('.setting').css('display', 'block');
        SWeapon = $('.weapon-name').attr('id');
        page = page+1;
    };
};

function onBack(){

    if(page == 2){
        $('#nextButton').css('display', 'block');
        $('#submitButton').css('display', 'none');
        $('.weapon-select').css('display', 'block');
        $('.setting').css('display', 'none');
        page = page-1;
    }else{
        $('#cancelButton').css('display', 'block');
        $('#backButton').css('display', 'none');
        $('.selectmap').css('display', 'block');
        $('.selectmap2').css('display', 'block');
        $('.weapon-select').css('display', 'none');
        page = page-1;
    };
};
function onCancel(){
    page = 0;
    $('.lobby').css('display', 'none');
    fetch(`https://${ResourceName}/QuitFromMenu`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json());
    location.reload()
};
function onBackQuestion(){
    if(page != 85){
        $('.question').css('display', 'block');
        $('.list').css('display', 'none');
        $('.boxlobbeys').find('h1').remove();
    }else{
        page = 0
        $('.lobby-password').css('display', 'none');
        $('.lobbeys').css('display', 'block');
    };
};


function startMatch() {
    _stopTimer = false;
    $('#who_won').hide();
    var fiveMinutes = 60 * 3,
        display = $('#time_counter');
    startTimer(fiveMinutes, display);
    Speak("The match has started!");
}

// Keyup Event
document.onkeyup = function(data) {
    if(data.which == 27){ // ESC Press
        if(page == 0){
            fetch(`https://${ResourceName}/QuitFromMenu`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({})
            }).then(resp => resp.json());
            location.reload();
        };
    }else if(data.which == 13){
        if(page == 85){
            var pass = $('#lpass').val();
            if(pass != null || pass != ""){
                fetch(`https://${ResourceName}/GetLobbyPassword`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: JSON.stringify({
                        LobbyId: lobbyID,
						Password: pass
                    })
                }).then(resp => resp.json()).then(data => {
                    if(data == true){
                        page = 0;
                        TeamID = 0;
                        $('.list').css('display', 'none');
                        $('#startButton').css('display', 'none');
                        $('div[name="main"]').css('display', 'block');
                        fetch(`https://${ResourceName}/JoinLobby`, {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: JSON.stringify({
                                LobbyId: lobbyID
                            })
                        }).then(resp => resp.json()).then(data => {
                            var jdata = JSON.parse(data);
                            for(var i=0;i<3;i++){
                                var team = jdata[i];
                                for(var i2=0;i2<team.length;i2++){
                                    if(i == 0){
                                        $('.joiners').append(team[i2].value);
                                    }else if(i == 1){
                                        $('.teamone').append(team[i2].value);
                                    }else{
                                        $('.teamtwo').append(team[i2].value);
                                    };
                                };
                            };
                        });
                    }else{
                        $('#lpass').css('border-color', 'red');
                    };
                });
            };
        };
    };
};

var SecondCounter = -1
setInterval(() =>
{
	if(SecondCounter != -1)
	{
		var date = new Date(0);
		date.setSeconds(SecondCounter);
		var timeString = date.toISOString().substr(14, 8);
		$('.btn-grad4').html(timeString.replace(".00", ""));
		SecondCounter--;
	}
}, 1000)

function addKill(killer, weapon, killed, headshot) 
{
    let killerName = sanitizeString(killer.name);
    let killedName = sanitizeString(killed.name);

    let killfeedElement = `
        <div class="kill-wrapper">
            <div class="kill">
                <p class="${killer.team}">${killerName}</p>
                ${(weapon == "VEHICLE") ? `<i style="padding-left: 5px; padding-right: 5px;" class="fas fa-car-side"></i>` : `<img src="https://cdn.gtakoth.com/weapons/${weapon}.png">`}
                ${(headshot) ? '<i class="fas fa-crosshairs"></i> ' : ""}
                <p class="${killed.team}">${killedName}</p>
            </div>
        </div>
    `;

    let elem = $(killfeedElement);
    $('.killfeed').append(elem);
    elem.hide().show(500);

    setTimeout(() => { elem.hide(500); setTimeout(() => { elem.html(""); }, 500); }, 5000);
}

function sanitizeString(str)
{
    str = str.replace(/[^a-z0-9áéíóúñü \.,_-]/gim,"");
    return str.trim();
}

function startTimer(duration, display) {
    var timer = duration, minutes, seconds;
    var _interVal = setInterval(function () {


        if (--timer >= 0) {
            minutes = parseInt(timer / 60, 10);
            seconds = parseInt(timer % 60, 10);

            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            display.text(minutes + ":" + seconds);
        }
    }, 1000);
}

// NUI Sended Event
window.addEventListener("message", function(event)
{
	if(event.data.type == 'show')
	{
		if(event.data.show){
			$('.lobby').css('display', 'block');
		}else{
			$('.lobby').css('display', 'none');
			this.location.reload();
		};
	};
	if(event.data.action == 'JoinTeam')
	{
		if(event.data.team == 0){
			$('.joiners').append(event.data.value);
		}else if(event.data.team == 1){
			$('.teamone').append(event.data.value);
		}else{
			$('.teamtwo').append(event.data.value);
		};
	}
	else if (event.data.type == 'start') {
        startTimer(event.data.time, $('#time_counter'));
    }
	else if(event.data.action == 'LeftTeam')
	{
		$('#'+event.data.player).remove();
	}
	else if(event.data.action == 'ToggleReadyPlayer')
	{
		$('#'+event.data.player).html(event.data.value);
	}
	else if(event.data.action == "RefreshLobbies")
	{
        $('.boxlobbeys').find('h1').remove();
		onJoinLobby()
	}
	else if(event.data.action == "ShowGameHUD")
	{
		if(event.data.value) $('.gamehud').css('display', 'block');
		else $('.gamehud').css('display', 'none');
	}
	else if(event.data.action == "SpectatePlayer")
	{
		if(event.data.value)
		{
			$('.btn-grad').html(event.data.value);
			$('.btn-grad').css('display', 'block');
		}
		else $('.btn-grad').css('display', 'none');
	}
	else if(event.data.action == "UpdateTeams")
	{
		if(event.data.team1 && event.data.team2)
		{
			$('.btn-grad2').html(event.data.team1);
			$('.btn-grad3').html(event.data.team2);
			$('.btn-grad2').css('display', 'block');			
			$('.btn-grad3').css('display', 'block');						
		}
		else
		{
			$('.btn-grad2').css('display', 'none');			
			$('.btn-grad3').css('display', 'none');									
		}
	}
	else if(event.data.action == "UpdateTotalRounds")
	{
		if(event.data.value)
		{
			$('.btn-grad5').html(" " + (parseInt(event.data.value) + 1) + " / " + event.data.maxRounds);
			$('.btn-grad5').css('display', 'block');
		}
		else $('.btn-grad5').css('display', 'none');	
	}
	else if(event.data.action == "ResetRoundTimer")
	{
		if(event.data.value) 
		{
			$('.btn-grad4').css('background-color', 'rgba(' + event.data.r + ', ' + event.data.g + ', ' + event.data.b + ', 0.8)');			
			$('.btn-grad4').css('display', 'block');	
			SecondCounter = event.data.value;
		}
		else 
		{
			$('.btn-grad4').css('display', 'none');	
			SecondCounter = -1
		}
	}
	else if(event.data.topKillers)
	{
		for(var i = 0; i < 5; i++)
		{
			// var teamName = "", teamColor = "";			
			if(event.data.topKillers[i].team == 0)
			{
				 $('#topcat' + (i + 1)).fadeOut(850);
			}
			else
			{
				$('#topcat' + (i + 1)).fadeIn(850);
				if(event.data.topKillers[i].team == 1) 
				{
					// teamName = " (Blue)";
					$('#top' + (i + 1) + 'btn').css('background-color', 'RGBA(13,71,161,0.8)');
					$('#top' + (i + 1) + 'a').css('background-color', 'RGBA(13,71,161,0.8)');
				}
				else if(event.data.topKillers[i].team == 2) 
				{
					// teamName = " (Orange)";
					$('#top' + (i + 1) + 'btn').css('background', '#d50000');
					$('#top' + (i + 1) + 'a').css('background', '#d50000');
				}
			}
			$('#hud #top' + (i + 1)).text(event.data.topKillers[i].name/* + teamName*/);
			$('#hud #top' + (i + 1) + 'a #top' + (i + 1) + 'b').text(event.data.topKillers[i].kills);
		}
	}
});

 $(document).ready(function () {
            $('input[value=bank]').on('click', function () {
				$('#bank-checkbox').css('display', 'block');
				$('#bimeh-checkbox').css('display', 'none');
				$('#cargo-checkbox').css('display', 'none');
				$('#skyscraper-checkbox').css('display', 'none');
				$('#javaheri-checkbox').css('display', 'none');
				$('#shop1-checkbox').css('display', 'none');
				$('#shop2-checkbox').css('display', 'none');
				$('#1v1-checkbox').css('display', 'none');
				
                $('#bank').css('filter', 'none');
                $('#bimeh').css('filter', 'grayscale(100%)');
                $('#cargo').css('filter', 'grayscale(100%)');
                $('#skyscraper').css('filter', 'grayscale(100%)');
                $('#javaheri').css('filter', 'grayscale(100%)');
                $('#shop1').css('filter', 'grayscale(100%)');
                $('#shop2').css('filter', 'grayscale(100%)');
                $('#1v1').css('filter', 'grayscale(100%)');
            })
            $('input[value=bimeh]').on('click', function () {
	
				$('#bank-checkbox').css('display', 'none');
				$('#bimeh-checkbox').css('display', 'block');
				$('#cargo-checkbox').css('display', 'none');
				$('#skyscraper-checkbox').css('display', 'none');
				$('#javaheri-checkbox').css('display', 'none');
				$('#shop1-checkbox').css('display', 'none');
				$('#shop2-checkbox').css('display', 'none');
				$('#1v1-checkbox').css('display', 'none');
				
                $('#bank').css('filter', 'grayscale(100%)');
                $('#bimeh').css('filter', 'none');
                $('#cargo').css('filter', 'grayscale(100%)');
                $('#skyscraper').css('filter', 'grayscale(100%)');
                $('#javaheri').css('filter', 'grayscale(100%)');
                $('#shop1').css('filter', 'grayscale(100%)');
                $('#shop2').css('filter', 'grayscale(100%)');
                $('#1v1').css('filter', 'grayscale(100%)');
            })
            $('input[value=cargo]').on('click', function () {
	
				$('#bank-checkbox').css('display', 'none');
				$('#bimeh-checkbox').css('display', 'none');
				$('#cargo-checkbox').css('display', 'block');
				$('#skyscraper-checkbox').css('display', 'none');
				$('#javaheri-checkbox').css('display', 'none');
				$('#shop1-checkbox').css('display', 'none');
				$('#shop2-checkbox').css('display', 'none');
				$('#1v1-checkbox').css('display', 'none');
				
                $('#bank').css('filter', 'grayscale(100%)');
                $('#bimeh').css('filter', 'grayscale(100%)');
                $('#cargo').css('filter', 'none');
                $('#skyscraper').css('filter', 'grayscale(100%)');
                $('#javaheri').css('filter', 'grayscale(100%)');
                $('#shop1').css('filter', 'grayscale(100%)');
                $('#shop2').css('filter', 'grayscale(100%)');
                $('#1v1').css('filter', 'grayscale(100%)');
            })
            $('input[value=skyscraper]').on('click', function () {

				$('#bank-checkbox').css('display', 'none');
				$('#bimeh-checkbox').css('display', 'none');
				$('#cargo-checkbox').css('display', 'none');
				$('#skyscraper-checkbox').css('display', 'block');
				$('#javaheri-checkbox').css('display', 'none');
				$('#shop1-checkbox').css('display', 'none');
				$('#shop2-checkbox').css('display', 'none');
				$('#1v1-checkbox').css('display', 'none');
				
                $('#bank').css('filter', 'grayscale(100%)');
                $('#bimeh').css('filter', 'grayscale(100%)');
                $('#cargo').css('filter', 'grayscale(100%)');
                $('#skyscraper').css('filter', 'none');
                $('#javaheri').css('filter', 'grayscale(100%)');
                $('#shop1').css('filter', 'grayscale(100%)');
                $('#shop2').css('filter', 'grayscale(100%)');
                $('#1v1').css('filter', 'grayscale(100%)');
            })
            $('input[value=javaheri]').on('click', function () {

				$('#bank-checkbox').css('display', 'none');
				$('#bimeh-checkbox').css('display', 'none');
				$('#cargo-checkbox').css('display', 'none');
				$('#skyscraper-checkbox').css('display', 'none');
				$('#javaheri-checkbox').css('display', 'block');
				$('#shop1-checkbox').css('display', 'none');
				$('#shop2-checkbox').css('display', 'none');
				$('#1v1-checkbox').css('display', 'none');
				
                $('#bank').css('filter', 'grayscale(100%)');
                $('#bimeh').css('filter', 'grayscale(100%)');
                $('#cargo').css('filter', 'grayscale(100%)');
                $('#skyscraper').css('filter', 'grayscale(100%)');
                $('#javaheri').css('filter', 'none');
                $('#shop1').css('filter', 'grayscale(100%)');
                $('#shop2').css('filter', 'grayscale(100%)');
                $('#1v1').css('filter', 'grayscale(100%)');
            })

            $('input[value=shop1]').on('click', function () {
				$('#bank-checkbox').css('display', 'none');
				$('#bimeh-checkbox').css('display', 'none');
				$('#cargo-checkbox').css('display', 'none');
				$('#skyscraper-checkbox').css('display', 'none');
				$('#javaheri-checkbox').css('display', 'none');
				$('#shop1-checkbox').css('display', 'block');
				$('#shop2-checkbox').css('display', 'none');
				$('#1v1-checkbox').css('display', 'none');
				
                $('#bank').css('filter', 'grayscale(100%)');
                $('#bimeh').css('filter', 'grayscale(100%)');
                $('#cargo').css('filter', 'grayscale(100%)');
                $('#skyscraper').css('filter', 'grayscale(100%)');
                $('#javaheri').css('filter', 'grayscale(100%)');
                $('#shop1').css('filter', 'none');
                $('#shop2').css('filter', 'grayscale(100%)');
                $('#1v1').css('filter', 'grayscale(100%)');
            })
            $('input[value=shop2]').on('click', function () {

				$('#bank-checkbox').css('display', 'none');
				$('#bimeh-checkbox').css('display', 'none');
				$('#cargo-checkbox').css('display', 'none');
				$('#skyscraper-checkbox').css('display', 'none');
				$('#javaheri-checkbox').css('display', 'none');
				$('#shop1-checkbox').css('display', 'none');
				$('#shop2-checkbox').css('display', 'blcok');
				$('#1v1-checkbox').css('display', 'none');
				
                $('#bank').css('filter', 'grayscale(100%)');
                $('#bimeh').css('filter', 'grayscale(100%)');
                $('#cargo').css('filter', 'grayscale(100%)');
                $('#skyscraper').css('filter', 'grayscale(100%)');
                $('#javaheri').css('filter', 'grayscale(100%)');
                $('#shop1').css('filter', 'grayscale(100%)');
                $('#shop2').css('filter', 'none');
                $('#1v1').css('filter', 'grayscale(100%)');
            })
            $('input[value=1v1]').on('click', function () {
	
				$('#bank-checkbox').css('display', 'none');
				$('#bimeh-checkbox').css('display', 'none');
				$('#cargo-checkbox').css('display', 'none');
				$('#skyscraper-checkbox').css('display', 'none');
				$('#javaheri-checkbox').css('display', 'none');
				$('#shop1-checkbox').css('display', 'none');
				$('#shop2-checkbox').css('display', 'none');
				$('#1v1-checkbox').css('display', 'block');
				
                $('#bank').css('filter', 'grayscale(100%)');
                $('#bimeh').css('filter', 'grayscale(100%)');
                $('#cargo').css('filter', 'grayscale(100%)');
                $('#skyscraper').css('filter', 'grayscale(100%)');
                $('#javaheri').css('filter', 'grayscale(100%)');
                $('#shop1').css('filter', 'grayscale(100%)');
                $('#shop2').css('filter', 'grayscale(100%)');
                $('#1v1').css('filter', 'none');
            })
			
			$('.bc').on('click', function () {
	
	$.post('https:/esx_paintball/back', JSON.stringify());
            })
            
        });