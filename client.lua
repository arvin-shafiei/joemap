local minimap = RequestScaleformMovie("minimap")

Citizen.CreateThread(function()
    while true do
        Wait(1500)
        if Config.Hidemapoutsidecar then
          if Config.Hidemapwhenengineoff then
            local player = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
            if IsPedInAnyVehicle(player, false) and vehicleIsOn then
                ToggleRadar(true)
                SendNUIMessage({mapoutline = true})
                TriggerVehicleLoop()
            else
                ToggleRadar(false)
                SendNUIMessage({mapoutline = false})
                SetRadarZoom(1150)
            end
          else
            local player = PlayerPedId()
            if IsPedInAnyVehicle(player, false) then
                ToggleRadar(true)
                SendNUIMessage({mapoutline = true})
                TriggerVehicleLoop()
            else
                ToggleRadar(false)
                SendNUIMessage({mapoutline = false})
                SetRadarZoom(1150)
            end
          end
        else
            break
        end
    end
end)

local x = -0.025
local y = -0.015

Citizen.CreateThread(function()

	RequestStreamedTextureDict("circlemap", false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
    SetMinimapClipType(1)
    SetMinimapComponentPosition('minimap', 'L', 'B', -0.022, -0.026, 0.16, 0.245)
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', x + 0.21, y + 0.09, 0.071, 0.164)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.032, -0.04, 0.18, 0.22)
    ThefeedSpsExtendWidescreenOn()
    SetRadarBigmapEnabled(true, false)
    Wait(150)
    SetRadarBigmapEnabled(false, false)
end)

ToggleRadar = function(state)
	DisplayRadar(state)
	BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
	ScaleformMovieMethodAddParamInt(3)
	EndScaleformMovieMethod()
end

TriggerVehicleLoop = function()
	Citizen.CreateThread(function()
		ToggleRadar(true)
        SetRadarBigmapEnabled(false, false)
	end)
end
