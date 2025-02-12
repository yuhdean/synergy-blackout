local lastExecuted = 0 
local cooldownTime = 17000
local commandPermission = "blackout.use"

RegisterCommand("blackout", function(source, args, rawCommand)
    local currentTime = GetGameTimer() 
    local playerId = source

    if not IsPlayerAceAllowed(playerId, commandPermission) then
        TriggerClientEvent("ox_lib:notify", playerId, {
            title = "Permission Denied",
            description = "You do not have permission to use this command.",
            type = "error"
        })
        return
    end

    if currentTime - lastExecuted < cooldownTime then
        local remainingTime = math.ceil((cooldownTime - (currentTime - lastExecuted)) / 1000) 
        TriggerClientEvent("ox_lib:notify", playerId, {
            title = "Cooldown",
            description = "Please wait " .. remainingTime .. " seconds before using the command again.",
            type = "error"
        })
        return
    end

    lastExecuted = currentTime

    TriggerClientEvent("blackout:sync", -1)  
end)
