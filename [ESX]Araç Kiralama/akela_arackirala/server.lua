ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('akela_arackirala:rentCar')
AddEventHandler('akela_arackirala:rentCar', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 500) then
		xPlayer.removeMoney(500)
		
		notification("-500$ Araba kiraladın!")
		TriggerClientEvent('akela_arackirala:spawnPanto',source)
		
	else
		notification("Yeterli nakitin yok!")
	end		
end)

RegisterServerEvent('akela_arackirala:rentBike')
AddEventHandler('akela_arackirala:rentBike', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 100) then
		xPlayer.removeMoney(100)
		
		notification("-100$ Motor kiraladın!")
		TriggerClientEvent('akela_arackirala:spawnFaggio',source)
		
	else
		notification("Yeterli nakitin yok!")
	end		
end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end