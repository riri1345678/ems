ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('kaiiroz:BuyBandage')
AddEventHandler('kaiiroz:BuyBandage', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('bandage', 1)
        TriggerClientEvent('esx:showNotification', source, "~r~Bandage ~w~achetée!")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('kaiiroz:BuyKit')
AddEventHandler('kaiiroz:BuyKit', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('medikit', 1)
        TriggerClientEvent('esx:showNotification', source, "~r~Kit de soin ~w~achetée!")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)