ESX = nil

local isRobbing = false

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(250)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(250)
	end
end)

RegisterNetEvent('yatzzz:soy')
AddEventHandler('yatzzz:soy', function()
    if isRobbing == false then
        ESX.TriggerServerCallback("yatzzz-checkitem", function(output)
            if output > 0 then
                TriggerEvent('mythic_progbar:client:progress', {
                    name = 'jilet',
                    duration = 1800,
                    label = 'Kasa Soyuluyor...',
                    useWhileDead = false,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = false,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    animation = {
                        animDict = "anim@amb@business@coc@coc_unpack_cut_left@",
                        anim = "coke_cut_v1_coccutter",
                    },
                }, function(status)
                    if not status then
                        TriggerEvent('yatzzz:marketsoy')
                    end
                end)
            elseif not output then 
                exports['mythic_notify']:DoHudText('error', 'Üzerinde Maymuncuk Yok', 3000)
            end
        end, "advancedlocpick")
    else
        TriggerEvent('notification', "Şu Anda Soyamazsın", 2)
    end
end)

RegisterNetEvent('yatzzz:marketsoy')
AddEventHandler('yatzzz:marketsoy', function()
    if isRobbing then
        local playerCoords = GetEntityCoords(PlayerPedId(), true)
        for v in pairs(soyulacakYer) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
                TriggerServerEvent('yatzzz:kasasoy')
                isRobbing = true
            end
        end
    end
end)

local soyulacakYer = {
    [1] = {x = 24.46, y = -1344.95, z = 29.5, info = 'Market 1'},
}