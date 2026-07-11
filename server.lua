local ShopStates = {}

local Lang = Bridge.GetLocale()

CreateThread(function()
    for jobName in pairs(Config.Shops) do
        ShopStates[jobName] = false
    end
end)

RegisterNetEvent('Astoria-Blips:server:requestStates', function()
    TriggerClientEvent('Astoria-Blips:client:updateAll', source, ShopStates)
end)

RegisterCommand('openshop', function(source)
    local job = Bridge.GetPlayerJob(source)
    if not job then return end

    if not job.onduty then
        Bridge.SendNotify(source, Lang.notify.not_on_duty, 'error')
        return
    end

    if not Config.Shops[job.name] then
        Bridge.SendNotify(source, Lang.notify.not_registered, 'error')
        return
    end

    ShopStates[job.name] = true

    TriggerClientEvent('Astoria-Blips:client:updateShop', -1, job.name, true)

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
        Bridge.SendNotify(source, Lang.notify.not_on_duty, 'error')
        return
    end

    if not Config.Shops[job.name] then
        Bridge.SendNotify(source, Lang.notify.not_registered, 'error')
        return
    end

    ShopStates[job.name] = false

    TriggerClientEvent('Astoria-Blips:client:updateShop', -1, job.name, false)

    Bridge.SendNotify(
        source,
        Config.Shops[job.name].label .. Lang.notify.closed,
        'error'
    )
end, false)