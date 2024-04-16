				
--[[local lastmessage = 1
local messages = {
	[1] = "Discord Server : discord.gg/LifeAgain",
	[2] = "ID haye balaye sare player ha code meli nistand va hich gone estefade IC nadarand, dar sorat estefade IC metagaming mashsob mishavad!",
	[3] = "Az kalamati hamchon azole X va gheyre estefade nakonid, az dastor /ooc estefade konid!",
	[4] = "Admin ha shahrdar nistand, va OOC mahsob mishan lotfan be sorat IC admin ha ra shahrdar seda nazanid!",
	[5] = "Afrade Taze Vared Ba Dastoor [/kits] Kit Starter Khodra Daryaft Konand.",	
	[6] = "Mashin ha ra nemitavnid baraye hamle kardan be shakhse digar bishtar az yekbar ba dalil movajah estefade konid hata agar be movafaghiat naresad!"
}

function AutoMessage()

	if messages[lastmessage] then
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0,255,70, 0.5); border-radius: 3px;"><i class="far fa-newspaper"></i> ⚠️ Rahnama ⚠️<br>  {1}</div>',
			args = { "notimportant", messages[lastmessage] }
		})
		lastmessage = lastmessage + 1
	else
		lastmessage = 1
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0,255,70, 0.5); border-radius: 3px;"><i class="far fa-newspaper"></i> ⚠️ Rahnama ⚠️<br>  {1}</div>',
			args = { "notimportant", messages[lastmessage] }
		})
	end
	
	SetTimeout(420000, AutoMessage)
end

AutoMessage()


LISTPED = {
    "a_m_m_acult_01",
    "a_m_y_acult_02",
    "a_m_o_acult_01",
    "a_m_y_acult_01",
    "u_m_y_juggernaut_01",
    "u_f_m_drowned_01",
    "a_c_sharktiger",
    "s_m_y_swat_01",
    "a_c_sharktiger",
    "a_c_chimp",
    "a_c_humpback",
    "a_c_rhesus",
    "u_m_y_zombie_01",
    "ig_wade",
    "a_m_o_acult_02",
    "a_m_y_acult_02"
}

LISTPEDHASH = {
    123456789,
	349505262,
	-673538407,
	696250687,
	1068876755,
	-929103484,
	-1731772337,
	-912318012,
	-1697435671,
	-1589423867,
	-1280051638,
	402729631,
	-1806291497,
	1457690978,
	-1366884940,
	89139854,
	1446741360,
	1423699487,
	330231874,
	-88831029,
	1641152947,
	1312913862,
	-2018356203,
	-1745486195,
	919005580,
	-2088436577,
	-1859912896,
	435429221,
	793439294,
	68070371,
	653210662,
	-1029146878,
	1347814329,
	-781039234,
	1859912896,
	605602864,
	1982350912,
	1644266841,
	587703123,
	605602864,
	1699403886,
	1982350912,
	-1280051738,
	2120901815,
	1720428295,
	-613248456,
	-48477765,
	228715206,
	1125994524,
	1068876755,
	1720428295,
	355916122,
	1090617681,
	1925237458,
	452351020,
	-1606864033,
	-1736970383,
	891398354,	
	-1106743555,
	1371553700,
	-745300483,
	-398748745,
	-220552467,
	1925237458,
	225514697,
	-782401935,
	321657486,
	-681004504,
	115168927,
	-973145378,
	411102470,
	1702441027,
	664399832,
	-163714847,
	516505552,
	390939205,
	-261389155,
	834315305,
	534725268,
	-1047300121,
	349505262,
	1561705728,
	-85696189,
	1264851357,
	933092024,
    132123123
}
function WHITELISTPED(ped)
    for a,b in ipairs(LISTPED) do
        if GetHashKey(b) == ped then
            return true
        end
    end
    return false
end

function WHITELISTPEDHASH(ped)
    for a,b in ipairs(LISTPEDHASH) do
        if b == ped then
            return true
        end
    end
    return false
end
AddEventHandler('entityCreating', function(entity)
    local entity = entity
    if not DoesEntityExist(entity) then
        return
    end
    local src = NetworkGetEntityOwner(entity)
    local model = GetEntityModel(entity)
    local hash = GetHashKey(entity)
    local playername = GetPlayerName(src)
    if (src == tonumber("0") or src == "" or src == nil) then
        CancelEvent()
        return
    end
    if GetEntityType(entity) == 1 then
            if not WHITELISTPED(model) and not WHITELISTPEDHASH(model) then
                CancelEvent()
                print(GetEntityModel(entity))
            end
    end
end)
]]--