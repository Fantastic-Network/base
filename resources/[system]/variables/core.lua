cityName = GetConvar("cityName", "Base"):lower()
Variables = {}
SharedVariables = {}

function LoadVariables()
    local path = "cities/"..cityName..".lua"
    local file = LoadResourceFile(GetCurrentResourceName(), path)

    if file == nil then
        -- print("Error loading variables: File not found!")
        return
    end

    local func, err = load(file, path, "t", _ENV)
    if func then
        -- print("Variables loaded!")
        func()
        return true
    else
        -- print("Error loading variables: " .. err)
        return false
    end
end

function LoadSharedVariables()
    local Shared = {}
    for Type,Data in pairs(Variables) do
        if not Shared[Type] then
            Shared[Type] = {}
        end
        for Name,Value in pairs(Data) do
            if Value.shared then
                Shared[Type][Name] = Value
            end
        end
    end
    SharedVariables = Shared
end

exports("GetVariable", function(Type, Name, ...)
    if Variables[Type] then
        if Variables[Type][Name] then
            if Variables[Type][Name].value then
                return Variables[Type][Name].value
            elseif Variables[Type][Name].func then
                return Variables[Type][Name].func(...)
            end
        end
    end
end)

CreateThread(function()
    if IsDuplicityVersion() then
        -- print("Loading variables...")
        if LoadVariables() then
            -- print("Variables loaded 2!")
            Variables = Config
            -- print(json.encode(Variables.variables))
            LoadSharedVariables()
            Wait(1000)
            TriggerClientEvent("loadVariables", -1, SharedVariables)
        end
    else
        -- print("Loading variables...")
        RegisterNetEvent("loadVariables")
        AddEventHandler("loadVariables", function(Data)
            Variables = Data
            -- print("Variables loaded!")
        end)
    end
end)