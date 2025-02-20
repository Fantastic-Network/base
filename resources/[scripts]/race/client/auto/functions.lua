function UpdateRankingTable(Table)
    local Ped = PlayerPedId()
    local selfIndex = 0
    for i=1,#Table do
        Table[i]["index"] = 0
        local Pid = GetPlayerFromServerId(Table[i]["Source"])
        local nPed = GetPlayerPed(Pid)
        if Ped == nPed then
            selfIndex = i
        end
    end
    local Info = {
        ranking = Table,
        selfIndex = selfIndex
    }
    return Info
end

function GetRaces()
    local Ped = PlayerPedId()
    for i = 1,#Races do
        local Coords = GetEntityCoords(Ped)
        local Distance = CalculateTravelDistanceBetweenPoints(Coords,Races[i])
        CachedTable[i] = Distance
        StartTable[Distance] = i
    end
    SortedTable = CachedTable
    table.sort(SortedTable)
    return SortedTable
end

function ClosestVehicle()
    local Ped = PlayerPedId()
    local Veh = GetVehiclePedIsIn(Ped)
    local Coords = GetEntityCoords(Ped)
    local Vehicles = GetGamePool('CVehicle')
    local ClosestDistance = 10
    local Selected = false
    for i=1, #Vehicles do
        local Vehicle = Vehicles[i]
        local Driving = GetPedInVehicleSeat(Vehicle,-1)
        if Driving and Driving ~= 0 then
            if Vehicle and Vehicle ~= Veh then
                local VehicleCoords = GetEntityCoords(Vehicle)
                local Distance = #(Coords - VehicleCoords)
                if Distance <= ClosestDistance then
                    Selected = Vehicle
                end
            end
        end
    end
    return Selected
end

function GetDriver(vehicle)
    local DriverPed = GetPedInVehicleSeat(vehicle,-1)
    local Driver = GetPlayerServerId((NetworkGetPlayerIndexFromPed(DriverPed)))
    return Driver
end

function DrawText(x,y,z,Message)
    local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)
    if onScreen then
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringKeyboardDisplay(Message)
        SetTextColour(255,255,255,150)
        SetTextScale(0.35,0.35)
        SetTextFont(4)
        SetTextCentre(1)
        EndTextCommandDisplayText(_x,_y)
    end
end

function AddBlip(coords)
	blipRace = AddBlipForCoord(coords)
	SetBlipSprite(blipRace,1)
	SetBlipColour(blipRace,1)
	SetBlipScale(blipRace,0.4)
	SetBlipAsShortRange(blipRace,false)
	SetBlipRoute(blipRace,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("LINHA DE CHEGADA")
	EndTextCommandSetBlipName(blipRace)
end

function GetVehicleName(Vehicle)
    local Model = vRP.VehicleModel(Vehicle)
    local Name = VehicleName(Model)
    return {Model = Model, Name = Name}
end

function GetVehiclePed(Ped)
    local Vehicle = GetVehiclePedIsIn(Ped)
    local Model = vRP.VehicleModel(Vehicle)
    local Name = VehicleName(Model)
    return {Model = Model, Name = Name, Entity = Vehicle}
end

function GetVehiclesRace(Data)
    local SelfId = GetPlayerFromServerId(Data["usersData"]["self"]["source"])
    local SelfPed = GetPlayerPed(SelfId)
    local SelfVeh = GetVehiclePed(SelfPed)
    Data["usersData"]["self"]["vehicle"] = {
        ["name"] = SelfVeh["Name"],
        ["image"] = "SEU LINK AQUI"..SelfVeh["Model"]..".png"
    }
    local OpponnentId = GetPlayerFromServerId(Data["usersData"]["opponent"]["source"])
    local OpponnentPed = GetPlayerPed(OpponnentId)
    local OpponnentVeh = GetVehiclePed(OpponnentPed)
    Data["usersData"]["opponent"]["vehicle"] = {
        name = OpponnentVeh["Name"],
        ["image"] = "SEU LINK AQUI"..OpponnentVeh["Model"]..".png"
    }
    return Data
end