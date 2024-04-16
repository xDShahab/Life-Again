var warenkorb = []

$(document).ready(function(){
    
    window.addEventListener('message', function( event ) {   
    
        if (event.data.zeigehud == true) {

        $('body').show();
        setvalue({type: 'kmh', value: event.data.speed});
        setvalue({type: 'tank', value: event.data.tank});
        setvalue({type: 'km', value: event.data.km});
        };

        if (event.data.zeigehud == false) {

        $('body').hide();
        setvalue({type: 'kmh', value: 0});
        setvalue({type: 'tank', value: 0});
        setvalue({type: 'km', value: 0});
        };
        
        if (event.data.vehicleon == false) {
            document.getElementById("icon1").innerHTML = '<img id="Ebene_11" src="off.png">'
        };
        if (event.data.vehicleon == true) {
            document.getElementById("icon1").innerHTML = '<img id="Ebene_11" src="on.png">'
        };
        
        if (event.data.locked == false) {
            document.getElementById("icon2").innerHTML = '<img id="unlocked" src="unlocked.png">'
        };
        if (event.data.locked == true) {
            document.getElementById("icon2").innerHTML = '<img id="unlocked" src="locked.png">'
        };
    });
});


function setvalue(data) {
    switch (data.type) {
        case 'kmh':
            $('#' + data.type).text(data.value);
            break;
        case 'tank':
            $('#' + data.type).text(data.value + ' L');
            break;
        case 'km':
            $('#' + data.type).text(data.value + ' km');
            break;
    }
}