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
   
ESX = nil
local PlayerData              = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end
local gym = {
    {x = -1034.38, y = -2733.33, z = 20.17}
}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(gym) do
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)
			if dist <= 12 then
				DrawMarker(36, gym[k].x, gym[k].y, gym[k].z, 0, 0, 0, 60, 10, 10, 0.801, 0.801, 0.801, 35, 105, 230, 105, false, true, 0, true)
			end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(gym) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)

            if dist <= 0.5 then
				hintToDisplay('Araç kiralamak için ~INPUT_CONTEXT~ bas')
				
				if IsControlJustPressed(0, Keys['E']) then
					openRentMenu()
				end			
            end
        end
    end
end)

function openRentMenu()
    ESX.UI.Menu.CloseAll()	
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'rent_menu',
        {
            title    = 'Araç Kirala',
            elements = {
				{label = 'Araba - 500$', value = 'araba'},
				{label = 'Motorsiklet - 100$', value = 'motor'},
				{label = 'Menüy Kapat', value = 'kapat'},
            }
        },
        function(data, menu)
            if data.current.value == 'araba' then
				TriggerServerEvent("akela_arackirala:rentCar")
			elseif data.current.value == 'motor' then
				TriggerServerEvent("akela_arackirala:rentBike")
			elseif data.current.value == 'kapat' then
				menu.close()
            end
			menu.close()
        end,
        function(data, menu) 
        end
    )
end

RegisterNetEvent('akela_arackirala:spawnFaggio')
AddEventHandler('akela_arackirala:spawnFaggio', function()
    -- account for the argument not being passed
    local vehicleName = 'faggio'

    -- load the model
    RequestModel(vehicleName)

    -- wait for the model to load
    while not HasModelLoaded(vehicleName) do
        Wait(500) -- often you'll also see Citizen.Wait
    end

    -- get the player's position
    local playerPed = PlayerPedId() -- get the local player ped
    local pos = GetEntityCoords(playerPed) -- get the position of the local player ped

    -- create the vehicle
    local vehicle = CreateVehicle(vehicleName, -1033.23, -2730.31, 19.60, GetEntityHeading(playerPed), true, false)

    -- set the player ped into the vehicle's driver seat
    SetPedIntoVehicle(playerPed, vehicle, -1)

    -- give the vehicle back to the game (this'll make the game decide when to despawn the vehicle)
    SetEntityAsNoLongerNeeded(vehicle)

    -- release the model
    SetModelAsNoLongerNeeded(vehicleName)

    -- tell the player
end)
RegisterNetEvent('akela_arackirala:spawnPanto')
AddEventHandler('akela_arackirala:spawnPanto', function()
    -- account for the argument not being passed
    local vehicleName = 'panto'

    -- load the model
    RequestModel(vehicleName)

    -- wait for the model to load
    while not HasModelLoaded(vehicleName) do
        Wait(500) -- often you'll also see Citizen.Wait
    end

    -- get the player's position
    local playerPed = PlayerPedId() -- get the local player ped
    local pos = GetEntityCoords(playerPed) -- get the position of the local player ped

    -- create the vehicle
	
    local vehicle = CreateVehicle(vehicleName, -1033.23, -2730.31, 19.60, GetEntityHeading(playerPed), true, false)
    -- set the player ped into the vehicle's driver seat
	
    SetPedIntoVehicle(playerPed, vehicle, -1)

    -- give the vehicle back to the game (this'll make the game decide when to despawn the vehicle)
    SetEntityAsNoLongerNeeded(vehicle)

    -- release the model
    SetModelAsNoLongerNeeded(vehicleName)
    -- tell the player
end)