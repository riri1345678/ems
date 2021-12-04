--------------------------------

------- Created by Hamza -------

-------------------------------- 



ESX = nil



Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(0)

	end

	while ESX.GetPlayerData().job == nil do

		Citizen.Wait(10)

	end

	PlayerData = ESX.GetPlayerData()

end)



RegisterNetEvent('esx:playerLoaded')

AddEventHandler('esx:playerLoaded', function(xPlayer)

	ESX.PlayerData = xPlayer

end)



RegisterNetEvent('esx:setJob')

AddEventHandler('esx:setJob', function(job)

	ESX.PlayerData.job = job

end)



-- Function for 3D text:

function DrawText3Ds(x,y,z, text)

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

    local px,py,pz=table.unpack(GetGameplayCamCoords())



    SetTextScale(0.32, 0.32)

    SetTextFont(4)

    SetTextProportional(1)

    SetTextColour(255, 255, 255, 255)

    SetTextEntry("STRING")

    SetTextCentre(1)

    AddTextComponentString(text)

    DrawText(_x,_y)

    local factor = (string.len(text)) / 500

    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)

end



-- Blip on Map for Car Garages:

Citizen.CreateThread(function()

	if Config.EnableCarGarageBlip == true then	

		for k,v in pairs(Config.CarZones) do

			for i = 1, #v.Pos, 1 do

				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

				SetBlipSprite(blip, Config.CarGarageSprite)

				SetBlipDisplay(blip, Config.CarGarageDisplay)

				SetBlipScale  (blip, Config.CarGarageScale)

				SetBlipColour (blip, Config.CarGarageColour)

				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")

				AddTextComponentString(Config.CarGarageName)

				EndTextCommandSetBlipName(blip)

			end

		end

	end	

end)



-- Blip on Map for Heli Garages:

Citizen.CreateThread(function()

	if Config.EnableHeliGarageBlip == true then

		for k,v in pairs(Config.HeliZones) do

			for i = 1, #v.Pos, 1 do

				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

				SetBlipSprite(blip, Config.HeliGarageSprite)

				SetBlipDisplay(blip, Config.HeliGarageDisplay)

				SetBlipScale  (blip, Config.HeliGarageScale)

				SetBlipColour (blip, Config.HeliGarageColour)

				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")

				AddTextComponentString(Config.HeliGarageName)

				EndTextCommandSetBlipName(blip)

			end

		end

	end

end)



-- Blip on Map for Boat Garages:

Citizen.CreateThread(function()

	if Config.EnableBoatGarageBlip == true then

		for k,v in pairs(Config.BoatZones) do

			for i = 1, #v.Pos, 1 do

				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

				SetBlipSprite(blip, Config.BoatGarageSprite)

				SetBlipDisplay(blip, Config.BoatGarageDisplay)

				SetBlipScale  (blip, Config.BoatGarageScale)

				SetBlipColour (blip, Config.BoatGarageColour)

				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")

				AddTextComponentString(Config.BoatGarageName)

				EndTextCommandSetBlipName(blip)

			end

		end

	end

end)



local insideMarker = false



-- Core Thread Function:

Citizen.CreateThread(function()

	while true do

		Citizen.Wait(5)

		local coords = GetEntityCoords(PlayerPedId())

		local veh = GetVehiclePedIsIn(PlayerPedId(), false)

		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)

		

		if (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.SPDatabaseName) then

			for k,v in pairs(Config.CarZones) do

				for i = 1, #v.Pos, 1 do

					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

					if (distance < 10.0) and insideMarker == false then

						DrawMarker(Config.SPCarMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.SPCarMarkerScale.x, Config.SPCarMarkerScale.y, Config.SPCarMarkerScale.y, Config.SPCarMarkerColor.r,Config.SPCarMarkerColor.g,Config.SPCarMarkerColor.b,Config.SPCarMarkerColor.a, false, true, 2, true, false, false, false)						

					end

					if (distance < 2.5 ) and insideMarker == false then

						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.CarDraw3DText)

						if IsControlJustPressed(0, Config.KeyToOpenCarGarage) then

							SPGarage('car')

							insideMarker = true

							Citizen.Wait(500)

						end

					end

				end

			end



			for k,v in pairs(Config.HeliZones) do

				for i = 1, #v.Pos, 1 do

					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

					if (distance < 10.0) and insideMarker == false then

						DrawMarker(Config.SPHeliMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.95, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.SPHeliMarkerScale.x, Config.SPHeliMarkerScale.y, Config.SPHeliMarkerScale.z, Config.SPHeliMarkerColor.r,Config.SPHeliMarkerColor.g,Config.SPHeliMarkerColor.b,Config.SPHeliMarkerColor.a, false, true, 2, true, false, false, false)						

					end

					if (distance < 3.0 ) and insideMarker == false then

						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.HeliDraw3DText)

						if IsControlJustPressed(0, Config.KeyToOpenHeliGarage) then

							SPGarage('helicopter')

							insideMarker = true

							Citizen.Wait(500)

						end

					end

				end

			end



			for k,v in pairs(Config.BoatZones) do

				for i = 1, #v.Pos, 1 do

					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

					if (distance < 20.0) and insideMarker == false then

						DrawMarker(Config.SPBoatMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.SPBoatMarkerScale.x, Config.SPBoatMarkerScale.y, Config.SPBoatMarkerScale.z, Config.SPBoatMarkerColor.r,Config.SPBoatMarkerColor.g,Config.SPBoatMarkerColor.b,Config.SPBoatMarkerColor.a, false, true, 2, true, false, false, false)						

					end

					if (distance < 3.0 ) and insideMarker == false then

						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.BoatDraw3DText)

						if IsControlJustPressed(0, Config.KeyToOpenBoatGarage) then

							SPGarage('boat')

							insideMarker = true

							Citizen.Wait(500)

						end

					end

				end

			end



			for k,v in pairs(Config.ExtraZones) do

				for i = 1, #v.Pos, 1 do

					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

					

					if (distance < 10.0) and insideMarker == false and pedInVeh then

						DrawMarker(Config.SPExtraMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.SPExtraMarkerScale.x, Config.SPExtraMarkerScale.y, Config.SPExtraMarkerScale.z, Config.SPExtraMarkerColor.r,Config.SPExtraMarkerColor.g,Config.SPExtraMarkerColor.b,Config.SPExtraMarkerColor.a, false, true, 2, true, false, false, false)

					end

					if (distance < 2.5 ) and insideMarker == false and pedInVeh then

						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.ExtraDraw3DText)

						if IsControlJustPressed(0, Config.KeyToOpenExtraGarage) and GetVehicleClass(veh) == 18 then

							OpenMainMenu()

							insideMarker = true

							Citizen.Wait(500)

						end

					end

				end

			end

		end

	end

end)



-- ambulance Garage Menu:

SPGarage = function(type)

	local elements = {

		{ label = Config.LabelStoreVeh, action = "store_vehicle" },

		{ label = Config.LabelGetVeh, action = "get_vehicle" },

	}

	

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_SPGarage_menu",

		{

			css      = 'vehicle',

                        title    = Config.TitleSPGarage,

			align    = "center",

			elements = elements

		},

	function(data, menu)

		menu.close()

		local action = data.current.action

		if action == "get_vehicle" then

			if type == 'car' then

				VehicleMenu('car')

			elseif type == 'helicopter' then

				VehicleMenu('helicopter')

			elseif type == 'boat' then

				VehicleMenu('boat')

			end

		elseif data.current.action == 'store_vehicle' then

			local veh,dist = ESX.Game.GetClosestVehicle(playerCoords)

			if dist < 3 then

				DeleteEntity(veh)

				ESX.ShowNotification(Config.VehicleParked)

			else

				ESX.ShowNotification(Config.NoVehicleNearby)

			end

			insideMarker = false

		end

	end, function(data, menu)

		menu.close()

		insideMarker = false

	end, function(data, menu)

	end)

end



-- Vehicle Spawn Menu:

VehicleMenu = function(type)

	local storage = nil

	local elements = {}

	local ped = GetPlayerPed(-1)

	local playerPed = PlayerPedId()

	local pos = GetEntityCoords(ped)

	

	if type == 'car' then

		for k,v in pairs(Config.SPVehicles) do

			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'car'})

		end

	elseif type == 'helicopter' then

		for k,v in pairs(Config.SPHelicopters) do

			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'helicopter'})

		end

	elseif type == 'boat' then

		for k,v in pairs(Config.SPBoats) do

			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'boat'})

		end

	end

		

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_SPGarage_vehicle_garage",

		{

			css      = 'vehicle',

                        title    = Config.TitleSPGarage,

			align    = "center",

			elements = elements

		},

	function(data, menu)

		menu.close()

		insideMarker = false

		local plate = exports['esx_vehicleshop']:GeneratePlate()

		VehicleLoadTimer(data.current.model)

		local veh = CreateVehicle(data.current.model,pos.x,pos.y,pos.z,GetEntityHeading(playerPed),true,false)

		SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)

		SetVehicleNumberPlateText(veh,plate)

		

		if type == 'car' then

			ESX.ShowNotification(Config.CarOutFromPolGar)

		elseif type == 'helicopter' then

			ESX.ShowNotification(Config.HeliOutFromPolGar)

		elseif type == 'boat' then

			ESX.ShowNotification(Config.BoatOutFromPolGar)

		end

		

		TriggerEvent("fuel:setFuel",veh,100.0)

		SetVehicleDirtLevel(veh, 0.1)		

	end, function(data, menu)

		menu.close()

		insideMarker = false

	end, function(data, menu)

	end)

end



-- Load Timer Function for Vehicle Spawn:

function VehicleLoadTimer(modelHash)

	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))



	if not HasModelLoaded(modelHash) then

		RequestModel(modelHash)



		while not HasModelLoaded(modelHash) do

			Citizen.Wait(0)

			DisableAllControlActions(0)



			drawLoadingText(Config.VehicleLoadText, 255, 255, 255, 255)

		end

	end

end



-- Loading Text for Vehicles Function:

function drawLoadingText(text, red, green, blue, alpha)

	SetTextFont(4)

	SetTextScale(0.0, 0.5)

	SetTextColour(red, green, blue, alpha)

	SetTextDropshadow(0, 0, 0, 0, 255)

	SetTextDropShadow()

	SetTextOutline()

	SetTextCentre(true)



	BeginTextCommandDisplayText('STRING')

	AddTextComponentSubstringPlayerName(text)

	EndTextCommandDisplayText(0.5, 0.5)

end



-- Fix ambulance Vehicle Command:

RegisterCommand(Config.RepairCommand, function(source, args)

	if ESX.PlayerData.job and (ESX.PlayerData.job.name == Config.SPDatabaseName) then

		SPFix()

	end

end,false)



-- Fix ambulance Vehicle Function:

function SPFix()

	local ped = GetPlayerPed(-1)

	for k,v in pairs(Config.CarZones) do

		for i = 1, #v.Pos, 1 do

			if IsPedInAnyVehicle(ped, true) then

				local veh = GetVehiclePedIsIn(ped, false)

				if GetDistanceBetweenCoords(GetEntityCoords(ped), v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) <= Config.Distance then

					ESX.ShowNotification(Config.VehRepNotify)

					FreezeEntityPosition(veh, true)

					exports['progressBars']:startUI((Config.RepairTime * 1000), Config.Progress1)

					Citizen.Wait((Config.RepairTime * 1000))

					ESX.ShowNotification(Config.VehRepDoneNotify)

					SetVehicleFixed(veh)

					FreezeEntityPosition(veh, false)

				end

			end

		end	

	end

end



-- Clean ambulance Vehicle Command:

RegisterCommand(Config.CleanCommand, function(source, args)

	if ESX.PlayerData.job and (ESX.PlayerData.job.name == Config.SPDatabaseName) then

		SPClean()

	end

end,false)



-- Clean ambulance Vehicle Command:

function SPClean()

	local ped = GetPlayerPed(-1)

	for k,v in pairs(Config.CarZones) do

		for i = 1, #v.Pos, 1 do

			if IsPedInAnyVehicle(ped, true) then

				local veh = GetVehiclePedIsIn(ped, false)

				if GetDistanceBetweenCoords(GetEntityCoords(ped), v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) <= Config.Distance then

					ESX.ShowNotification(Config.VehCleanNotify)

					FreezeEntityPosition(veh, true)

					exports['progressBars']:startUI((Config.CleanTime * 1000), Config.Progress2)

					Citizen.Wait((Config.CleanTime * 1000))

					ESX.ShowNotification(Config.VehCleanDoneNotify)

					SetVehicleDirtLevel(veh, 0.1)

					FreezeEntityPosition(veh, false)

				end

			end

		end	

	end

end



-- ambulance Extra Menu:

function OpenExtraMenu()

	local elements = {}

	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)

	for id=0, 12 do

		if DoesExtraExist(vehicle, id) then

			local state = IsVehicleExtraTurnedOn(vehicle, id) 



			if state then

				table.insert(elements, {

					label = "Extra: "..id.." | "..('<span style="color:green;">%s</span>'):format("On"),

					value = id,

					state = not state

				})

			else

				table.insert(elements, {

					label = "Extra: "..id.." | "..('<span style="color:red;">%s</span>'):format("Off"),

					value = id,

					state = not state

				})

			end

		end

	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {

		css      = 'vehicle',

                title    = Config.TitleSPExtra,

		align    = 'top-left',

		elements = elements

	}, function(data, menu)

		SetVehicleExtra(vehicle, data.current.value, not data.current.state)

		local newData = data.current

		if data.current.state then

			newData.label = "Extra: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")

		else

			newData.label = "Extra: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")

		end

		newData.state = not data.current.state



		menu.update({value = data.current.value}, newData)

		menu.refresh()

	end, function(data, menu)

		menu.close()

	end)

end



-- ambulance Livery Menu:

function OpenLiveryMenu()

	local elements = {}

	

	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))

	local liveryCount = GetVehicleLiveryCount(vehicle)

			

	for i = 1, liveryCount do

		local state = GetVehicleLivery(vehicle) 

		local text

		

		if state == i then

			text = "Livery: "..i.." | "..('<span style="color:green;">%s</span>'):format("On")

		else

			text = "Livery: "..i.." | "..('<span style="color:red;">%s</span>'):format("Off")

		end

		

		table.insert(elements, {

			label = text,

			value = i,

			state = not state

		}) 

	end



	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'livery_menu', {

		 css      = 'vehicle',

                 title    = Config.TitleSPLivery,

		align    = 'top-left',

		elements = elements

	}, function(data, menu)

		SetVehicleLivery(vehicle, data.current.value, not data.current.state)

		local newData = data.current

		if data.current.state then

			newData.label = "Livery: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")

		else

			newData.label = "Livery: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")

		end

		newData.state = not data.current.state

		menu.update({value = data.current.value}, newData)

		menu.refresh()

		menu.close()	

	end, function(data, menu)

		menu.close()		

	end)

end



-- ambulance Extra Main Menu:

function OpenMainMenu()

	local elements = {

		{label = Config.LabelPrimaryCol,value = 'primary'},

		{label = Config.LabelSecondaryCol,value = 'secondary'},

		{label = Config.LabelExtra,value = 'extra'},

		{label = Config.LabelLivery,value = 'livery'}

	}

	ESX.UI.Menu.CloseAll()



	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'color_menu', {

		 css      = 'vehicle',

                 title    = Config.TitleSPExtra,

		align    = 'top-left',

		elements = elements

	}, function(data, menu)

		if data.current.value == 'extra' then

			OpenExtraMenu()

		elseif data.current.value == 'livery' then

			OpenLiveryMenu()

		elseif data.current.value == 'primary' then

			OpenMainColorMenu('primary')

		elseif data.current.value == 'secondary' then

			OpenMainColorMenu('secondary')

		end

	end, function(data, menu)

		menu.close()

		insideMarker = false

	end)

end



-- ambulance Color Main Menu:

function OpenMainColorMenu(colortype)

	local elements = {}

	for k,v in pairs(Config.Colors) do

		table.insert(elements, {

			label = v.label,

			value = v.value

		})

	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_color_menu', {

		 css      = 'vehicle',

                 title    = Config.TitleColorType,

		align    = 'top-left',

		elements = elements

	}, function(data, menu)

		OpenColorMenu(data.current.type, data.current.value, colortype)

	end, function(data, menu)

		menu.close()

	end)

end



-- ambulance Color Menu:

function OpenColorMenu(type, value, colortype)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {

		 css      = 'vehicle',

                 title    = Config.TitleValues,

		align    = 'top-left',

		elements = GetColors(value)

	}, function(data, menu)

		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)

		local pr,sec = GetVehicleColours(vehicle)

		if colortype == 'primary' then

			SetVehicleColours(vehicle, data.current.index, sec)

		elseif colortype == 'secondary' then

			SetVehicleColours(vehicle, pr, data.current.index)

		end

		

	end, function(data, menu)

		menu.close()

	end)

end

