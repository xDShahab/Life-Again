local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }
local ESX = nil
local timer = 0
local blipsCops               = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

---===Dont Toch Pls 😂===---
--[[

  Toch XD

]]
local soal1 = {}
local soal2 = {}
local soal3 = {}
local soal4 = {}
local soal5 = {}
local soal1 = true
local soal2 = true
local soal3 = true
local soal4 = true
local soal5 = true
---======================---

HasAlreadyEnteredMarker = false



Citizen.CreateThread(function()
    Holograms()
    KeyControl()
end)

function alireza()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Config.Zones) do
        for i=1, #v.Pos, 1 do
            if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, false) < 2 then
                return true
            end
        end
    end
    return false
end

function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end

function Holograms()
    while true do
        Citizen.Wait(5)
        for k,v in pairs(Config.Zones) do
            for i=1, #v.Pos, 1 do
                if GetDistanceBetweenCoords( v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 then
                    local alireza11 = 11
                    local sizealireza1 = { x = 0.4, y = 0.4, z = 0.4 }
                    local coloralireza2 = { r = 700, g = 0, b = 0 }
                    DrawMarker(alireza11, v.Posm[i].x, v.Posm[i].y, 327.49 , 0.0, 0.0, 0.0, 0, 0.0, 0.0, sizealireza1.x, sizealireza1.y, sizealireza1.z, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)
                    DrawMarker(6, v.Posm[i].x, v.Posm[i].y, v.Posm[i].z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)

                end	             
            end
        end
	end
end


AddEventHandler('onKeyUP', function(control)
    if alireza() then
        if control == 'e' then
            openmenu()
        end
        if control == 'back' then
            ESX.UI.Menu.CloseAll()
        end
    end
end)

---====Open Menu====---

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if alireza() then
            ESX.ShowHelpNotification('~h~Pls [E] To Open Menu')
        else
            Wait(500)
        end
    end 
end)

--====Ped Quest====----

Citizen.CreateThread(function()
    RequestModel(GetHashKey("s_f_y_bartender_01"))
    while not HasModelLoaded(GetHashKey("s_f_y_bartender_01")) do
      Wait(1)
    end
    local Quest = CreatePed(10,  0x780C01BD, -451.09, 1124.7, 324.89, 345.61, false, true)
    SetEntityHeading(Quest, 345.61)
    FreezeEntityPosition(Quest, true)
    SetEntityInvincible(Quest, true)
    SetBlockingOfNonTemporaryEvents(Quest, true)
end)

function openmenu() 

    soal1 = true
    soal2 = true
    soal3 = true
    soal4 = true
    soal5 = true

    local elements = {
        {label = '<b><span style="color:yellow;">🛑: قبل از شروع لطفا موارد ذکر شده در منو بعدی رو با دقت مطالعه کنید</span></b>',    value = 'solo'},
        {label = '<b><span style="color:yellow;">====================</span></b>',   value = '..'},
        {label = '<b><span style="color:yellow;">====================</span></b>',   value = '..'},
        {label = '<b><span style="color:yellow;">💱: ادامه</span></b>',   value = 'badi'},
    }
    ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Question_Menu',
    {
      title    = ('Question_Menu'),
      align    = 'center',
      elements = elements,
    },
    function(data, menu)
        if data.current.value == 'badi' then
            Menu2()
        end
    end)
end


function Menu2() 
    local elements = { 
        {label = '<b><span style="color:yellow;">🛑: این قابلیت برای لول اپ شدن سریع تر شما میباشد</span></b>',    value = 'solo'},
        {label = '<b><span style="color:yellow;">🛑: در ادامه از شما 5 سوال پرسیده میشود و باید به هر 5 سوال جواب درست بدید</span></b>',    value = 'solo'},
        {label = '<b><span style="color:yellow;">🛑: اگر به 5 سوال درست جواب بدید شما یک لول دریافت میکنید </span></b>',    value = 'solo'},
        {label = '<b><span style="color:yellow;">🛑: قبل از شروع حتما قوانین شهری رو مطالعه کنید</span></b>',    value = 'solo'},
        {label = '<b><span style="color:yellow;">💫: discord.gg/wbS5mTgcEJ </span></b>',    value = 'solo'},
        {label = '<b><span style="color:yellow;">====================</span></b>',   value = '..'},
        {label = '<b><span style="color:yellow;">====================</span></b>',   value = '..'},
        {label = '<b><span style="color:yellow;">💱: ادامه</span></b>',   value = 'edameee'},
  }


  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Question_Menu_Q',
    {
      title    = ('Question_Menu_Q'),
      align    = 'center',
      elements = elements,
    },

    function(data, menu)
        if data.current.value == 'edameee' then
            Menu3()
        end
    end)

end


function Menu3() 
    local elements = { 
        {label = '<b><span style="color:yellow;">:در کدام منطقه نمیتوان خفت گیری کرد ؟</span></b>',    value = 'solo'},
        {label = '<b><span style="color:Red;">====================</span></b>',   value = '..'},
        {label = '<b><span style="color:Green;">بیرون شهر   </span></b>',    value = 'new1'},
        {label = '<b><span style="color:Green;">سندی شورز   </span></b>',    value = 'new2'},
        {label = '<b><span style="color:Green;">(سفید new ) دایره سبز   </span></b>',    value = 'new3'},
        {label = '<b><span style="color:Green;">جاده ابریشم </span></b>',    value = 'new4'},
  }


  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Question_Menu_1',
    {
      title    = ('Question_Menu_1'),
      align    = 'center',
      elements = elements,
    },

    function(data, menu)
        if data.current.value == 'new1' then
            Menu4()
            soal2 = false
        elseif data.current.value == 'new2' then
            Menu4()
            soal2 = false
        elseif data.current.value == 'new3' then
            Menu4()
           -- soal1 = true
        elseif data.current.value == 'new4' then
            Menu4()
            soal2 = false
        end
    end)
end


function Menu4() 
    local elements = { 
        {label = '<b><span style="color:yellow;">:بعد از اینکه به هر دلیلی از سرور بیرون رفتید در روند آر پی … دقیقه زمان دارید برگردید  ؟</span></b>',    value = 'solo'},
        {label = '<b><span style="color:Red;">====================</span></b>',   value = '..'},
        {label = '<b><span style="color:Green;">10 دقیقه    </span></b>',    value = 'new21'},
        {label = '<b><span style="color:Green;">15 دقیقه    </span></b>',    value = 'new22'},
        {label = '<b><span style="color:Green;">20 دقیقه    </span></b>',    value = 'new23'},
        {label = '<b><span style="color:Green;">5 دقیقه </span></b>',    value = 'new24'},
  }


  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Question_Menu_2',
    {
      title    = ('Question_Menu_2'),
      align    = 'center',
      elements = elements,
    },

    function(data, menu)
        if data.current.value == 'new21' then
            Menu5()
            soal2 = false
        elseif data.current.value == 'new22' then
            Menu5()
            --dOROST
        elseif data.current.value == 'new23' then
            Menu5()
            soal2 = false
        elseif data.current.value == 'new24' then
            Menu5()
            soal2 = false
        end
    end)
end


function Menu5() 
    local elements = { 
        {label = '<b><span style="color:yellow;">  کدام یک از گزینه های زیر مصداق فیر ارپی نمیباشد ؟ </span></b>',    value = 'solo'},
        {label = '<b><span style="color:Red;">====================</span></b>',   value = '..'},
        {label = '<b><span style="color:Green;">  هنگامی که اسلحه از فاصله ی نزدیک روی شما گرفته شده(پیاده یا سوار بر موتور) </span></b>',    value = 'new31'},
        {label = '<b><span style="color:Green;"> وقتی که شخصی برای نوشتن سوال در  آرپی اسلحه خود را پایین میاورد. </span></b>',    value = 'new32'},
        {label = '<b><span style="color:Green;"> هنگامی که اسلحه از فاصله ی نزدیک روی شما گرفته شده در حالی که شما در ماشین روشن و سالم نشسته اید. </span></b>',    value = 'new33'},
        {label = '<b><span style="color:Green;">  هنگامی که اسلحه از فاصله ی نزدیک روی شما گرفته شده در حالی که شما در ماشین خاموش نشسته اید. </span></b>',    value = 'new34'},
  }


  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Question_Menu_3',
    {
      title    = ('Question_Menu_3'),
      align    = 'center',
      elements = elements,
    },

    function(data, menu)
        if data.current.value == 'new31' then
            Menu6()

            soal2 = false
        elseif data.current.value == 'new32' then
            Menu6()
            soal2 = false
        elseif data.current.value == 'new33' then
            Menu6()
            --soal3 = true
        elseif data.current.value == 'new34' then
            Menu6()
            soal2 = false
        end
    end)
end


function Menu6()

    local elements = { 
        {label = '<b><span style="color:yellow;">آیا میتوان پلیس را به دلیل ایست ترافیکی به قتل رساند ؟</span></b>',    value = 'solo'},
        {label = '<b><span style="color:Red;">====================</span></b>',   value = '..'},
        {label = '<b><span style="color:Green;">  بله چون کی او اس داده است</span></b>',    value = 'new31'},
        {label = '<b><span style="color:Green;">  بله اگر بیرون دایره سبز باشد  </span></b>',    value = 'new42'},
        {label = '<b><span style="color:Green;"> خیر ،  مگر اینکه ماسک داشته باشم. </span></b>',    value = 'new43'},
        {label = '<b><span style="color:Green;">خیر تحت هیچ شرایطی نمیتوان پلیسی که ایست ترافیکی میدهد را کشت.  </span></b>',    value = 'new44'},
  }


  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Question_Menu_4',
    {
      title    = ('Question_Menu_4'),
      align    = 'center',
      elements = elements,
    },

    function(data, menu)
        if data.current.value == 'new31' then
            Menu8()
            soal2 = false
        elseif data.current.value == 'new42' then
            Menu8()
            soal2 = false
        elseif data.current.value == 'new43' then
            Menu8()
            soal2 = false
        elseif data.current.value == 'new44' then
            Menu8()
           -- soal4 = true
        end
    end)

end



function Menu8()
    local elements = { 
        {label = '<b><span style="color:yellow;">  در چه زمانی میتوان کی او اس  گرفت ؟ </span></b>',    value = 'solo'},
        {label = '<b><span style="color:Red;">====================</span></b>',   value = '..'},
        {label = '<b><span style="color:Green;">  وقتی درگیری لفظی بین دو نفر اتفاق افتاده است .</span></b>',    value = 'new51'},
        {label = '<b><span style="color:Green;"> وقتی رجز خوانی و کل کل بین  دو گنگ اتفاق بیافتد .  </span></b>',    value = 'new52'},
        {label = '<b><span style="color:Green;"> وقتی پلیس روی من اسلحه گرفته باشه .  </span></b>',    value = 'new53'},
        {label = '<b><span style="color:Green;"> وقتی شخصی به ماشین شما بیشتر از سه مرتبه ضربه بزند .  </span></b>',    value = 'new54'},
  }


  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Question_Menu_5',
    {
      title    = ('Question_Menu_5'),
      align    = 'center',
      elements = elements,
    },

    function(data, menu)
        if data.current.value == 'new51' then
            Menu9()
            soal2 = false
        elseif data.current.value == 'new52' then
            Menu9()
            soal2 = false
        elseif data.current.value == 'new53' then
            Menu9()
            soal2 = false
        elseif data.current.value == 'new54' then
            Menu9()
            --soal5 = true
        end
    end)

end


function Menu9()
    ESX.UI.Menu.CloseAll()

    TriggerEvent("mythic_progbar:client:progress", {
        name = "alireza_at",
        duration = 10500,
        label = "در حال پردازش  جواب سوال های داده شده",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    })

    Citizen.Wait(10500)


    if soal1 and soal2 and soal3 and soal4 and soal5 then 
        ESX.ShowNotification('Shoma Ba Movafaghiyat Be 5 Soal Javab Dorost Dadid.')
        TriggerServerEvent('AT_Question:Chekplayer', GetPlayerServerId(PlayerId()))
    else
        ESX.ShowNotification('Shoma Natavanestid Be 5 Soal Dorost Javadb Bedid.')
    end

    soal1 = true
    soal2 = true
    soal3 = true
    soal4 = true
    soal5 = true

end