local minimap = RequestScaleformMovie("minimap")


Citizen.CreateThread(function()
    while true do
        Wait(2000)
        if IsPedInAnyVehicle(PlayerPedId(-1), false) then
            ToggleRadar(true)
            SendNUIMessage({mapoutline = true})
            TriggerVehicleLoop()
        else
            ToggleRadar(false)
            SendNUIMessage({mapoutline = false})
            SetRadarZoom(1150)
        end

    end
end)

local x = -0.025
local y = -0.015
local w = 0.16
local h = 0.25

Citizen.CreateThread(function()

	RequestStreamedTextureDict("circlemap", false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

    SetMinimapClipType(1)
    SetMinimapComponentPosition('minimap', 'L', 'B', -0.015, -0.025, 0.16, 0.24)
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', x + 0.17, y + 0.09, 0.072, 0.164)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.035, -0.03, 0.18, 0.22)
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
