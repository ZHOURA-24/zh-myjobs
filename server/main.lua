local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('dapat:ayam', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("ayam", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["ayam"], "add")
end)

RegisterNetEvent('dapat:ayam2', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("ayam2", 1)
    Player.Functions.RemoveItem("ayam", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["ayam"], "remove")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["ayam2"], "add")
end)

RegisterNetEvent('dapat:ayam3', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("ayam3", 1)
    Player.Functions.RemoveItem("ayam2", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["ayam2"], "remove")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["ayam3"], "add")
end)

