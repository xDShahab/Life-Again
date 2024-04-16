$(document).ready(function(){
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    // Open Skin Creator
    if(event.data.openSkinCreator == true){
      $.post('http://skincreator/updateSkin', JSON.stringify({
        value: false,
        gender: $('input:radio[name=gender]:checked', '#formSkinCreator').val(),
        // Face
        dad: $('input[name=pere]:checked', '#formSkinCreator').val(),
        mum: $('input[name=mere]:checked', '#formSkinCreator').val(),
        dadmumpercent: $('.morphologie').val(),
        color: $('input[name=peaucolor]:checked', '#formSkinCreator').val(),
        eyecolor: $('input[name=eyecolor]:checked','#formSkinCreator').val(),
        acne: $('.acne').val(),
        skinproblem: $('.pbpeau').val(),
        freckle: $('.tachesrousseur').val(),
        wrinkle: $('.rides').val(),
        wrinkleopacity: $('.rides').val(),
        hair: $('.hair').val(),
        haircolor: $('input[name=haircolor]:checked', '#formSkinCreator').val(),
        eyebrow: $('.sourcils').val(),
        eyebrowopacity: $('.epaisseursourcils').val(),
        beard: $('.barbe').val(),
        beardopacity: $('.epaisseurbarbe').val(),
        beardcolor: $('input[name=barbecolor]:checked', '#formSkinCreator').val(),
        makeupopacity: $('.makeupopacity').val(),
        makeupcolor: $('input[name=makeupcolor]:checked', '#formSkinCreator').val(),
        // Clothes
        hats: $('.chapeaux .active').attr('data'),
        glasses: $('.lunettes .active').attr('data'),
        ears: $('.oreilles .active').attr('data'),
        tops: $('.hauts .active').attr('data'),
        bazo: $('.bazo .active').attr('data'),
        pants: $('.pantalons .active').attr('data'),
        shoes: $('.chaussures .active').attr('data'),
        watches: $('.montre .active').attr('data'),
      }));
      $("body").css("display","block");
    }
    // Close Skin Creator
    if(event.data.openSkinCreator == false){
      $("body").fadeOut(400);
    }
  });

  // Form update
  $('input:radio[name=gender]').change(function(){
    var gender = $('input:radio[name=gender]:checked').val()
    if(gender == 0){ // male
      $('.epaisseurbarbe').val(10);
      $('.morphologie').val(4);
      $('#rish').show();
      $('#rishopacity').show();
    }else{ //female
      $('.epaisseurbarbe').val(0);
      $('.morphologie').val(6);
      $('#rish').hide();
      $('#rishopacity').hide();
    }
  });
  $('input').change(function(){
    $.post('http://skincreator/updateSkin', JSON.stringify({
      value: false,
      gender: $('input:radio[name=gender]:checked', '#formSkinCreator').val(),
      // Face
      dad: $('input[name=pere]:checked', '#formSkinCreator').val(),
      mum: $('input[name=mere]:checked', '#formSkinCreator').val(),
      dadmumpercent: $('.morphologie').val(),
      color: $('input[name=peaucolor]:checked', '#formSkinCreator').val(),
      eyecolor: $('input[name=eyecolor]:checked','#formSkinCreator').val(),
      acne: $('.acne').val(),
      skinproblem: $('.pbpeau').val(),
      freckle: $('.tachesrousseur').val(),
      wrinkle: $('.rides').val(),
      wrinkleopacity: $('.rides').val(),
      hair: $('.hair').val(),
      haircolor1: $('input[name=haircolor1]:checked', '#formSkinCreator').val(),
      haircolor2: $('input[name=haircolor2]:checked', '#formSkinCreator').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formSkinCreator').val(),
      makeupopacity: $('.makeupopacity').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formSkinCreator').val(),
      // Clothes
      hats: $('.chapeaux .active').attr('data'),
      glasses: $('.lunettes .active').attr('data'),
      ears: $('.oreilles .active').attr('data'),
      tops: $('.hauts .active').attr('data'),
      bazo: $('.bazo .active').attr('data'),
      pants: $('.pantalons .active').attr('data'),
      shoes: $('.chaussures .active').attr('data'),
      watches: $('.montre .active').attr('data'),
    }));
  });
  $('.arrow').on('click', function(e){
    e.preventDefault();
    $.post('http://skincreator/updateSkin', JSON.stringify({
      value: false,
      // Face
      gender: $('input:radio[name=gender]:checked', '#formSkinCreator').val(),
      dad: $('input[name=pere]:checked', '#formSkinCreator').val(),
      mum: $('input[name=mere]:checked', '#formSkinCreator').val(),
      dadmumpercent: $('.morphologie').val(),
      color: $('input[name=peaucolor]:checked', '#formSkinCreator').val(),
      eyecolor: $('input[name=eyecolor]:checked','#formSkinCreator').val(),
      acne: $('.acne').val(),
      skinproblem: $('.pbpeau').val(),
      freckle: $('.tachesrousseur').val(),
      wrinkle: $('.rides').val(),
      wrinkleopacity: $('.rides').val(),
      hair: $('.hair').val(),
      haircolor1: $('input[name=haircolor1]:checked', '#formSkinCreator').val(),
      haircolor2: $('input[name=haircolor2]:checked', '#formSkinCreator').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formSkinCreator').val(),
      makeupopacity: $('.makeupopacity').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formSkinCreator').val(),
      // Clothes
      hats: $('.chapeaux .active').attr('data'),
      glasses: $('.lunettes .active').attr('data'),
      ears: $('.oreilles .active').attr('data'),
      tops: $('.hauts .active').attr('data'),
      bazo: $('.bazo .active').attr('data'),
      pants: $('.pantalons .active').attr('data'),
      shoes: $('.chaussures .active').attr('data'),
      watches: $('.montre .active').attr('data'),
    }));
  });

  // Form submited
  $('.yes').on('click', function(e){
    e.preventDefault();
    $.post('http://skincreator/updateSkin', JSON.stringify({
      value: true,
      // Face
      gender: $('input:radio[name=gender]:checked', '#formSkinCreator').val(),
      dad: $('input[name=pere]:checked', '#formSkinCreator').val(),
      mum: $('input[name=mere]:checked', '#formSkinCreator').val(),
      dadmumpercent: $('.morphologie').val(),
      color: $('input[name=peaucolor]:checked', '#formSkinCreator').val(),
      eyecolor: $('input[name=eyecolor]:checked','#formSkinCreator').val(),
      acne: $('.acne').val(),
      skinproblem: $('.pbpeau').val(),
      freckle: $('.tachesrousseur').val(),
      wrinkle: $('.rides').val(),
      wrinkleopacity: $('.rides').val(),
      hair: $('.hair').val(),
      haircolor1: $('input[name=haircolor1]:checked', '#formSkinCreator').val(),
      haircolor2: $('input[name=haircolor2]:checked', '#formSkinCreator').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formSkinCreator').val(),
      makeupopacity: $('.makeupopacity').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formSkinCreator').val(),
      // Clothes
      hats: $('.chapeaux .active').attr('data'),
      glasses: $('.lunettes .active').attr('data'),
      ears: $('.oreilles .active').attr('data'),
      tops: $('.hauts .active').attr('data'),
      bazo: $('.bazo .active').attr('data'),
      pants: $('.pantalons .active').attr('data'),
      shoes: $('.chaussures .active').attr('data'),
      watches: $('.montre .active').attr('data'),
    }));
  }); 
  // Rotate player
  $(document).keypress(function(e) {
    if(e.which == 97){ // A pressed
      $.post('http://skincreator/rotaterightheading', JSON.stringify({
        value: 10
      }));
    }
    if(e.which == 100){ // E pressed
      $.post('http://skincreator/rotateleftheading', JSON.stringify({
        value: 10
      }));
    }
  });

  // Zoom out camera for clothes
  $('.tab a').on('click', function(e){
    e.preventDefault();
    $.post('http://skincreator/zoom', JSON.stringify({
      zoom: $(this).attr('data-link')
    }));
    $('#formSkinCreator').animate({
      scrollTop: 0
    }, 400);
  });
});
function ChangeAtt(){
  $("#skinCreatort").show();
}

