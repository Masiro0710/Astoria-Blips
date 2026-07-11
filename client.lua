local Blips = {}

local Lang = Bridge.GetLocale()

local function CreateShopBlip(jobName, isOpen)
    if Blips[jobName] then
        RemoveBlip(Blips[jobName])
        Blips[jobName] = nil
    end

    local data = Config.Shops[jobName]
    if not data then return end

    local blipData = isOpen and data.openBlip or data.closedBlip

    local blip = AddBlipForCoord(
        blipData.coords.x,
        blipData.coords.y,
        blipData.coords.z
    )

    SetBlipSprite(blip, blipData.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, blipData.scale)
    SetBlipColour(blip, blipData.color)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(('%s (%s)'):format(
        data.label,
        isOpen and Lang.blip.open or Lang.blip.closed
    ))
    EndTextCommandSetBlipName(blip)

    Blips[jobName] = blip
end

RegisterNetEvent('Astoria-Blips:client:updateShop', function(jobName, isOpen)
    CreateShopBlip(jobName, isOpen)
end)

RegisterNetEvent('Astoria-Blips:client:updateAll', function(states)
    for jobName, isOpen in pairs(states) do
        CreateShopBlip(jobName, isOpen)
    end
end)

local function RequestShopStates()
    Wait(2000)
    TriggerServerEvent('Astoria-Blips:server:requestStates')
end

Bridge.RegisterPlayerLoaded(function()
    RequestShopStates()
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    RequestShopStates()
end)