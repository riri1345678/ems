ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

------------------------------------------------------------Shops-----------------------------------------------------------------

RMenu.Add('example', 'main', RageUI.CreateMenu("Ambulance", "Achat"))
RMenu.Add('example', 'ambulance', RageUI.CreateSubMenu(RMenu:Get('example', 'main'), "Ambulance", "Menu Ambulance"))

------ Variable Sous Menu

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('example', 'main'), true, true, true, function()

            RageUI.Button("Ambulance", "Choisis le type de soin !", {RightLabel = "→→→"},true, function()
            end, RMenu:Get('example', 'ambulance'))
        end, function()
        end)

        -- Bandage & Kit
            RageUI.IsVisible(RMenu:Get('example', 'ambulance'), true, true, true, function()

                RageUI.Button("Bandage", "Bandage pour soigner les citoyens !", {RightLabel = "~g~Gratuit"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerServerEvent('kaiiroz:BuyBandage')
                    end
                end)
                RageUI.Button("Kit de soin", "Kit de soin pour soigner les citoyens !", {RightLabel = "~g~Gratuit"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerServerEvent('kaiiroz:BuyKit')
                    end
                end)
            end, function()
                ---Panels
            end, 1)
    
            Citizen.Wait(0)
        end
    end)



    ---------------------------------------- Position du Menu --------------------------------------------

    local position = {
        {x = 304.555, y = -600.513, z = 43.283 }
    }


-------- Message shop
    
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then

                   RageUI.Text({
                        message = "Appuyer sur [~r~E~w~] pour acceder a la pharmacie",
                        time_display = 1
                    })
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('example', 'main'), not RageUI.Visible(RMenu:Get('example', 'main')))
                    end
                end
            end
        end
    end)