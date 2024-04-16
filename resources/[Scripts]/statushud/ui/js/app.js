var milad = false;

function setMiLaDDisplay(opacity) {
	$('#hud').css('opacity', opacity);
};

function setMiLaDName(name) {
	$('#hud #player-fullname span').text(name);
};
function setHUDID(source) {
	$('#hud #source').text(source);
};


function setMDJob(job) {
	if (job.job.name == 'nojob') {
		$('#hud #player-jobo').fadeOut(2000);
	} else {
		$('#hud #player-jobo').fadeIn(2000);
	};

	if (job.job.ext) {
		if (job.job.grade < 0) {
			$('#hud #job-name span').text(((job.job.ext).replace('_', ' ')).toUpperCase());
			$('#hud #job-img img').attr('src', './img/logo/jobs/iaa.png');
			$('#hud #job-grade span').text('Off-Duty');
		} else {
			$('#hud #job-name span').text(((job.job.ext).replace('_', ' ')).toUpperCase());
			$('#hud #job-img img').attr('src', './img/logo/jobs/iaa.png');
			$('#hud #job-grade span').text(job.job.grade_label);
		};
	} else {
		if (job.job.grade < 0) {
			$('#hud #job-name span').text(job.job.label);
			$('#hud #job-img img').attr('src', './img/logo/jobs/' + job.job.name + '.png');
			$('#hud #job-grade span').text('Off-Duty');
		} else {
			$('#hud #job-name span').text(job.job.label);
			$('#hud #job-img img').attr('src', './img/logo/jobs/' + job.job.name + '.png');
			$('#hud #job-grade span').text(job.job.grade_label);
		};
	};
};

function setHUDGang(gang) {
	if (gang.gang.name == 'nogang') {
		$('#hud #player-gang').fadeOut(2000);
	} else {
		$('#hud #player-gang').fadeIn(2000);
	};
	$('#hud #gang-name span').text((gang.gang.name).replace('_', ' '));

	if (gang.gang.name == 'Mafia') {
		$('#hud #gang-img img').attr('src', './img/logo/gangs/' + gang.gang.name + '.png');
	} else {
		$('#hud #gang-img img').attr('src', './img/logo/gangs/gang.png');
	};

	$('#hud #gang-grade span').text(gang.gang.grade_label);
};

function updatePing(data) {
	var s = data.value;
	$("[name='ping']").html(s)
	var x = document.getElementById("ping");


	if (s > 1 && s < 70) {
		$('#player-ping img').attr('src', './img/logo/wifi_g.png');
		x.style.color = "#13e94a";
	} else if (s > 71 && s < 300) {
		$('#player-ping img').attr('src', './img/logo/wifi_y.png');
		x.style.color = "#e8f016";
	}
	else {
		$('#player-ping img').attr('src', './img/logo/wifi_r.png');
		x.style.color = "#f01616";
	};

}


function setMDCash(money) {
	$('#hud #player-cash-texte').text('$' + money);
};

function setMiLaDData(data) {
	if (data.health <= 10.0) {
		$('#hud #health-img').addClass('ticktok');
	} else {
		$('#hud #health-img').removeClass('ticktok');
	};
	$('#hud #health').css('width', data.health + '%');
	$('#hud #armor').css('width', data.armor + '%');
};

function setHUDStatus(data) {
	let hunger = data[0].percent;
	let thirst = data[1].percent;
	if (hunger <= 10.0) {
		$('#hud2 #hunger-img').addClass('ticktok');
	} else {
		$('#hud2 #hunger-img').removeClass('ticktok');
	};

	if (thirst <= 10.0) {
		$('#hud2 #thirst-img').addClass('ticktok');
	} else {
		$('#hud2 #thirst-img').removeClass('ticktok');
	};

	$('#hud #hunger').css('width', hunger + '%');
	$('#hud #thirst').css('width', thirst + '%');
};

window.addEventListener('message', (event) => {


	let data = event.data;
	switch (data.action) {

		case 'toggle':
			if (milad) {
				this.setTimeout(() => {
					$("#hud #player-gang").css("opacity", "1");
					$("#hud #player-jobo").css("opacity", "1");
					$('i.fa.fa-heart, i.fa.fa-shield-alt').css('display', 'block');
					$('#hud .right-md1, #hud .right-md2').css('display', 'none');
					$('#hud #health, #hud #armor').css('float', 'left');
					$('#hud #health, #hud #armor').css('border-radius', '0.2vw');
					$("#hud #server-name, #hud #player-header, #hud #player-ping, #hud #player-name, #hud #player-cash, #hud #player-name, #hud #player-cash, #hud .player-id, #hud .player-hour, .khat, #hud #player-name, #hud #player-cash, #hud .left-status1,#hud .left-status2,#hud .right-status1,#hud .right-status2").removeAttr("style");
				}, 300)
			} else {

				this.setTimeout(() => {
					$("#hud #player-name").css("width", "1.7vw");
					$("#hud #player-gang").css("opacity", "0");
					$("#hud #player-jobo").css("opacity", "0");

					$("#hud #player-cash").css("width", "1.7vw");
					$(".khat").css("left", "11vw");
					$("#hud .player-id,#hud .player-hour ").css("left", "7.6vw");


					this.setTimeout(() => {
						$(".khat").css("display", "none");
						$("#hud .player-id").css("right", "-10vw");
						$("#hud .player-hour").css("right", "-10vw");
						$(".khat").css("right", "-10vw");
						$("#hud #player-name").css("left", "17.7vw");
						$("#hud #player-cash").css("left", "17.7vw");
						this.setTimeout(() => {
							$('#hud .right-status1').css('top', '3vw');
							$('#hud .left-status1').css('top', '5.5vw');
							$('#hud .left-status2').css('display', 'none');
							$('#hud .right-status2').css('display', 'none');
							$('#hud .right-status1').css('right', '1.7vw');
							$('#hud .left-status1').css('left', '4.8vw');


							this.setTimeout(() => {
								$('#hud .right-status1').css('height', '1.7vw');
								$('#hud .left-status1').css('height', '1.7vw');
								this.setTimeout(() => {
									$('i.fa.fa-heart, i.fa.fa-shield-alt').css('display', 'none');
									$('#hud .right-md1, #hud .right-md2').css('display', 'block');


									this.setTimeout(() => {
										$('#hud .right-status1, #hud .left-status1').css('width', '6.5vw');
										$('#hud .right-status1, #hud #health, #hud #armor, #hud .left-status1').css('border-radius', '0.2vw 0.0vw 0.0vw 0.2vw');
										$('#hud #health, #hud #armor').css('float', 'right');
										$('#hud #player-ping').css('display', 'none');
										$('#hud #player-header').css('width', '8.25vw');
										$('#hud #player-header').css('float', 'right');
										$('#hud .player-id').css('left', '4.8vw');
										$('#hud .player-id').css('top', '1.95vw');
										$('#hud .player-hour').css('top', '1.95vw');
										$('.khat').css('display', 'none');
										$('#hud .player-hour').css('left', '9.8vw');
										this.setTimeout(() => {
											$('#hud #server-name').css('margin-left', '0');
											$('#hud #server-name').css('padding-left', '0');
											$('#hud #server-name').css('letter-spacing', '0.1vw');
											this.setTimeout(() => {

											}, 400);
										}, 400);
									}, 400);
								}, 400);
							}, 400);
						}, 500);
					}, 700)


				}, 300);
			};
			milad = !milad;
			break;

		case 'setMiLaDDisplay': {
			setMiLaDDisplay(data.opacity);
			break;
		};

		case 'setMiLaDName': {
			setMiLaDName(data.name);
			break;
		};

		case 'setHUDID': {
			setHUDID(data.source);
			break;
		};

		case 'setCoin': {
			$('#hour').text(data.coin);
			// document.getElementById('hour').innerHTML = data.coin; 
			break;
		};

		case 'setMDJob': {
			setMDJob(data.data);
			break;
		};

		case 'setHUDGang': {
			setHUDGang(data.data);
			break;
		};

		case 'setHUDPing': {
			setHUDPing(data.ping);
			break;
		};

		case 'setMiLaDData': {
			setMiLaDData(data.data);
			break;
		};

		case 'setMDCash': {
			setMDCash(data.money);
			break;
		};

		case 'setHUDStatus': {
			setHUDStatus(data.data);
			break;
		};



	};
	if (event.data.action == "ping") {
		updatePing(event.data);
	}
	
    function updateClock() {
        var now = new Date(),
            time = (now.getHours() < 10 ? '0' : '') + now.getHours() + ':' + (now.getMinutes() < 10 ? '0' : '') + now.getMinutes();

        // document.getElementById('clock').innerHTML = [time];
        $("#header__clock").text(time)
        setTimeout(updateClock, 1000);
    }
    updateClock();

});