
window.addEventListener('message', function(event) {
    // Check for playSound transaction
    if (event.data.transactionType == "playSound") {
    	play(event.data.transactionData);
    }
    if (event.data.transactionType == "stopSound") {
	    stop();
    }
	if (event.data.transactionType == "volume") {
		setVolume(event.data.transactionData);
	}
})

//YouTube IFrame API player.
var player;

(function() {
	player = document.getElementById("player");
})();

function onYouTubeIframeAPIReady()
{

	
	
}

function onPlayerReady(event)
{
    title = event.target.getVideoData().title;
    player.setVolume(30);
}

function onPlayerStateChange(event)
{
    if(event.data == YT.PlayerState.PLAYING)
    {
        title = event.target.getVideoData().title;
    }

    if (event.data == YT.PlayerState.ENDED)
    {
        musicIndex++;
        play();
    }
}

function onPlayerError(event)
{
    switch (event.data)
    {
        case 2:
            logger.addToLog("The video id: " + vid + " seems invalid, wrong video id?" );
            break;
        case 5:
            logger.addToLog("An HTML 5 player issue occured on video id: " + vid);
        case 100:
            logger.addToLog("Video " + vid + "does not exist, wrong video id?" );
        case 101:
        case 150:
            logger.addToLog("Embedding for video id " + vid + " was not allowed.");
            logger.addToLog("Please consider removing this video from the playlist.");
            break;
        default:
            logger.addToLog("An unknown error occured when playing: " + vid);
    }

    skip();
}

function skip()
{
    play();
}

function play(id)
{
    title = "n.a.";
    player.src = id;
    player.play();
}

function resume()
{
    player.play();
}

function pause()
{
    player.pause();
}

function stop()
{
    player.pause();
}

function setVolume(volume)
{
    player.volume = (volume)/100
}

