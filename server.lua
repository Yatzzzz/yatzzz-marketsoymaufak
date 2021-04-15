ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('advancedlockpick', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	TriggerClientEvent('yatzzz:soy', _source)

end)

RegisterServerEvent('yatzzz:kasasoy')
AddEventHandler('yatzzz:kasasoy', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemcheck = xPlayer.getInventoryItem('advancedlockpick').count

    if itemcheck > 0 then
        xPlayer.addInventoryItem('cash', Config.Para)
    else
        exports['mythic_notify']:DoHudText('error', 'Üzerinde Maymuncuk Yok!')
    end
end)

ESX.RegisterServerCallback('yatzzz-checkitem', function(source, cb, item, output)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local items = xPlayer.getInventoryItem(item)
		if items == nil then
			cb(0)
		else
			cb(items.count)
		end
	end
end)