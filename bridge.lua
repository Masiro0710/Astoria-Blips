Bridge = {}

Bridge.Framework = nil
Bridge.FrameworkObject = nil
Bridge.Notify = nil
Bridge.Lang = nil

local ResourceName = GetCurrentResourceName()

--------------------------------------------------
-- Framework Validation
--------------------------------------------------

local ValidFrameworks = {
    auto_detect = true,
    qbcore = true,
    qbox = true,
    esx = true,
}

if not ValidFrameworks[Config.Framework] then
    error((
        '[%s] Invalid Config.Framework ("%s").\n' ..
        'Valid options: auto_detect, qbcore, qbox, esx'
    ):format(ResourceName, tostring(Config.Framework)))
end

--------------------------------------------------
-- Framework Detection
--------------------------------------------------

Bridge.FrameworkMode = "Manual"

if Config.Framework == "auto_detect" then

    Bridge.FrameworkMode = "Auto Detected"

    if GetResourceState("qbx_core") == "started" then

        Bridge.Framework = "qbox"

    elseif GetResourceState("qb-core") == "started" then

        Bridge.Framework = "qbcore"

    elseif GetResourceState("es_extended") == "started" then

        Bridge.Framework = "esx"

    else

        error((
            "[%s] Unable to auto detect a supported framework.\n" ..
            "Supported frameworks:\n" ..
            " - qb-core\n" ..
            " - qbx_core\n" ..
            " - es_extended"
        ):format(ResourceName))

    end

else

    Bridge.Framework = Config.Framework

    if Bridge.Framework == "qbcore" then

        if GetResourceState("qb-core") ~= "started" then
            error(("[%s] Config.Framework is set to 'qbcore' but resource 'qb-core' is not started."):format(ResourceName))
        end

    elseif Bridge.Framework == "qbox" then

        if GetResourceState("qbx_core") ~= "started" then
            error(("[%s] Config.Framework is set to 'qbox' but resource 'qbx_core' is not started."):format(ResourceName))
        end

    elseif Bridge.Framework == "esx" then

        if GetResourceState("es_extended") ~= "started" then
            error(("[%s] Config.Framework is set to 'esx' but resource 'es_extended' is not started."):format(ResourceName))
        end

    end

end

--------------------------------------------------
-- Framework Object
--------------------------------------------------

if Bridge.Framework == "qbcore" then

    Bridge.FrameworkObject = exports["qb-core"]:GetCoreObject()

elseif Bridge.Framework == "qbox" then

    -- QboxはQBCoreオブジェクト互換
    Bridge.FrameworkObject = exports["qb-core"]:GetCoreObject()

elseif Bridge.Framework == "esx" then

    Bridge.FrameworkObject = exports["es_extended"]:getSharedObject()

end

--------------------------------------------------
-- Notify Validation
--------------------------------------------------

local ValidNotify = {
    auto_detect = true,
    qbcore = true,
    ox_lib = true,
    esx = true,
    okokNotify = true,
}

if not ValidNotify[Config.Notify] then
    error((
        '[%s] Invalid Config.Notify ("%s").\n' ..
        'Valid options: auto_detect, qbcore, ox_lib, esx, okokNotify'
    ):format(ResourceName, tostring(Config.Notify)))
end

--------------------------------------------------
-- Notify Detection
--------------------------------------------------

Bridge.NotifyMode = "Manual"

if Config.Notify == "auto_detect" then

    Bridge.NotifyMode = "Auto Detected"

    if GetResourceState("ox_lib") == "started" then

        Bridge.Notify = "ox_lib"

    elseif GetResourceState("okokNotify") == "started" then

        Bridge.Notify = "okokNotify"

    elseif Bridge.Framework == "qbcore" or Bridge.Framework == "qbox" then

        Bridge.Notify = "qbcore"

    elseif Bridge.Framework == "esx" then

        Bridge.Notify = "esx"

    else

        Bridge.Notify = "chat"

    end

else

    Bridge.Notify = Config.Notify

    if Bridge.Notify == "qbcore" then

        if GetResourceState("qb-core") ~= "started" then
            error(("[%s] Config.Notify is set to 'qbcore' but resource 'qb-core' is not started."):format(ResourceName))
        end

    elseif Bridge.Notify == "ox_lib" then

        if GetResourceState("ox_lib") ~= "started" then
            error(("[%s] Config.Notify is set to 'ox_lib' but resource 'ox_lib' is not started."):format(ResourceName))
        end

    elseif Bridge.Notify == "esx" then

        if GetResourceState("es_extended") ~= "started" then
            error(("[%s] Config.Notify is set to 'esx' but resource 'es_extended' is not started."):format(ResourceName))
        end

    elseif Bridge.Notify == "okokNotify" then

        if GetResourceState("okokNotify") ~= "started" then
            error(("[%s] Config.Notify is set to 'okokNotify' but resource 'okokNotify' is not started."):format(ResourceName))
        end

    end

end

--------------------------------------------------
-- Locale
--------------------------------------------------

Bridge.Lang = Locales[Config.Locale]

if not Bridge.Lang then
    error(('[%s] Locale "%s" does not exist.'):format(
        ResourceName,
        tostring(Config.Locale)
    ))
end

--------------------------------------------------
-- Console
--------------------------------------------------

print("^2========================================================^7")
print(("^6%s ^7v%s"):format(
    ResourceName,
    GetResourceMetadata(ResourceName, "version", 0) or "Unknown"
))
print("")

print(("^3Framework :^7 %s ^5(%s)^7"):format(
    Bridge.Framework,
    Bridge.FrameworkMode
))

print(("^3Notify    :^7 %s ^5(%s)^7"):format(
    Bridge.Notify,
    Bridge.NotifyMode
))

print(("^3Locale    :^7 %s"):format(
    Config.Locale
))

print("^2========================================================^7")
print("^2Bridge initialized successfully.^7")
print("^2========================================================^7")

--------------------------------------------------
-- Get Player Job
--------------------------------------------------

function Bridge.GetPlayerJob(source)

    if Bridge.Framework == "qbcore" or Bridge.Framework == "qbox" then

        local Player = Bridge.FrameworkObject.Functions.GetPlayer(source)
        if not Player then return nil end

        return {
            name = Player.PlayerData.job.name,
            onduty = Player.PlayerData.job.onduty
        }

    elseif Bridge.Framework == "esx" then

        local xPlayer = Bridge.FrameworkObject.GetPlayerFromId(source)
        if not xPlayer then return nil end

        -- ESXには標準Dutyがないため常にtrue
        return {
            name = xPlayer.job.name,
            onduty = true
        }

    end

    return nil

end

--------------------------------------------------
-- Send Notify
--------------------------------------------------

function Bridge.SendNotify(source, message, notifyType)

    if Bridge.Notify == "qbcore" then

        TriggerClientEvent(
            "QBCore:Notify",
            source,
            message,
            notifyType
        )

    elseif Bridge.Notify == "ox_lib" then

        TriggerClientEvent(
            "ox_lib:notify",
            source,
            {
                title = ResourceName,
                description = message,
                type = notifyType
            }
        )

    elseif Bridge.Notify == "esx" then

        TriggerClientEvent(
            "esx:showNotification",
            source,
            message
        )

    elseif Bridge.Notify == "okokNotify" then

        local notifyColor = "info"

        if notifyType == "success" then
            notifyColor = "success"

        elseif notifyType == "error" then
            notifyColor = "error"

        elseif notifyType == "warning" then
            notifyColor = "warning"
        end

        TriggerClientEvent(
            "okokNotify:Alert",
            source,
            ResourceName,
            message,
            5000,
            notifyColor
        )

    else

        TriggerClientEvent(
            "chat:addMessage",
            source,
            {
                color = {255, 255, 255},
                args = {
                    ResourceName,
                    message
                }
            }
        )

    end

end

--------------------------------------------------
-- Register Player Loaded Event
--------------------------------------------------

function Bridge.RegisterPlayerLoaded(callback)

    if type(callback) ~= "function" then
        error(("[%s] Bridge.RegisterPlayerLoaded expected a function."):format(ResourceName))
    end

    if Bridge.Framework == "qbcore" or Bridge.Framework == "qbox" then

        RegisterNetEvent("QBCore:Client:OnPlayerLoaded", callback)

    elseif Bridge.Framework == "esx" then

        RegisterNetEvent("esx:playerLoaded", callback)

    end

end

--------------------------------------------------
-- Get Framework
--------------------------------------------------

function Bridge.GetFramework()
    return Bridge.Framework
end

--------------------------------------------------
-- Get Framework Object
--------------------------------------------------

function Bridge.GetFrameworkObject()
    return Bridge.FrameworkObject
end

--------------------------------------------------
-- Get Notify
--------------------------------------------------

function Bridge.GetNotify()
    return Bridge.Notify
end

--------------------------------------------------
-- Get Locale
--------------------------------------------------

function Bridge.GetLocale()
    return Bridge.Lang
end

--------------------------------------------------
-- Get Resource Name
--------------------------------------------------

function Bridge.GetResourceName()
    return ResourceName
end

--------------------------------------------------
-- Get Version
--------------------------------------------------

function Bridge.GetVersion()
    return GetResourceMetadata(ResourceName, "version", 0) or "Unknown"
end

--------------------------------------------------
-- Debug
--------------------------------------------------

function Bridge.Debug(...)

    if not Config.Debug then
        return
    end

    local args = { ... }

    local message = ""

    for i = 1, #args do
        message = message .. tostring(args[i])

        if i ~= #args then
            message = message .. " "
        end
    end

    print(("[^3%s Debug^7] %s"):format(ResourceName, message))

end