local ShopStates = {}

local Lang = Bridge.GetLocale()

CreateThread(function()
    for jobName in pairs(Config.Shops) do
        ShopStates[jobName] = false
    end
end)

local function GetOnDutyCount(jobName)
    local count = 0

    for _, playerId in pairs(GetPlayers()) do
        local src = tonumber(playerId)
        local job = Bridge.GetPlayerJob(src)

        if job
            and job.name == jobName
            and job.onduty then
            count = count + 1
        end
    end

    return count
end

local function CloseShopIfEmpty(jobName)
    if not Config.Shops[jobName] then
        return
    end

    if not ShopStates[jobName] then
        return
    end

    local onDutyCount = GetOnDutyCount(jobName)

    if onDutyCount <= 0 then
        ShopStates[jobName] = false

        TriggerClientEvent(
            'Astoria-Blips:client:updateShop',
            -1,
            jobName,
            false
        )

        print(
            ('[Astoria-Blips] %s automatically changed to preparing because no players are on duty.')
            :format(jobName)
        )
    end
end

RegisterNetEvent('Astoria-Blips:server:requestStates', function()
    TriggerClientEvent(
        'Astoria-Blips:client:updateAll',
        source,
        ShopStates
    )
end)

RegisterCommand('openshop', function(source)
    local job = Bridge.GetPlayerJob(source)
    if not job then return end

    if not job.onduty then
        Bridge.SendNotify(
            source,
            Lang.notify.not_on_duty,
            'error'
        )
        return
    end

    if not Config.Shops[job.name] then
        Bridge.SendNotify(
            source,
            Lang.notify.not_registered,
            'error'
        )
        return
    end

    ShopStates[job.name] = true

    TriggerClientEvent(
        'Astoria-Blips:client:updateShop',
        -1,
        job.name,
        true
    )

    Bridge.SendNotify(
        source,
        Config.Shops[job.name].label .. Lang.notify.opened,
        'success'
    )
end, false)

RegisterCommand('closeshop', function(source)
    local job = Bridge.GetPlayerJob(source)
    if not job then return end

    if not job.onduty then
        Bridge.SendNotify(
            source,
            Lang.notify.not_on_duty,
            'error'
        )
        return
    end

    if not Config.Shops[job.name] then
        Bridge.SendNotify(
            source,
            Lang.notify.not_registered,
            'error'
        )
        return
    end

    ShopStates[job.name] = false

    TriggerClientEvent(
        'Astoria-Blips:client:updateShop',
        -1,
        job.name,
        false
    )

    Bridge.SendNotify(
        source,
        Config.Shops[job.name].label .. Lang.notify.closed,
        'error'
    )
end, false)

CreateThread(function()
    while true do
        Wait(5000)

        for jobName, isOpen in pairs(ShopStates) do
            if isOpen then
                CloseShopIfEmpty(jobName)
            end
        end
    end
end)

AddEventHandler('playerDropped', function()

end)
