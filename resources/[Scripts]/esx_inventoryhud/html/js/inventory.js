var type = "normal";
var name1 = "";
var name2 = "";
var player;
var weapon;

function animateCSS(element, animationName, callback) {
    const node = document.querySelector(element)
    node.classList.add('animated', animationName)

    function handleAnimationEnd() {
        node.classList.remove('animated', animationName)
        node.removeEventListener('animationend', handleAnimationEnd)

        if (typeof callback === 'function') callback()
    }

    node.addEventListener('animationend', handleAnimationEnd)
}

function Loading(){
    return '<div class="preloader-wrapper big active">' + 
                '<div class="spinner-layer spinner-blue">' + 
                    '<div class="circle-clipper left">' + 
                        '<div class="circle"></div>' + 
                    '</div><div class="gap-patch">' + 
                        '<div class="circle"></div>' + 
                    '</div><div class="circle-clipper right">' + 
                        '<div class="circle"></div>' + 
                    '</div>' + 
                '</div>' + 
                '<div class="spinner-layer spinner-red">' + 
                    '<div class="circle-clipper left">' + 
                        '<div class="circle"></div>' + 
                    '</div><div class="gap-patch">' + 
                        '<div class="circle"></div>' + 
                    '</div><div class="circle-clipper right">' + 
                        '<div class="circle"></div>' + 
                    '</div>' + 
                '</div>' + 
                '<div class="spinner-layer spinner-yellow">' + 
                    '<div class="circle-clipper left">' + 
                        '<div class="circle"></div>' + 
                    '</div><div class="gap-patch">' + 
                        '<div class="circle"></div>' + 
                    '</div><div class="circle-clipper right">' + 
                        '<div class="circle"></div>' + 
                    '</div>' + 
                '</div>' + 
                '<div class="spinner-layer spinner-green">' + 
                    '<div class="circle-clipper left">' + 
                        '<div class="circle"></div>' + 
                    '</div><div class="gap-patch">' + 
                        '<div class="circle"></div>' + 
                    '</div><div class="circle-clipper right">' + 
                        '<div class="circle"></div>' + 
                    '</div>' + 
                '</div>' + 
            '</div>';
}

window.addEventListener("message", function (event) {

    $(".action").hide();

    if (event.data.action == "display") {
        type = event.data.type;

        if (type === "normal") { //เปิดช่องเก็บของ
            $("#col-other").hide();
            $("#col-inventory").removeClass();
            $('#playerInventory').css('width', '1020px');
        } else if (type === "trunk") { //เปิดท้ายรถ
            $("#col-other").show();
            $('#playerInventory').css('width', '580px');
            $('#otherInventory').css('width', '580px');
            $("#col-inventory").removeClass().addClass("col s6");
        } else if (type === "house") { //เปิดช่องเก็บของบ้าน
            $("#col-other").show();
            $('#playerInventory').css('width', '580px');
            $('#otherInventory').css('width', '580px');
            $("#col-inventory").removeClass().addClass("col s6");
        } else if (type === "gang") { //เปิดช่องเก็บของบ้าน
            $("#col-other").show();
            $('#playerInventory').css('width', '580px');
            $('#otherInventory').css('width', '580px');
            $("#col-inventory").removeClass().addClass("col s6");
        } else if (type === "box") { //เปิดช่องเก็บของบ้าน
            $("#col-other").show();
            $('#playerInventory').css('width', '580px');
            $('#otherInventory').css('width', '580px');
            $("#col-inventory").removeClass().addClass("col s6");
        }
        
        $(".ui").show();
        //animateCSS('.ui', 'fadeIn');

    } else if (event.data.action == "hide") {
        $(".ui").hide();
        $(".item").remove();
        $("#col-other").hide();
        $("#col-inventory").removeClass();
    } else if (event.data.action == "setItems") {
        $("#playerInventory").hide();
        inventorySetup(event.data.itemList);
        if (type === "trunk") {
            $(".content-action-inventory").hide();
            $(".content-action-house").hide();
            $(".content-action-gang").hide();
            $(".content-action-box").hide();
            $(".content-action-trunk").show();
        }else if (type === "house") {
            $(".content-action-inventory").hide();
            $(".content-action-trunk").hide();
            $(".content-action-gang").hide();
            $(".content-action-box").hide();
            $(".content-action-house").show();
        }else if (type === "gang") {
            $(".content-action-inventory").hide();
            $(".content-action-trunk").hide();
            $(".content-action-gang").show();
            $(".content-action-box").hide();
            $(".content-action-house").hide();
        }else if (type === "box") {
            $(".content-action-inventory").hide();
            $(".content-action-trunk").hide();
            $(".content-action-gang").hide();
            $(".content-action-box").show();
            $(".content-action-house").hide();
        }else{
            $(".content-action-house").hide();
            $(".content-action-gang").hide();
            $(".content-action-box").hide();
            $(".content-action-trunk").hide();
            $(".content-action-inventory").show();
            $('[data-button="'+event.data.CurrentMenu+'"]').trigger('click');
        }

        $("#playername").hide();
        $("#playerInventory").show();
        name1 = "";
        name2 = "";
        player = null;
        weapon = null;

    } else if (event.data.action == "setItemsPolice") {
        name1 = event.data.name1;
        name2 = event.data.name2;
        player = event.data.player;
        weapon = event.data.weapon;
        $("#playerInventory").hide();
        inventoryPoliceSetup(event.data.itemList);
        $(".content-action-house").hide();
        $(".content-action-gang").hide();
        $(".content-action-box").hide();
        $(".content-action-trunk").hide();
        $(".content-action-inventory").show();
        $('[data-button="inventory_all"]').trigger('click');
        $("#sort_item").hide();
        $("#playername").text(name1 + " " + name2).show();

        $("#playerInventory").show();
        

    } else if (event.data.action == "setSecondInventoryItems") {
        VehicleInventorySetup(event.data.itemList);
    } else if (event.data.action == "setHouseInventoryItems") {
        HouseInventorySetup(event.data.itemList);
    } else if (event.data.action == "setGangInventoryItems") {
        GangInventorySetup(event.data.itemList);
    } else if (event.data.action == "setBoxInventoryItems") {
        BoxInventorySetup(event.data.itemList);
    } else if (event.data.action == "setInfoText") {
        $("#info-div").html(event.data.text);
    } else if (event.data.action == "nearPlayers") {
        $("#modal_give > .modal-content").html("");

        $.each(event.data.players, function (index, player) {
            $("#modal_give > .modal-content").append('<button class="waves-effect waves-red btn-flat btn-near-player white-text" data-player="' + player.player + '">#' + player.label + '</button>');
        });

        $("#modal_give").modal("open");

        $(".btn-near-player").click(function () {
            $("#modal_give").modal("close");
            player = $(this).data("player");
            $.post("http://esx_inventoryhud/GiveItem", JSON.stringify({
                player: player,
                item: event.data.item,
                item_plate: event.data.plate,
                number: parseInt($("#txt_count").val())
            }));
        });
    }
});

function closeInventory() {
    $.post("http://esx_inventoryhud/NUIFocusOff", JSON.stringify({}));
}

function inventoryPoliceSetup(items) {
    $("#playerInventory").html("");
    $.each(items, function (index, item) {
        count = setCount(item);
        var using_icon = 'done';
        var itemtype = "normal";
        var itemimage = "items"
        if(item.name == "water" || item.name == "cola"){
            using_icon = 'local_drink';
        }else if(item.name == "bread" || item.name == "burger" || item.name == "hotdog" || item.name == "taco" || item.name == "burrito" || item.name == "sanwich" || item.name == "donut1" || item.name == "donut2" || item.name == "pie"){
            using_icon = 'restaurant_menu';
        }else if(item.name == "smoke"){
            using_icon = 'smoking_rooms';
        }else if(item.name == "key"){
            using_icon = 'vpn_key';
        }

        if(item.name == "water" || item.name == "cola" || item.name == "bread" || item.name == "burger" || item.name == "hotdog" || item.name == "taco" || item.name == "burrito" || item.name == "sanwich"){
            itemtype = "item_food";
        }else if(item.name == "key" || item.name == "keyhouse"){
            itemtype = "item_key";
        }

        if(item.type == "item_weapon"){
            itemtype = "item_weapon";
        }

        if(item.type == "item_accessories"){
            itemtype = "item_accessories";
            itemimage = "clothes";
        }

        itemname = item.label;
        
        var html_items = '<div id="item-' + index + '" class="col slot-1 action faster" style="padding: 0px;display: none;" data-index="'+ index +'" data-type="inventory" data-item-type="'+ itemtype +'">' + 
                                    '<div class="card slot z-depth-0">' +
                                        '<div class="card-image" align="center" style="padding: 15px;">' +
                                            '<img src="img/' + itemimage + '/' + item.name + '.png" style="width: 120px;height: 120px;">' + 
                                            //'<span class="card-title">'+ item.label +'</span>' + 
                                        '</div>' + 
                                        '<div class="card-content" align="center" style="padding: 0;text-transform: capitalize;">' +  itemname + '</div>' + 
                                        '<div class="card-content" align="center" style="padding: 10px 0 10px 0;">' + count + '</div>' + 
                                        '<div class="card-content content-action-inventory" align="center" style="padding: 0px 0 10px 0;">' + 
                                            '<a data-index="'+ index +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="margin-right: 10px;opacity: 0.9;display: none" data-action="use_police"><i class="material-icons">done</i></a>' + 
                                            '<a data-index="'+ index +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="margin-right: 10px;opacity: 0.9" data-action="give_police"><i class="material-icons">card_giftcard</i></a>' + 
                                        '</div>' + 
                                    '</div>' + 
                                 '</div>';
        $("#playerInventory").append(html_items);
        animateCSS('#item-' + index, 'zoomIn');
        if(item.usable){
            $('#item-' + index + ' [data-action="use"]').show();
        }else{
            $('#item-' + index + ' [data-action="use"]').hide();
        }

        //if(item.canRemove == false){
        //    $('[data-index="'+ index +'"][data-action="drop"]').hide();
        //}

        /*$("#playerInventory").append('<div class="slot"><div id="item-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');*/
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");

        if (type === "normal") { //เปิดช่องเก็บของ
            $('[data-type="inventory"]').css('width', '20%');
            $('[data-item-type="item_key"]').show();
            $('[data-item-type="item_accessories"]').show();
            $('#sort_item').show();
        } else if (type === "trunk") { //เปิดท้ายรถ
            $(".slot-1").show();
            $('[data-type="inventory"]').css('width', '33.3333333333%');
            $('[data-type="inventory_trunk"]').css('width', '33.3333333333%');
            $('#sort_item').hide();
            $('[data-item-type="item_key"]').hide();
            $('[data-item-type="item_accessories"]').hide();
        } else if (type === "house") { //เปิดช่องเก็บของบ้าน
            $(".slot-1").show();
            $('[data-type="inventory"]').css('width', '33.3333333333%');
            $('[data-type="inventory_house"]').css('width', '33.3333333333%');
            $('#sort_item').hide();
            $('[data-item-type="item_key"]').hide();
            $('[data-item-type="item_accessories"]').hide();
        } else if (type === "gang") { //เปิดช่องเก็บของบ้าน
            $(".slot-1").show();
            $('[data-type="inventory"]').css('width', '33.3333333333%');
            $('[data-type="inventory_gang"]').css('width', '33.3333333333%');
            $('#sort_item').hide();
            $('[data-item-type="item_key"]').hide();
            $('[data-item-type="item_accessories"]').hide();
        } else if (type === "box") { //เปิดช่องเก็บของบ้าน
            $(".slot-1").show();
            $('[data-type="inventory"]').css('width', '33.3333333333%');
            $('[data-type="inventory_box"]').css('width', '33.3333333333%');
            $('#sort_item').hide();
            $('[data-item-type="item_key"]').hide();
            $('[data-item-type="item_accessories"]').hide();
        }

        if(item.type == "item_accessories"){
            $('[data-index="' + index + '"][data-action="use_police"]').show();
        }

    });
}

function inventorySetup(items) {
    $("#playerInventory").html("");
    $.each(items, function (index, item) {
        count = setCount(item);
        var using_icon = 'done';
        var itemtype = "normal";
        var itemimage = "items"
        if(item.name == "water" || item.name == "cola" || item.name == "beer" || item.name == "energy_drink" || item.name == "coffee" || item.name == "juice"){
            using_icon = 'local_drink';
        }else if(item.name == "bread" || item.name == "burger" || item.name == "hotdog" || item.name == "taco" || item.name == "burrito" || item.name == "sanwich"  || item.name == "donut1" || item.name == "donut2" || item.name == "pie"){
            using_icon = 'restaurant_menu';
        }else if(item.name == "smoke"){
            using_icon = 'smoking_rooms';
        }else if(item.name == "key"){
            using_icon = 'vpn_key';
        }

        if(item.name == "water" || item.name == "cola" || item.name == "bread" || item.name == "burger" || item.name == "hotdog" || item.name == "taco" || item.name == "burrito" || item.name == "sanwich" || item.name == "beer" || item.name == "energy_drink" || item.name == "donut1" || item.name == "donut2" || item.name == "pie" || item.name == "coffee" || item.name == "juice"){
            itemtype = "item_food";
        }else if(item.name == "key" || item.name == "keyhouse"){
            itemtype = "item_key";
        }

        if(item.type == "item_weapon"){
            itemtype = "item_weapon";
        }

        if(item.type == "item_accessories"){
            itemtype = "item_accessories";
            itemimage = "clothes";
        }

        itemname = item.label;
        
        var html_items = '<div id="item-' + index + '" class="col slot-1 action faster" style="padding: 0px;display: none;" data-index="'+ index +'" data-type="inventory" data-item-type="'+ itemtype +'">' + 
                                    '<div class="card slot z-depth-0">' +
                                        '<div class="card-image" align="center" style="padding: 15px;">' +
                                            '<img src="img/' + itemimage + '/' + item.name + '.png" style="width: 120px;height: 120px;">' + 
                                            //'<span class="card-title">'+ item.label +'</span>' + 
                                        '</div>' + 
                                        '<div class="card-content" align="center" style="padding: 0;text-transform: capitalize;">' +  itemname + '</div>' + 
                                        '<div class="card-content" align="center" style="padding: 10px 0 10px 0;">' + count + '</div>' + 
                                        '<div class="card-content content-action-inventory" align="center" style="padding: 0px 0 10px 0;">' + 
                                            '<button type="button" data-index="'+ index +'" class="btn-floating btn-medium btn-flat waves-effect waves-green" style="margin-right: 10px;opacity: 0.9" data-action="use"><i class="material-icons">' + using_icon + '</i></button>' + 
                                            '<a data-index="'+ index +'" class="btn-floating btn-medium btn-flat waves-effect waves-light" style="margin-right: 10px;opacity: 0.9" data-action="give"><i class="material-icons">card_giftcard</i></a>' + 
                                            '<a data-index="'+ index +'" class="btn-floating btn-medium btn-flat waves-effect waves-light" style="margin-right: 10px;opacity: 0.9" data-action="drop"><i class="material-icons">delete</i></a>' +
                                            '</div>' + 
                                        '<div class="card-content content-action-trunk" align="center" style="padding: 0px 0 10px 0;">' + 
                                            '<a data-index="'+ index +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="margin: 0px;opacity: 0.9;" data-action="inventory_to_trunk"><i class="material-icons">chevron_right</i></a>' + 
                                        '</div>' + 
                                        '<div class="card-content content-action-house" align="center" style="padding: 0px 0 10px 0;">' + 
                                            '<a data-index="'+ index +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="margin: 0px;opacity: 0.9;" data-action="inventory_to_house"><i class="material-icons">chevron_right</i></a>' + 
                                        '</div>' + 
                                        '<div class="card-content content-action-gang" align="center" style="padding: 0px 0 10px 0;">' + 
                                            '<a data-index="'+ index +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="margin: 0px;opacity: 0.9;" data-action="inventory_to_gang"><i class="material-icons">chevron_right</i></a>' + 
                                        '</div>' + 
                                        '<div class="card-content content-action-box" align="center" style="padding: 0px 0 10px 0;">' + 
                                            '<a data-index="'+ index +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="margin: 0px;opacity: 0.9;"</a>' + 
                                        '</div>' + 
                                    '</div>' + 
                                 '</div>';
        $("#playerInventory").append(html_items);
        animateCSS('#item-' + index, 'zoomIn');
        if(item.usable){
            $('#item-' + index + ' [data-action="use"]').show();
        }else{
            $('#item-' + index + ' [data-action="use"]').hide();
        }

        if(item.canRemove == false){
            $('[data-index="'+ index +'"][data-action="drop"]').hide();
        }

        /*$("#playerInventory").append('<div class="slot"><div id="item-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');*/
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");

        if (type === "normal") { //เปิดช่องเก็บของ
            $('[data-type="inventory"]').css('width', '20%');
            $('[data-item-type="item_key"]').show();
            $('[data-item-type="item_accessories"]').show();
            $('#sort_item').show();
        } else if (type === "trunk") { //เปิดท้ายรถ
            $(".slot-1").show();
            $('[data-type="inventory"]').css('width', '33.3333333333%');
            $('[data-type="inventory_trunk"]').css('width', '33.3333333333%');
            $('#sort_item').hide();
            $('[data-item-type="item_key"]').hide();
            $('[data-item-type="item_accessories"]').hide();
        } else if (type === "house") { //เปิดท้ายรถ
            $(".slot-1").show();
            $('[data-type="inventory"]').css('width', '33.3333333333%');
            $('[data-type="inventory_house"]').css('width', '33.3333333333%');
            $('#sort_item').hide();
            $('[data-item-type="item_key"]').hide();
            $('[data-item-type="item_accessories"]').hide();
        } else if (type === "gang") { //เปิดท้ายรถ
            $(".slot-1").show();
            $('[data-type="inventory"]').css('width', '33.3333333333%');
            $('[data-type="inventory_gang"]').css('width', '33.3333333333%');
            $('#sort_item').hide();
            $('[data-item-type="item_key"]').hide();
            $('[data-item-type="item_accessories"]').hide();
        } else if (type === "box") { //เปิดท้ายรถ
            $(".slot-1").show();
            $('[data-type="inventory"]').css('width', '33.3333333333%');
            $('[data-type="inventory_box"]').css('width', '33.3333333333%');
            $('#sort_item').hide();
            $('[data-item-type="item_key"]').hide();
            $('[data-item-type="item_accessories"]').hide();
        }

        if(item.type == "item_accessories"){
            $('[data-index="' + index + '"][data-action="give"]').hide();
        }

    });
}

function VehicleInventorySetup(items) {
    $("#otherInventory").html("");
    $.each(items, function (index, item) {
        if(item.type != "item_key"){
            if (item.type === "item_weapon") {
                count = setCount(item);
            }else{
                count = item.count
            }
            var itemtype = "normal";
            if(item.name == "water" || item.name == "cola" || item.name == "bread" || item.name == "burger" || item.name == "hotdog" || item.name == "taco" || item.name == "burrito" || item.name == "sanwich"){
                itemtype = "item_food";
            }else if(item.name == "key"){
                itemtype = "item_key"
            }
            var html_items = '<div id="itemOther-' + index + '" class="col slot-1 action faster" style="padding: 0px;width:33.3333333333%" data-type="inventory_trunk" data-type="'+ item.type +'" data-item-type="'+ itemtype +'">' + 
                                        '<div class="card slot z-depth-0">' +
                                            '<div class="card-image" align="center" style="padding: 15px;">' +
                                                '<img src="img/items/' + item.name + '.png" style="width: 120px;height: 120px;">' + 
                                            '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 0;text-transform: capitalize;">' +  item.label + '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 10px 0 10px 0;">' + count + '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 0px 0 10px 0;">' + 
                                                '<a data-index="'+ index +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="margin-right: 0px;opacity: 0.9" data-action="trunk_to_inventory"><i class="material-icons">chevron_left</i></a>' + 
                                            '</div>' + 
                                        '</div>' + 
                                    '</div>';
            $("#otherInventory").append(html_items);
			animateCSS('#itemOther-' + index, 'zoomIn');
            $('#itemOther-' + index).data('item', item);
            $('#itemOther-' + index).data('inventory', "second");

        }
    });
}

function HouseInventorySetup(items) {
    $("#otherInventory").html("");
    $.each(items, function (index, item) {
        if(item.type != "item_key"){
            if (item.type === "item_weapon") {
                count = setCount(item);
            }else{
                count = item.count
            }
            var itemtype = "normal";
            if(item.name == "water" || item.name == "cola" || item.name == "bread" || item.name == "burger" || item.name == "hotdog" || item.name == "taco" || item.name == "burrito" || item.name == "sanwich"){
                itemtype = "item_food";
            }else if(item.name == "key"){
                itemtype = "item_key"
            }
            var html_items = '<div id="itemOther-' + index + '" class="col slot-1 action faster" style="padding: 0px;width:33.3333333333%" data-type="inventory_house" data-type="'+ item.type +'" data-item-type="'+ itemtype +'">' + 
                                        '<div class="card slot z-depth-0">' +
                                            '<div class="card-image" align="center" style="padding: 15px;">' +
                                                '<img src="img/items/' + item.name + '.png" style="width: 120px;height: 120px;">' + 
                                            '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 0;text-transform: capitalize;">' +  item.label + '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 10px 0 10px 0;">' + count + '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 0px 0 10px 0;">' + 
                                                '<a data-index="'+ index +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="margin-right: 0px;opacity: 0.9" data-action="house_to_inventory"><i class="material-icons">chevron_left</i></a>' + 
                                            '</div>' + 
                                        '</div>' + 
                                    '</div>';
            $("#otherInventory").append(html_items);
			animateCSS('#itemOther-' + index, 'zoomIn');
            $('#itemOther-' + index).data('item', item);
            $('#itemOther-' + index).data('inventory', "second");

        }
    });
}

function GangInventorySetup(items) {
    $("#otherInventory").html("");
    $.each(items, function (index, item) {
        if(item.type != "item_key"){
            if (item.type === "item_weapon") {
                count = setCount(item);
            }else{
                count = item.count
            }
            var itemtype = "normal";
            if(item.name == "water" || item.name == "cola" || item.name == "bread" || item.name == "burger" || item.name == "hotdog" || item.name == "taco" || item.name == "burrito" || item.name == "sanwich"){
                itemtype = "item_food";
            }else if(item.name == "key"){
                itemtype = "item_key"
            }
            var html_items = '<div id="itemOther-' + index + '" class="col slot-1 action faster" style="padding: 0px;width:33.3333333333%" data-type="inventory_gang" data-type="'+ item.type +'" data-item-type="'+ itemtype +'">' + 
                                        '<div class="card slot z-depth-0">' +
                                            '<div class="card-image" align="center" style="padding: 15px;">' +
                                                '<img src="img/items/' + item.name + '.png" style="width: 120px;height: 120px;">' + 
                                            '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 0;text-transform: capitalize;">' +  item.label + '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 10px 0 10px 0;">' + count + '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 0px 0 10px 0;">' + 
                                                '<a data-index="'+ index +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="margin-right: 0px;opacity: 0.9" data-action="gang_to_inventory"><i class="material-icons">chevron_left</i></a>' + 
                                            '</div>' + 
                                        '</div>' + 
                                    '</div>';
            $("#otherInventory").append(html_items);
			animateCSS('#itemOther-' + index, 'zoomIn');
            $('#itemOther-' + index).data('item', item);
            $('#itemOther-' + index).data('inventory', "second");

        }
    });
}

function BoxInventorySetup(items) {
    $("#otherInventory").html("");
    $.each(items, function (index, item) {
        if(item.type != "item_key"){
            if (item.type === "item_weapon") {
                count = setCount(item);
            }else{
                count = item.count
            }
            var itemtype = "normal";
            if(item.name == "water" || item.name == "cola" || item.name == "bread" || item.name == "burger" || item.name == "hotdog" || item.name == "taco" || item.name == "burrito" || item.name == "sanwich"){
                itemtype = "item_food";
            }else if(item.name == "key"){
                itemtype = "item_key"
            }
            var html_items = '<div id="itemOther-' + index + '" class="col slot-1 action faster" style="padding: 0px;width:33.3333333333%" data-type="inventory_box" data-type="'+ item.type +'" data-item-type="'+ itemtype +'">' + 
                                        '<div class="card slot z-depth-0">' +
                                            '<div class="card-image" align="center" style="padding: 15px;">' +
                                                '<img src="img/items/' + item.name + '.png" style="width: 120px;height: 120px;">' + 
                                            '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 0;text-transform: capitalize;">' +  item.label + '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 10px 0 10px 0;">' + count + '</div>' + 
                                            '<div class="card-content" align="center" style="padding: 0px 0 10px 0;">' + 
                                                '<a data-index="'+ index +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="margin-right: 0px;opacity: 0.9" data-action="box_to_inventory"><i class="material-icons">chevron_left</i></a>' + 
                                            '</div>' + 
                                        '</div>' + 
                                    '</div>';
            $("#otherInventory").append(html_items);
			animateCSS('#itemOther-' + index, 'zoomIn');
            $('#itemOther-' + index).data('item', item);
            $('#itemOther-' + index).data('inventory', "second");

        }
    });
}

function setCount(item) {
    count = item.count

    if (item.limit > 0) {
        count = item.count + "/" + item.limit
    }

    if (item.type === "item_weapon") {
        if (count == 0) {
            count = "1";
        } else {
            count = '<img src="img/bullet.png" class="ammoIcon"> ' + item.count;
        }
    }

    if (item.type === "item_account" || item.type === "item_money") {
        count = formatMoney(item.count);
    }

    return count;
}

function formatMoney(n, c, d, t) {
    var c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;

    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
};

$(document).ready(function () {
    $("#count").focus(function () {
        $(this).val("")
    }).blur(function () {
        if ($(this).val() == "") {
            $(this).val("1")
        }
    });

    $("body").on("keyup", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            closeInventory();
        }
    });

    $('body').on('click','[data-action="use"]', function(){
        var btn = $(this);
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");

        btn.attr('disabled', true);
        btn.css('opacity', 0.3);

        setTimeout(function(){
            btn.attr('disabled', false);
            btn.css('opacity', 0.9);
        }, 2000)

        if (itemData.usable) {
            $.post("http://esx_inventoryhud/UseItem", JSON.stringify({
                item: itemData
            }));
        }
        
       
    });

    
    $('body').on('click','[data-button]', function(){
        $("#playerInventory").show();
        var type = $(this).attr('data-button');
        var type_value = 'inventory_key';
        if(type == "inventory_key"){
            $('[data-item-type]').hide();
            $('[data-item-type="item_key"]').show();
            type_value = 'inventory_key';
        }else if(type == "inventory_food"){
            $('[data-item-type]').hide();
            $('[data-item-type="item_food"]').show();
            type_value = 'inventory_food';
        }else if(type == "inventory_weapon"){
            $('[data-item-type]').hide();
            $('[data-item-type="item_weapon"]').show();
            type_value = 'inventory_weapon';
        }else if(type == "inventory_clothes"){
            $('[data-item-type]').hide();
            $('[data-item-type="item_accessories"]').show();
            type_value = 'inventory_clothes';
        }else{
            $('[data-item-type]').show();
            type_value = 'inventory_all';
        }

        $.post("http://esx_inventoryhud/SetCurrentMenu", JSON.stringify({
            type: type_value
        }));

    });

    $('body').on('click','.action [data-action="give"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        if(itemData.type == "item_weapon"){
            $.post("http://esx_inventoryhud/GetNearPlayers", JSON.stringify({
                item: itemData
            }));
        }else{
            $('#modal_count').modal('open');
            $('#item-submit').attr('data-action','give');
            $('#item-submit').attr('data-index',index);
        }
    });

    $('body').on('click','.action [data-action="use_police"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        $.post("http://esx_inventoryhud/UseMask", JSON.stringify({
            item: itemData,
            other: player
        }));
    });

    $('body').on('click','.action [data-action="give_police"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        if(itemData.type == "item_weapon"){
            //$.post("http://esx_inventoryhud/GetNearPlayers", JSON.stringify({
            //   item: itemData
            //}));
			$.post("http://esx_inventoryhud/GiveItemPolice", JSON.stringify({
				item: itemData,
				other: player,
				name1: name1,
				name2: name2,
				number: 1,
				weapon: weapon
			}));
        }else{
            $('#modal_count').modal('open');
            $('#item-submit').attr('data-action','give_police');
            $('#item-submit').attr('data-index',index);
        }
    });

    $('body').on('click','.action [data-action="drop"]', function(){
        var index = $(this).attr('data-index');
        $('#modal_count').modal('open');
        $('#item-submit').attr('data-action','drop');
        $('#item-submit').attr('data-index',index);
    });

    $('body').on('click','#item-submit[data-action="give"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        var count = parseInt($('#txt_count').val());
        if(itemData.type == "item_key" || itemData.type == "item_keyhouse"){
            $.post("http://esx_inventoryhud/GetNearPlayers", JSON.stringify({
                item: itemData
            }));
            setTimeout(function() { $("#txt_count").focus(); }, 100);
            $("#modal_count").modal('close');
        }else{
            if(count > 0){
                if (itemData.canRemove) {
                    $.post("http://esx_inventoryhud/GetNearPlayers", JSON.stringify({
                        item: itemData
                    }));
                    setTimeout(function() { $("#txt_count").focus(); }, 100);
                }
                $("#modal_count").modal('close');
            }else{
                $("#text_result").text("Please enter the amount").show();
                return false;
            }
        }
        
    });

    $('body').on('click','#item-submit[data-action="give_police"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        var count = parseInt($('#txt_count').val());
        
        $("#modal_count").modal("close");
        $.post("http://esx_inventoryhud/GiveItemPolice", JSON.stringify({
            item: itemData,
            other: player,
            name1: name1,
            name2: name2,
            number: parseInt($("#txt_count").val()),
            weapon: weapon
        }));
        
    });

    $('body').on('click','#item-submit[data-action="drop"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        var count = parseInt($('#txt_count').val());
        if(count > 0){
            if (itemData.canRemove) {
                $.post("http://esx_inventoryhud/DropItem", JSON.stringify({
                    item: itemData,
                    number: parseInt($('#txt_count').val())
                }));
                setTimeout(function() { $("#txt_count").focus(); }, 100);
            }
            $("#modal_count").modal('close');
        }else{
            $("#text_result").text("Please enter the amount").show();
            return false;
        }
    });

    $('body').on('click','.action [data-action="inventory_to_trunk"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        itemInventory = $('#item-' + index).data("inventory");
        if (type === "trunk" && itemInventory === "main") {
            if(itemData.type == "item_weapon"){
                $.post("http://esx_inventoryhud/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                    number: 1
                }));
            }else{
                $('#modal_count').modal('open');
                $('#item-submit').attr('data-action','drop_to_trunk');
                $('#item-submit').attr('data-index',index);
            }
        }
    });

    $('body').on('click','.action [data-action="inventory_to_house"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        itemInventory = $('#item-' + index).data("inventory");
        if (type === "house" && itemInventory === "main") {
            if(itemData.type == "item_weapon"){
                $.post("http://esx_inventoryhud/PutIntoHouse", JSON.stringify({
                    item: itemData,
                    number: 1
                }));
            }else{
                $('#modal_count').modal('open');
                $('#item-submit').attr('data-action','drop_to_house');
                $('#item-submit').attr('data-index',index);
            }
        }
    });

    $('body').on('click','.action [data-action="inventory_to_gang"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        itemInventory = $('#item-' + index).data("inventory");
        if (type === "gang" && itemInventory === "main") {
            if(itemData.type == "item_weapon"){
                $.post("http://esx_inventoryhud/PutIntoGang", JSON.stringify({
                    item: itemData,
                    number: 1
                }));
            }else{
                $('#modal_count').modal('open');
                $('#item-submit').attr('data-action','drop_to_gang');
                $('#item-submit').attr('data-index',index);
            }
        }
    });

    $('body').on('click','#item-submit[data-action="drop_to_trunk"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        itemInventory = $('#item-' + index).data("inventory");
        var count = parseInt($('#txt_count').val());
        if(count > 0){
            if (type === "trunk" && itemInventory === "main") {
                $.post("http://esx_inventoryhud/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#txt_count").val())
                }));
                setTimeout(function() { $("#txt_count").focus(); }, 100);
            }
            $("#modal_count").modal('close');
        }else{
            $("#text_result").text("Please enter the amount").show();
            return false;
        }
    });

    $('body').on('click','#item-submit[data-action="drop_to_house"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        itemInventory = $('#item-' + index).data("inventory");
        var count = parseInt($('#txt_count').val());
        if(count > 0){
            if (type === "house" && itemInventory === "main") {
                $.post("http://esx_inventoryhud/PutIntoHouse", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#txt_count").val())
                }));
                setTimeout(function() { $("#txt_count").focus(); }, 100);
            }
            $("#modal_count").modal('close');
        }else{
            $("#text_result").text("Please enter the amount").show();
            return false;
        }
    });

    $('body').on('click','#item-submit[data-action="drop_to_gang"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        itemInventory = $('#item-' + index).data("inventory");
        var count = parseInt($('#txt_count').val());
        if(count > 0){
            if (type === "gang" && itemInventory === "main") {
                $.post("http://esx_inventoryhud/PutIntoGang", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#txt_count").val())
                }));
                setTimeout(function() { $("#txt_count").focus(); }, 100);
            }
            $("#modal_count").modal('close');
        }else{
            $("#text_result").text("Please enter the amount").show();
            return false;
        }
    });

    $('body').on('click','[data-action="trunk_to_inventory"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#itemOther-' + index).data("item");
        itemInventory = $('#itemOther-' + index).data("inventory");
        if (type === "trunk" && itemInventory === "second") {
            if(itemData.type == "item_weapon"){
                $.post("http://esx_inventoryhud/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: 1
                }));
            }else{
                $('#modal_count').modal('open');
                $('#item-submit').attr('data-action','drop_to_inventory');
                $('#item-submit').attr('data-index',index);
            }
        }
    });

    $('body').on('click','[data-action="house_to_inventory"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#itemOther-' + index).data("item");
        itemInventory = $('#itemOther-' + index).data("inventory");
        if (type === "house" && itemInventory === "second") {
            if(itemData.type == "item_weapon"){
                $.post("http://esx_inventoryhud/TakeFromHouse", JSON.stringify({
                    item: itemData,
                    number: 1
                }));
            }else{
                $('#modal_count').modal('open');
                $('#item-submit').attr('data-action','house_to_inventory');
                $('#item-submit').attr('data-index',index);
            }
        }
    });

    $('body').on('click','[data-action="gang_to_inventory"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#itemOther-' + index).data("item");
        itemInventory = $('#itemOther-' + index).data("inventory");
        if (type === "gang" && itemInventory === "second") {
            if(itemData.type == "item_weapon"){
                $.post("http://esx_inventoryhud/TakeFromGang", JSON.stringify({
                    item: itemData,
                    number: 1
                }));
            }else{
                $('#modal_count').modal('open');
                $('#item-submit').attr('data-action','gang_to_inventory');
                $('#item-submit').attr('data-index',index);
            }
        }
    });

    $('body').on('click','[data-action="box_to_inventory"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#itemOther-' + index).data("item");
        itemInventory = $('#itemOther-' + index).data("inventory");
        if (type === "box" && itemInventory === "second") {
            if(itemData.type == "item_weapon"){
                $.post("http://esx_inventoryhud/TakeFromBox", JSON.stringify({
                    item: itemData,
                    number: 1
                }));
            }else{
                $('#modal_count').modal('open');
                $('#item-submit').attr('data-action','box_to_inventory');
                $('#item-submit').attr('data-index',index);
            }
        }
    });

    $('body').on('click','#item-submit[data-action="drop_to_inventory"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#itemOther-' + index).data("item");
        itemInventory = $('#itemOther-' + index).data("inventory");
        var count = parseInt($('#txt_count').val());
        if(count > 0){
            if (type === "trunk" && itemInventory === "second") {
                $.post("http://esx_inventoryhud/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#txt_count").val())
                }));
                setTimeout(function() { $("#txt_count").focus(); }, 100);
            }
            $("#modal_count").modal('close');
        }else{
            $("#text_result").text("Please enter the amount").show();
            return false;
        }
    });

    $('body').on('click','#item-submit[data-action="house_to_inventory"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#itemOther-' + index).data("item");
        itemInventory = $('#itemOther-' + index).data("inventory");
        var count = parseInt($('#txt_count').val());
        if(count > 0){
            if (type === "house" && itemInventory === "second") {
                $.post("http://esx_inventoryhud/TakeFromHouse", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#txt_count").val())
                }));
                setTimeout(function() { $("#txt_count").focus(); }, 100);
            }
            $("#modal_count").modal('close');
        }else{
            $("#text_result").text("Please enter the amount").show();
            return false;
        }
    });

    $('body').on('click','#item-submit[data-action="gang_to_inventory"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#itemOther-' + index).data("item");
        itemInventory = $('#itemOther-' + index).data("inventory");
        var count = parseInt($('#txt_count').val());
        if(count > 0){
            if (type === "gang" && itemInventory === "second") {
                $.post("http://esx_inventoryhud/TakeFromGang", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#txt_count").val())
                }));
                setTimeout(function() { $("#txt_count").focus(); }, 100);
            }
            $("#modal_count").modal('close');
        }else{
            $("#text_result").text("Please enter the amount").show();
            return false;
        }
    });

    $('body').on('click','#item-submit[data-action="box_to_inventory"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#itemOther-' + index).data("item");
        itemInventory = $('#itemOther-' + index).data("inventory");
        var count = parseInt($('#txt_count').val());
        if(count > 0){
            if (type === "box" && itemInventory === "second") {
                $.post("http://esx_inventoryhud/TakeFromBox", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#txt_count").val())
                }));
                setTimeout(function() { $("#txt_count").focus(); }, 100);
            }
            $("#modal_count").modal('close');
        }else{
            $("#text_result").text("Please enter the amount").show();
            return false;
        }
    });


    $("#count").on("keypress keyup blur", function (event) {
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
});