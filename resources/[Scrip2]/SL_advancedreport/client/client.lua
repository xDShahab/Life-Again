ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob",function(job)
	PlayerData.job = job
end)

RegisterNetEvent('AT_ReportMenu:openmenu')
AddEventHandler('AT_ReportMenu:openmenu', function(source)
	OpenCategory()
end)

RegisterNetEvent('AT_ReportMenu:openreportsmenu')
AddEventHandler('AT_ReportMenu:openreportsmenu', function(source)
	OpenReportsList()
end)

function OpenCategory()
	JayMenu.OpenMenu("CommonMenu")
	
end


Citizen.CreateThread(function(source)
    JayMenu.CreateMenu("CommonMenu", "~o~LifeAgain Report", function() return CloseMenu() end)
    JayMenu.SetSubTitle("CommonMenu", "Select")
	for k, v in ipairs(Config_RPS.ReportCats) do
        JayMenu.CreateSubMenu(v[1], "CommonMenu", v[2])
		JayMenu.SetSubTitle(v[1], v[2])
    end
    while true do
        Citizen.Wait(0)
        if JayMenu.IsMenuOpened("CommonMenu") then  
            for k, v in ipairs(Config_RPS.ReportCats) do
                JayMenu.MenuButton(""..v[2], v[1])
            end
            JayMenu.Display()
        end
        for k, v in ipairs(Config_RPS.ReportCats) do
            if JayMenu.IsMenuOpened(v[1]) then
                if v[1] == "REPORT_MORE" then
                    if JayMenu.Button("Report", ""..v[2]) then end
                    if JayMenu.Button("Report Shoma") then
                        report = KeyboardInput("Enter Report", "", 1000)
                    end
                    if JayMenu.Button(" Send Report") then
                        if report ~= nil then
                            TriggerServerEvent("ReportMenu:SendAdmins", GetPlayerServerId(PlayerId()), report)
                            report = nil
                            JayMenu.CloseMenu()
                        else
                            ESX.ShowNotification("Report Shoma Khali Ast")
                        end
                    end     
                    JayMenu.Display()
                else
                    if JayMenu.Button("Report Shoma",""..v[2].."") then end
                    if JayMenu.Button("Send Report") then
							local category = v[2]
							TriggerServerEvent('AT_ReportMenu:addreport', category ,category)
							JayMenu.CloseMenu()
							--print('slm')
                    end   
                    JayMenu.Display()
                end
            end
        end
    end
end)

local can = true
RegisterCommand("report",function(source, args)
    if can then
        JayMenu.OpenMenu("CommonMenu")
        can = false
    else
        ESX.ShowNotification("Baraye Report Badi Bayad 2 Daghighe Sabr Koni !")
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if not can then
            Wait(Config_RPS.AntiSpamTime)
            can = true
        end
    end
end)


function OpenReportsList()

	ESX.TriggerServerCallback('AT_ReportMenu:reports', function(reports)

		local elements = {
			head = {"Reporter", "Report ID", "Daste", "Bakhsh", "Status", "Gozine"},
			rows = {}
		}

		for i=1, #reports, 1 do

			table.insert(elements.rows, {
				data = reports[i],
				cols = {
					reports[i].name,
					reports[i].reportid,
					reports[i].category,
					reports[i].reason,
					reports[i].status,
					'{{' .. "Answer" .. '|answer}} {{' .. "Close" .. '|close}}'
				}
			})
		end

		ESX.UI.Menu.Open('list', GetCurrentResourceName(), "reports_list_admins", elements, function(data, menu)
			local rep = data.data

			if data.value == 'answer' then
				TriggerServerEvent('AT_ReportMenu:arreport', rep.reportid)
				menu.close()
			elseif data.value == 'close' then
				TriggerServerEvent('AT_ReportMenu:crreport', rep.reportid)
			end
		end, function(data, menu)
			menu.close()
		end)

	end)

end

function Opencheater()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cheater_more_dialog', {
		title = "Matn Report..."
	}, function(data, menu2)

		local repp = data.value
		if repp then
			TriggerServerEvent('AT_ReportMenu:addreport', "Cheater", repp)
			ESX.UI.Menu.CloseAll()
		else
			ESX.ShowNotification("Shoma Hich Matni Vared Nakardid!")
		end

		end, function(data, menu2)
		menu2.close()
	end)
end

function Openproblems()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'problems_more_dialog', {
		title = "Matn Bug..."
	}, function(data, menu2)

		local repp = data.value
		if repp then
			TriggerServerEvent('AT_ReportMenu:addreport', "Problems - BUG", repp)
			ESX.UI.Menu.CloseAll()
		else
			ESX.ShowNotification("Shoma Hich Matni Vared Nakardid!")
		end

		end, function(data, menu2)
		menu2.close()
	end)
end

function Openquest()
	local elements = {
		{label = "درخواست ماشین", value = 'reqcar'},
		{label = "درخواست هلپر", value = 'reqhelper'},
		{label = "سوالات", value = 'questes'},
		{label = "More...", value = 'more'}
	}

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'req_menu',
	{
		title    = "Report System",
		align    = 'center',
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		local actionname = data.current.label
		
		if action == 'reqcar' then
			TriggerServerEvent('AT_ReportMenu:addreport', "درخواست ها",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'reqhelper' then
			TriggerServerEvent('AT_ReportMenu:addreport', "درخواست ها",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'questes' then
			TriggerServerEvent('AT_ReportMenu:addreport', "درخواست ها",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'more' then
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'req_more_dialog', {
				title = "Matn Report..."
			}, function(data, menu2)
		
				local repp = data.value
				if repp then
					TriggerServerEvent('AT_ReportMenu:addreport', "درخواست ها", repp)
					ESX.UI.Menu.CloseAll()
				else
					ESX.ShowNotification("Shoma Hich Matni Vared Nakardid!")
				end
		
			 end, function(data, menu2)
				menu2.close()
			end)
		else
			ESX.ShowNotification("Report Mored Nazar Vojod Nadarad.")
		end
	end, function(data, menu)
      menu.close()
    end)
end

function Openshop()
	local elements = {
		{label = "Gang", value = 'gang'},
		{label = "V.I.P", value = 'vip'},
		{label = "Mashin", value = 'car'},
		{label = "Pool", value = 'money'},
		{label = "More...", value = 'moreeee'}
	}

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'nonrp_menu',
	{
		title    = "Report System",
		align    = 'center',
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		local actionname = data.current.label
		
		if action == 'gang' then
			TriggerServerEvent('AT_ReportMenu:addreport', "Shop",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'vip' then
			TriggerServerEvent('AT_ReportMenu:addreport', "Shop",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'car' then
			TriggerServerEvent('AT_ReportMenu:addreport', "Shop",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'money' then
			TriggerServerEvent('AT_ReportMenu:addreport', "Shop",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'moreeee' then
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'shop_more_dialog', {
				title = "Matn Report..."
			}, function(data, menu2)
		
				local repp = data.value
				if repp then
					TriggerServerEvent('AT_ReportMenu:addreport', "Shop", repp)
					ESX.UI.Menu.CloseAll()
				else
					ESX.ShowNotification("Shoma Hich Matni Vared Nakardid!")
				end
		
			 end, function(data, menu2)
				menu2.close()
			end)
		else
			ESX.ShowNotification("Report Mored Nazar Vojod Nadarad.")
		end
	end, function(data, menu)
      menu.close()
    end)
end

function Openadmins()
	local elements = {
		{label = "Admin Abuse", value = 'ab'},
		{label = "Ghezavat Na Adelane", value = 'gna'},
		{label = "Bi Ehterami", value = 'be'},
		{label = "More...", value = 'moreee'}
	}

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'nonrp_menu',
	{
		title    = "Report System",
		align    = 'center',
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		local actionname = data.current.label
		
		if action == 'ab' then
			TriggerServerEvent('AT_ReportMenu:addreport', "Admins",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'gna' then
			TriggerServerEvent('AT_ReportMenu:addreport', "Admins",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'be' then
			TriggerServerEvent('AT_ReportMenu:addreport', "Admins",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'moreee' then
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'adminsre_more_dialog', {
				title = "Matn Report..."
			}, function(data, menu2)
		
				local repp = data.value
				if repp then
					TriggerServerEvent('AT_ReportMenu:addreport', "Admins", repp)
					ESX.UI.Menu.CloseAll()
				else
					ESX.ShowNotification("Shoma Hich Matni Vared Nakardid!")
				end
		
			 end, function(data, menu2)
				menu2.close()
			end)
		else
			ESX.ShowNotification("Report Mored Nazar Vojod Nadarad.")
		end
	end, function(data, menu)
      menu.close()
    end)
end

function Opennonrp()
	local elements = {
		{label = "Non RP", value = 'nrp'},
		{label = "Vehicle Deathmatch(VDM)", value = 'vdm'},
		{label = "Death Match(DM)", value = 'dm'},
		{label = "Power Gaming(PG)", value = 'pg'},
		{label = "Meta Gaming(MG)", value = 'mg'},
		{label = "Fear RP(FRP)", value = 'frp'},
		{label = "MIX IC OC", value = 'mic'},
		{label = "COP Baiting", value = 'cb'},
		{label = "K.O.S", value = 'kos'},
		{label = "Mercy Killing", value = 'mc'},
		{label = "More...", value = 'more'}
	}

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'nonrp_menu',
	{
		title    = "Report System",
		align    = 'center',
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		local actionname = data.current.label
		
		if action == 'nrp' then
			TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'vdm' then
			TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'dm' then
			TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'pg' then
			TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'mg' then
			TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'frp' then
			TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'mic' then
			TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'cb' then
			TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'kos' then
			TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'mc' then
			TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP",actionname)
			ESX.UI.Menu.CloseAll()
		elseif action == 'more' then
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'nonrp_more_dialog', {
				title = "Matn Report..."
			}, function(data, menu2)
		
				local repp = data.value
				if repp then
					TriggerServerEvent('AT_ReportMenu:addreport', "NON-RP", repp)
					ESX.UI.Menu.CloseAll()
				else
					ESX.ShowNotification("Shoma Hich Matni Vared Nakardid!")
				end
		
			 end, function(data, menu2)
				menu2.close()
			end)
		else
			ESX.ShowNotification("Report Mored Nazar Vojod Nadarad.")
		end
	end, function(data, menu)
      menu.close()
    end)
end