




fx_version 'cerulean'
game 'gta5'

client_scripts {
	"lib/*.lua"
	, "lib/observers/*.lua"
	, "client.lua"

	-- GTA V
	, "gtav/*.lua"   -- Base IPLs to fix holes

	-- GTA Online
	, "gta_online/*.lua"

	-- DLC High Life
	, "dlc_high_life/*.lua"

	-- DLC Heists
	, "dlc_heists/*.lua"

	-- DLC Executives & Other Criminals
	, "dlc_executive/*.lua"

	-- DLC Finance & Felony
	, "dlc_finance/*.lua"

	-- DLC Bikers
	, "dlc_bikers/*.lua"

	-- DLC Import/Export
	, "dlc_import/*.lua"

	-- DLC Gunrunning
	, "dlc_gunrunning/*.lua"

	-- DLC Smuggler's Run
	, "dlc_smuggler/hangar.lua"

	-- DLC Doomsday Heist
	, "dlc_doomsday/facility.lua"

	-- DLC After Hours
	, "dlc_afterhours/nightclubs.lua"
	
	-- DLC Diamond Casino (Requires forced build 2060 or higher)
	, "dlc_casino/*.lua"
}
