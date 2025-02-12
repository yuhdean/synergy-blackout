local blackoutOnSound = 'power_off'  
local blackoutOffSound = 'power_on' 

local blackout = false  

RegisterNetEvent('blackout:sync')
AddEventHandler('blackout:sync', function()
    if blackout then
        TriggerEvent('blackout:turnOff')
        blackout = false
    else
        TriggerEvent('blackout:turnOn')
        blackout = true
    end
end)

RegisterNetEvent('blackout:turnOn')
AddEventHandler('blackout:turnOn', function()
    TriggerEvent('sound:play', blackoutOnSound)
    TriggerEvent('ox_lib:notify', {
        title = 'Blackout',
        description = "California's Power Grid has gone offline!",
        type = 'error'
    })

    for i = 1, 5 do
        local delay = math.random(100, 300)
        SetArtificialLightsState(true) 
        Citizen.Wait(delay) 
        SetArtificialLightsState(false)  
        Citizen.Wait(delay) 
    end

    SetArtificialLightsState(true)
    SetBlackout(true) 

    SetVehicleHeadlightsOnForAll(true)  
end)

RegisterNetEvent('blackout:turnOff')
AddEventHandler('blackout:turnOff', function()
    TriggerEvent('sound:play', blackoutOffSound)
    TriggerEvent('ox_lib:notify', {
        title = 'Blackout',
        description = "California's Power Grid is back online!",
        type = 'success'
    })

    for i = 1, 5 do
        local delay = math.random(100, 300)  
        SetArtificialLightsState(true) 
        Citizen.Wait(delay)
        SetArtificialLightsState(false)  
        Citizen.Wait(delay) 
    end


    SetArtificialLightsState(false)
    SetBlackout(false)

    SetVehicleHeadlightsOnForAll(true) 
end)

RegisterNetEvent('sound:play')
AddEventHandler('sound:play', function(sound)
    SendNUIMessage({
        action = 'playSound',
        sound = sound
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            SetVehicleLights(vehicle, 2) 
        end
    end
end)

function SetVehicleHeadlightsOnForAll(state)
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        SetVehicleLights(vehicle, state and 2 or 0)  
    end
end
