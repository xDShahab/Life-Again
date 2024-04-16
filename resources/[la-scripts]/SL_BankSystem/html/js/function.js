$(document).ready(function(){
  
      window.addEventListener('message', function( event ) {      
        if (event.data.type == 'openGeneral') {
         $('body').fadeIn();  
        } 

        if (event.data.type == 'balanceHUD') {
            balance = event.data.balance
            $('#balance-label').text(numberWithCommas(balance) + " $")  
            $('#balance-label2').text(numberWithCommas(balance) + " $")  
        } 
        

        $(document).keyup(function(e) {
            if (e.key === "Escape") {

              
              $('body').fadeOut();
              $.post('http://SL_BankSystem/NUIFocusOff', JSON.stringify({}));

            }
            

        });
        
      });

      function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    }

    $(".deposit-accept").click(function() {
        $.post('http://SL_BankSystem/deposit', JSON.stringify({amount: $("#deposit-amount").val()}));
    });

    $(".deposit-cancel").click(function() {
        $('body').fadeOut();
        $.post('http://SL_BankSystem/NUIFocusOff', JSON.stringify({}));
    });

    $(".withdraw-accept").click(function() {
        $.post('http://SL_BankSystem/withdrawl', JSON.stringify({amount: $("#withdraw-amount").val()}));
    });

    $(".withdraw-cancel").click(function() {
        $('body').fadeOut();
        $.post('http://SL_BankSystem/NUIFocusOff', JSON.stringify({}));
    });
      

    $(".transfer-accept").click(function() {
        $.post('http://SL_BankSystem/transfer', JSON.stringify({
            to: $("#transfer-id").val(),
            amountt: $("#transfer-amount").val()
        }));
    });

    $(".transfer-cancel").click(function() {
        $('body').fadeOut();
        $.post('http://SL_BankSystem/NUIFocusOff', JSON.stringify({}));
    });
      
   
  
  
  
    
    
     
    
    
    
      
    
      
    });