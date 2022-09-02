local QBCore = exports['qb-core']:GetCoreObject()
local ped = PlayerPedId()
local PakaianKerja = false
local SimpanKeMobil = false
local Ayamayaman = {}
local Ayamspan = false
local didekatayam = false
local packmobil = false
local ayamm = true
CreateThread(function()
    for k, v in pairs(Config.Locations["dutyayam"]) do
	exports['qb-target']:AddBoxZone("gantipakaian"..k, vector3(v.x, v.y, v.z), 3, 3, {
		name = "gantipakaian"..k,
		debugPoly = false,
		heading = 0,
	}, {
		options = {
			{
				type = "client",
				event = "gantibajukerja",
				icon = "fa fa-clipboard",
				label = "Ganti Baju",
			},
            {
				event = "gantibajubiasa",
				icon = "fa fa-clipboard",
				label = "Ganti Baju Biasa",
			}

		},
		distance = 1.5
	})
end
end)

RegisterNetEvent("gantibajubiasa", function()
    PakaianKerja = false
    Wait(100)
    TriggerEvent("fivem-appearance:client:reloadSkin")
end)

RegisterNetEvent("gantibajukerja", function()
    PakaianKerja = true
    local PlayerData = QBCore.Functions.GetPlayerData()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("clothh", "progress", 3500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "missmic4",
        anim = "michael_tux_fidget",
        flags = 16,
    }, {}, {}, function() -- Done
        if PlayerData.charinfo.gender == 0 then 
            SetPedComponentVariation(ped, 3, Config.Clothes.male['arms'], 0, 0) --arms
			    SetPedComponentVariation(ped, 8, Config.Clothes.male['tshirt_1'], Config.Clothes.male['tshirt_2'], 0) --t-shirt
			        SetPedComponentVariation(ped, 11, Config.Clothes.male['torso_1'], Config.Clothes.male['torso_2'], 0) --torso2
			            SetPedComponentVariation(ped, 9, Config.Clothes.male['bproof_1'], Config.Clothes.male['bproof_2'], 0) --vest
			                    SetPedComponentVariation(ped, 10, Config.Clothes.male['decals_1'], Config.Clothes.male['decals_2'], 0) --decals
			                    SetPedComponentVariation(ped, 7, Config.Clothes.male['chain_1'], Config.Clothes.male['chain_2'], 0) --accessory
			                SetPedComponentVariation(ped, 4, Config.Clothes.male['pants_1'], Config.Clothes.male['pants_2'], 0) -- pants
			            SetPedComponentVariation(ped, 6, Config.Clothes.male['shoes_1'], Config.Clothes.male['shoes_2'], 0) --shoes
			        SetPedPropIndex(ped, 0, Config.Clothes.male['helmet_1'], Config.Clothes.male['helmet_2'], true) --hat
			    SetPedPropIndex(ped, 2, Config.Clothes.male['ears_1'], Config.Clothes.male['ears_2'], true) --ear
     
            PakaianKerja = true
            else
			SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
			    SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0) --t-shirt
			        SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0) --torso2
			            SetPedComponentVariation(ped, 9, Config.Clothes.female['bproof_1'], Config.Clothes.female['bproof_2'], 0) --vest
			                SetPedComponentVariation(ped, 10, Config.Clothes.female['decals_1'], Config.Clothes.female['decals_2'], 0) --decals
			                SetPedComponentVariation(ped, 7, Config.Clothes.female['chain_1'], Config.Clothes.female['chain_2'], 0) --accessory
			                SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0) -- pants
			            SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0) --shoes
			        SetPedPropIndex(ped, 0, Config.Clothes.female['helmet_1'], Config.Clothes.female['helmet_2'], true) --hat
			    SetPedPropIndex(ped, 2, Config.Clothes.female['ears_1'], Config.Clothes.female['ears_2'], true) --ear
        
            PakaianKerja = true
    end				
end)
end)

DiKendaraan = function()
	local playerPed    = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local inDirection  = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	local rayHandle    = StartShapeTestRay(playerCoords, inDirection, 10, playerPed, 0)
	local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
	if hit == 1 and GetEntityType(entityHit) == 2 then
		return entityHit
	end
	return nil
end

CreateThread(function()
    for k, v in pairs(Config.Locations["ayam1"]) do
	exports['qb-target']:AddBoxZone("astartayam"..k, vector3(v.x, v.y, v.z), 2, 2, {
		name = "astartayam"..k,
		debugPoly = false,
		heading = 0,
	}, {
		options = {
			{
				type = "client",
				event = "startayam",
				icon = "fa fa-clipboard",
				label = "start ayam",
                canInteract = function(entity) return PakaianKerja and ayamm end
			}

		},
		distance = 1.5
	})
end
end)


RegisterNetEvent("startayam")
AddEventHandler("startayam", function()
    local ped = PlayerPedId()
        QBCore.Functions.Progressbar("ayamprog", "progressbar", 3500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "creatures@rottweiler@tricks@",
            anim = "petting_franklin",
            flags = 16,
        }, {}, {}, function() -- Done
            ClearPedTasks(ped)
            StopAnimTask(ped, "creatures@rottweiler@tricks@", "exit", 1.0)
            QBCore.Functions.Notify("Success", 'success')
        PackKeKendaraan()
    end)
end)

function PackKeKendaraan(posisi)
    packmobil = true
    ayamm = false
    RequestModel(GetHashKey('a_c_hen'))
    while not HasModelLoaded(GetHashKey('a_c_hen')) do
    Wait(1)
    end
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    boxobject = CreatePed(26, "a_c_hen", x, y, z,  true,  true, true)
    AttachEntityToEntity(boxobject, ped, GetPedBoneIndex(ped, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
    while packmobil do
    Wait(250)
    local Kendaraan   = DiKendaraan()
    local coords    = GetEntityCoords(ped)
    SetVehicleDoorOpen(Kendaraan, 5, false, false)
    LoadDict('anim@heists@box_carry@')
        if not IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3 ) and packmobil == true then
        TaskPlayAnim(ped, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        end
        if DoesEntityExist(Kendaraan) then
        packmobil = false
        ayamm = true
        QBCore.Functions.Notify("Success", 'success')
        LoadDict('anim@heists@narcotics@trash')
        TaskPlayAnim(ped, 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        Wait(900)
        ClearPedTasks(ped)
        DeleteEntity(boxobject)
        Wait(500)
        SetVehicleDoorShut(Kendaraan, 5, false, false)
TriggerServerEvent('dapat:ayam')
        end
    end
end

CreateThread(function()
    for k, v in pairs(Config.Locations["potong1"]) do
	exports['qb-target']:AddBoxZone("ayamstart1", vector3(v.x, v.y, v.z), 3, 3, {
		name = "ayamstart1",
		debugPoly = false,
		heading = 0,
	}, {
		options = {
			{
				type = "client",
				event = "prosessayam1",
				icon = "fa fa-clipboard",
				label = "Start Cut",
                canInteract = function(entity) return PakaianKerja end
			}

		},
		distance = 1.5
	})
end
end)

CreateThread(function()
    for k, v in pairs(Config.Locations["potong2"]) do
	exports['qb-target']:AddBoxZone("ayamstart12", vector3(v.x, v.y, v.z), 3, 3, {
		name = "ayamstart12",
		debugPoly = false,
		heading = 0,
	}, {
		options = {
			{
				type = "client",
				event = "prosessayam12",
				icon = "fa fa-clipboard",
				label = "Start Cut",
                canInteract = function(entity) return PakaianKerja end
			}

		},
		distance = 1.5
	})
end
end)

RegisterNetEvent('prosessayam1')
AddEventHandler('prosessayam1', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem == false then
            QBCore.Functions.Notify("tidak punya item", 'error')
        else
        local ped = PlayerPedId()
        local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
        LoadDict(dict)
        TaskPlayAnim(ped, dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local PedCoords = GetEntityCoords(ped)
        local pisauobj = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
        AttachEntityToEntity(pisauobj, ped, GetPedBoneIndex(ped, 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
 
            SetEntityHeading(ped, 311.0)
            ayamobjj = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)
            SetEntityRotation(ayamobjj,90.0, 0.0, 45.0, 1,true)
  
            QBCore.Functions.Progressbar("potong", 'progress', 5000, false, true, {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
        DeleteEntity(pisauobj)
        DeleteEntity(ayamobjj)
        ClearPedTasks(ped)
        TriggerServerEvent('dapat:ayam2')
        QBCore.Functions.Notify("Success", 'success')
       end)
    end
end,'ayam')
end)
RegisterNetEvent('prosessayam12')
AddEventHandler('prosessayam12', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem == false then
            QBCore.Functions.Notify("tidak punya item", 'error')
        else
            local ped = PlayerPedId()
        local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
        LoadDict(dict)
        TaskPlayAnim(ped, dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local PedCoords = GetEntityCoords(ped)
        local pisauobj = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
        AttachEntityToEntity(pisauobj, ped, GetPedBoneIndex(ped, 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
 
        SetEntityHeading(ped, 222.0)
        ayamobjj = CreateObject(GetHashKey('prop_int_cf_chick_01'),-100.39, 6201.56, 29.99, true, true, true)
        SetEntityRotation(ayamobjj,90.0, 0.0, -45.0, 1,true)
  
        QBCore.Functions.Progressbar("potong", 'progress', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
        DeleteEntity(pisauobj)
        DeleteEntity(ayamobjj)
        ClearPedTasks(ped)
        TriggerServerEvent('dapat:ayam2')
        QBCore.Functions.Notify("Success", 'success')
       end)
    end
end,'ayam')
end)

CreateThread(function()
    for k, v in pairs(Config.Locations["prosess"]) do
	exports['qb-target']:AddBoxZone("prosseess"..k, vector3(v.x, v.y, v.z), 3, 3, {
		name = "prosseess"..k,
		debugPoly = false,
		heading = 0,
	}, {
		options = {
			{
				type = "client",
				event = "package",
				icon = "fa fa-clipboard",
				label = "Start package",
                canInteract = function(entity) return PakaianKerja end
			}

		},
		distance = 1.5
	})
end
end)

RegisterNetEvent('package')
RegisterNetEvent('package', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem == false then
            QBCore.Functions.Notify("tidak punya item", 'error')
        else
            local ped = PlayerPedId()
        local PedCoords = GetEntityCoords(ped)
        local dagingobj = CreateObject(GetHashKey('prop_cs_steak'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
        AttachEntityToEntity(dagingobj, ped, GetPedBoneIndex(ped, 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        local boxobj = CreateObject(GetHashKey('prop_cs_clothes_box'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
        AttachEntityToEntity(boxobj, ped, GetPedBoneIndex(ped, 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
        LoadDict("anim@heists@ornate_bank@grab_cash_heels")
        TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
        QBCore.Functions.Progressbar("package", 'progress', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
        ClearPedTasks(ped)
        DeleteEntity(dagingobj)
        DeleteEntity(boxobj)
        TriggerServerEvent('dapat:ayam3')
        QBCore.Functions.Notify("Success", 'success')
       end)
    end
end,'ayam2')
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Wait(10)
    end
end
