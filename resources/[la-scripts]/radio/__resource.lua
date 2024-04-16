


resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

-- Example custom radios
supersede_radio "RADIO_22_DLC_BATTLE_MIX1_RADIO" { url = "http://live.powerhitz.com/1power?aw_0_req.gdpr=true&esPlayer&cb=507081.mp3", name = "Poweerhitz", volume = 0.9 } -- Radio Faaz
supersede_radio "RADIO_21_DLC_XM17" { url = "http://radio6o8.com:8000/stream", name = "PERSIAN radio2", volume = 0.9 } -- Radio Farda
supersede_radio "RADIO_18_90S_ROCK" { url = "http://37.59.47.192:8200/stream", name = "PERSIAN radio", volume = 0.9 } -- Radio Javan
supersede_radio "RADIO_17_FUNK" { url = "http://37.59.47.192:8200/;", name = "Radio JAVAN", volume = 0.9 } -- Iranian Radio
-- supersede_radio "RADIO_16_SILVERLAKE" { url = "https://dbrm.brtm.ir/dl/mp3s/Reza-Pishro-Zeus-(T-DEY-Remix)-128.mp3", name = "Pishro Zeus Remix", volume = 0.9 } -- Bia2 Radio
-- supersede_radio "RADIO_20_THELAB" { url = "https://dl.evan-music.ir/music/1400/01/Aye%20Cekilin%20Besir%20Gelir%20(320).mp3", name = "Bashir galir", volume = 0.9 } -- Radio Shemroon
-- supersede_radio "RADIO_15_MOTOWN" { url = "http://sv.naghmemusic.ir/archive/s/sina%20mafee/1398/Sina%20Mafee%20&%20Arma%20-%20Ye%20Wan%20Dozd%20128.mp3", name = "Ye Van Dozd Sina Sae", volume = 0.9 } -- Rodio
-- supersede_radio "RADIO_14_DANCE_02" { url = "https://dl3.dabmusics.ir/00/01/Putak%20-%20BUSHIDO%20128%20-%20DabMusic.mp3", name = "Bushido Khashi SR", volume = 0.9 } -- Ava Radio
-- supersede_radio "RADIO_13_JAZZ" { url = "http://dl2.sarimusic.net/Old/1396/08/07/Sa2/Sandy%20-%20Station%207/Sandy%20-%20Station%207/08.%20Arooset%20Mikonom%20[320].mp3", name = "Sandi Aroset mikonam", volume = 0.9 } -- Nava7 Radio
-- supersede_radio "RADIO_12_REGGAE" { url = "https://soundpedia.ir/wp-content/uploads/2019/08/Rick-Ross-Money-In-The-Grave.mp3", name = "Drake Money in the grave", volume = 0.9 } -- Rap Radio

files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}

