$(document).ready(function () { 

    window.addEventListener("message", function (event) {
        if (event.data.action == "open") {
            $('body').fadeIn(300)
        };

        if (event.data.action == "close") {

            $("body").fadeOut(300)

        };
		$(document).keyup(function (e) {
			if (e.key === "Escape") {
            		$("body").fadeOut(300)
				$.post('http:///rsb_clothingmenu/escape', JSON.stringify({}));
			}
		});
    });
});


let selected = 1;


document.getElementById("menu_item_1").onmouseover = function() {mouseOver('1'); selected = 1};
document.getElementById("menu_item_1").onmouseout = function() {mouseOut('1'); selected = 1};

document.getElementById("menu_item_2").onmouseover = function() {mouseOver('2'); selected = 2};
document.getElementById("menu_item_2").onmouseout = function() {mouseOut('2'); selected = 1};

document.getElementById("menu_item_3").onmouseover = function() {mouseOver('3'); selected = 3};
document.getElementById("menu_item_3").onmouseout = function() {mouseOut('3'); selected = 1};

document.getElementById("menu_item_4").onmouseover = function() {mouseOver('4'); selected = 4};
document.getElementById("menu_item_4").onmouseout = function() {mouseOut('4'); selected = 1};

document.getElementById("menu_item_5").onmouseover = function() {mouseOver('5'); selected = 5};
document.getElementById("menu_item_5").onmouseout = function() {mouseOut('5'); selected = 1};

document.getElementById("menu_item_6").onmouseover = function() {mouseOver('6'); selected = 6};
document.getElementById("menu_item_6").onmouseout = function() {mouseOut('6'); selected = 1};

document.getElementById("menu_item_7").onmouseover = function() {mouseOver('7'); selected = 7};
document.getElementById("menu_item_7").onmouseout = function() {mouseOut('7'); selected = 1};

document.getElementById("menu_item_8").onmouseover = function() {mouseOver('8'); selected = 8};
document.getElementById("menu_item_8").onmouseout = function() {mouseOut('8'); selected = 1};


function mouseOver(type) {
    if(type == "1"){
        document.getElementById("menu_text_1").style.display = "block";
    } else if(type == "2"){
        document.getElementById("menu_text_2").style.display = "block";
    }else if(type == "3"){
        document.getElementById("menu_text_3").style.display = "block";
    }else if(type == "4"){
        document.getElementById("menu_text_4").style.display = "block";
    }else if(type == "5"){
        document.getElementById("menu_text_5").style.display = "block";
    }else if(type == "6"){
        document.getElementById("menu_text_6").style.display = "block";
    }else if(type == "7"){
        document.getElementById("menu_text_7").style.display = "block";
    }else if(type == "8"){
        document.getElementById("menu_text_8").style.display = "block";
    }
}

function mouseOut(type) {
    if(type == "1"){
        document.getElementById("menu_text_1").style.display = "none";
    } else if(type == "2"){
        document.getElementById("menu_text_2").style.display = "none";
    }else if(type == "3"){
        document.getElementById("menu_text_3").style.display = "none";
    }else if(type == "4"){
        document.getElementById("menu_text_4").style.display = "none";
    }else if(type == "5"){
        document.getElementById("menu_text_5").style.display = "none";
    }else if(type == "6"){
        document.getElementById("menu_text_6").style.display = "none";
    }else if(type == "7"){
        document.getElementById("menu_text_7").style.display = "none";
    }else if(type == "8"){
        document.getElementById("menu_text_8").style.display = "none";
    }
}

function mouseClick() {
    if(selected == 1){
	$.post('http:///rsb_clothingmenu/escape', JSON.stringify({}));
	}
	if(selected == 2){
	$.post('http:///rsb_clothingmenu/hat', JSON.stringify({}));
	}
	if(selected == 3){
	$.post('http:///rsb_clothingmenu/mask', JSON.stringify({}));
	}
	if(selected == 4){
	$.post('http:///rsb_clothingmenu/glasses', JSON.stringify({}));
	}
	if(selected == 5){
	$.post('http:///rsb_clothingmenu/ear', JSON.stringify({}));
	}
	if(selected == 6){
	$.post('http:///rsb_clothingmenu/torso', JSON.stringify({}));
	}
	if(selected == 7){
	$.post('http:///rsb_clothingmenu/pants', JSON.stringify({}));
	}
	if(selected == 8){
	$.post('http:///rsb_clothingmenu/shoes', JSON.stringify({}));
	}
}

window.onkeyup = function(e)
{
	if(e.key == "k") {
        mouseClick();
        $("body").fadeOut(300);
        $.post('http:///rsb_clothingmenu/escape', JSON.stringify({}));
    }   
}
