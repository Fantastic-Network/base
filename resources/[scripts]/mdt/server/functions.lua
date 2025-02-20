-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
function GetWanteds(Page)
    local MaxPages, Data = SplitTableIntoPages(Wanted,Page)
    local Info = {
        maxPage = MaxPages,
        data = Data,
    }
    return Info
end

function RemoveWanted(Passport)
    local Query = vRP.Query("mdt_wanted/RemoveWanted",{passport = Passport})
    if Query then
        for i=1, #Wanted do
            if Wanted[i]["userid"] == Passport then
                table.remove(Wanted,i)
                return true
            end
        end
    end
    return false
end

function SetWanted(Passport,Officer,Reason)
    local Query = vRP.Query("mdt_wanted/SetWanted",{passport = Passport, officer = Officer, reason = Reason})
    if Query then
        local Identity = vRP.Identity(Passport)
        local Info = {
            userid = Passport,
            name = vRP.FullName(Passport),
            register = Passport,
            photo = Identity["photo"] or "",
            officer = Officer,
            age = Identity["age"] or 18,
            hasWeapon = Identity["Weapon"] or false,
            Wanted = {
                datetime = os.time()*1000,
                reason = Reason,
            }
        }
        table.insert(Wanted,Info)
        return true
    end
    return false
end

function GenerateWantedCache()
    local Query = vRP.Query("mdt_wanted/GetWanteds",{})
    if Query and Query[1] then
        local Table = {}
        for i=1, #Query do
            local Passport = Query[i]["passport"]
            local Identity = vRP.Identity(Passport)
            local Info = {
                userid = Passport,
                name = vRP.FullName(Passport),
                register = Passport,
                photo = Identity["photo"] or "",
                age = Identity["age"] or 18,
                hasWeapon = Identity["Weapon"] or false,
                wanted = {
                    datetime = Query[i]["datetime"],
                    reason = Query[i]["reason"],
                    officer = Query[i]["officer"],
                }
            }
            table.insert(Table,Info)
        end
        Wanted = Table
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET USER INFO
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayerVehicles(Passport)
    local Consult = vRP.Query("vehicles/UserVehiclesMDT",{ Passport = Passport })
    local Vehicles = {}
    if Consult and Consult[1] then
        for i=1,#Consult do
            table.insert(Vehicles,{
                ["model"] = VehicleName(Consult[i]["vehicle"]),
                ["isTaxPaid"] = Consult[i]["tax"] >= os.time(),
                ["plate"] = Consult[i]["plate"]
            })
        end
    end
    return Vehicles
end

function GetPlayerHistory(Passport)
    local Info = {}
    local Arrests = vRP.Query("mdt_arrest/GetAllTimeArrested",{ passport = Passport})
    if Arrests and Arrests[1] then
        for i=1,#Arrests do
            local Arrest = Arrests[i]
            local Officer = vRP.FullName(Arrest["officer"])
            local Time = Arrest["time"]
            local Type = "Prisao"
            table.insert(Info,{
                type = Type,
                datetime = Arrest["datetime"],
                officer = Officer,
                fine = 0,
                time = Time,
            })
        end
    end
    local Fines = vRP.Query("mdt_bills/GetAlltimeBills",{ passport = Passport })
    if Fines and Fines[1] then
        for i=1,#Fines do
            local Fine = Fines[i]
            local Officer = vRP.FullName(Fine["officer"])
            local Amount = Fine["amount"]
            local Type = "Multa"
            table.insert(Info,{
                type = Type,
                datetime = Fine["datetime"],
                officer = Officer,
                fine = Amount,
                time = 0,
            })
        end
    end
    return Info
end

function GetPlayerHouses(Passport)
    local Query = vRP.Query("propertys/User",{ Passport = Passport })
    local Houses = {}
    if Query and Query[1] then
        for i=1,#Query do
            table.insert(Houses,{
                ["address"] = Query[i]["Name"],
                ["model"] = Query[i]["Interior"],
                ["isTaxPaid"] = Query[i]["Tax"] <= os.time(),
            })
        end
    end
    return Houses
end

function GetUserInfo(Passport)
    local Identity = vRP.Identity(Passport)
    local Estate = vRP.Query("characters/GetEconomy",{ Passport = Passport })
    if Identity then
        Estate = Estate[1]["economy"] or 0
        local Info = {
            userid = Passport,
            name = vRP.FullName(Passport),
            estate = Estate,
            photo = "https://cdn.discordapp.com/attachments/877350908969762828/1121921761701793792/user.png",
            age = Identity["age"] or 18,
            hasWeapon = Identity["weapon"] or false,
            wanted = vRP.Query("mdt_wanted/GetWanted",{passport = Passport})[1] or {},
            history = {
                general = GetPlayerHistory(Passport), -- TODO
                vehicles = GetPlayerVehicles(Passport),
                houses = GetPlayerHouses(Passport),
            },
        }
        return Info
    end
    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARREST
-----------------------------------------------------------------------------------------------------------------------------------------
function ArrestPlayer(Officer,Prisoner,Description,Infraction,Sentence)
    vRP.Query("mdt_arrest/SetArrest",{
        officer = Officer,
        passport = Prisoner,
        description = Description,
        infraction = Infraction,
        time = Sentence
    })
    local Day = os.date("%d/%m")
    if PrisonCount[Day] then
        PrisonCount[Day] = PrisonCount[Day] + 1
    else
        PrisonCount[Day] = 1
    end
    SetPlayerInPrison(Prisoner,Sentence)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function SetPlayerInPrison(Prisoner,Time)
    local Source = vRP.Source(Prisoner)
    local Identity = vRP.Identity(Prisoner)
    if Source and Identity then
        inPrison[Prisoner] = { Name = Identity["name"].." "..Identity["name2"], Time = Time, JobTimer = os.time(), Timer = os.time() + 10, Source = Source }
        local Model = vRP.ModelPlayer(Source)
        local PolicePresets = exports["variables"]:GetPolicePresets()
        if Model == "mp_m_freemode_01" or "mp_f_freemode_01" then
            TriggerClientEvent("skinshop:Apply",Source,PolicePresets[Model])
        end
        Player(Source)["state"]["InPrison"] = true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET NEWS 
-----------------------------------------------------------------------------------------------------------------------------------------
function GenerateNewsCache()
    local Query = vRP.Query("mdt_news/GetNews",{})
    if Query and Query[1] then
        local Table = {}
        for i=1,#Query do
            local Info = Query[i] or {}
            local Passport = Query[i]["user"]
            local Identity = vRP.Identity(Passport)
            local Name = vRP.FullName(Passport)
            Info["photo"] = Identity["photo"] or ""
            Info["name"] = Name
            table.insert(Table,Info)
        end
        News = Table
    end
end

function GetNews()
    return News
end

function AddNews(Passport,Message)
    local Query = vRP.Query("mdt_news/AddNews",{user = Passport, message = Message})
    if Query then
        local Identity = vRP.Identity(Passport)
        local Uid = #News + 1
        local Info = {
            uid = Uid,
            user = Passport,
            name = vRP.FullName(Passport),
            photo = Identity["photo"] or "",
            message = Message,
            create_at = os.time()*1000
        }
        table.insert(News,Info)
    end
end

function EditNews(Passport,Message,Uid)
    local Query = vRP.Query("mdt_news/EditNews",{passport = Passport, message = Message, uid = Uid})
    if Query then
        for i=1,#News do
            if News[i]["uid"] == Uid then
                News[i]["message"] = Message
                return true
            end
        end
    end
    return false
end

function DelNews(Uid)
    local Query = vRP.Query("mdt_news/DelNews",{uid = Uid})
    if Query then
        for i=1,#News do
            if News[i]["uid"] == Uid then
                table.remove(News,i)
                break
            end
        end
        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET REPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
function GenerateReportsCache()
    local Query = vRP.Query("mdt_reports/GetReports",{})
    if Query and Query[1] then
        Reports = Query
    end
end

function GetReports(Page)
    local MaxPages, Data = SplitTableIntoPages(Reports,Page)
    local Info = {
        maxPage = MaxPages,
        data = Data,
    }
    return Info
end

function GetReport(Id)
    for i=1,#Reports do
        if Reports[i]["id"] == Id then
            return Reports[i]
        end
    end
end

function CreateReport(officer,requester,description,title,suspect)
    local Query = vRP.Query("mdt_reports/SetReport",{
        officer = officer,
        requester = requester,
        description = description,
        title = title,
        suspectId = suspect
    })
    if Query then
        local Info = {
            officer = officer,
            requester = requester,
            description = description,
            title = title,
            suspectId = suspect,
            status = false,
            datetime = os.time()*1000
        }
        table.insert(Reports,Info)
        return true
    end
    return false
end

function UpdateReport(Index,officer,requester,description,title,suspect,status)
    local Report = Reports[Index]
    if Report then
        local Query = vRP.Query("mdt_reports/UpdateReport",{
            officer = officer,
            requester = requester,
            description = description,
            title = title,
            suspectId = suspect,
            status = status,
            id = Report["id"]
        })
        if Query then
            Reports[Index] = {
                officer = officer,
                requester = requester,
                description = description,
                title = title,
                suspectId = suspect,
                status = status,
                datetime = Report["datetime"],
                id = Report["id"]
            }
            return true
        end
    end
    return false
end

function DeleteReport(Id)
    local Selected = false
    for i=1,#Reports do
        if Reports[i]["id"] == Id then
            vRP.Query("mdt_reports/DeleteReport",{id = Id})
            Selected = i
        end
    end
    if Selected then
        table.remove(Reports,Selected)
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGINATION
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitTableIntoPages(Table, Page)
    local PageSize = 20
    local Start = (Page - 1) * PageSize + 1
    local End = math.min(Page * PageSize, #Table)
    local Info = {}
    for i = Start, End do
        table.insert(Info, Table[i])
    end
    return math.ceil(#Table / PageSize), Info
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE BILL
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateBill(Officer,Passport,Amount,Description,Infraction,Prison)
    if Amount == 0 then
        Amount = 1
    end
    local Query = vRP.Query("mdt_bills/SetBills",{
        officer = Officer,
        passport = Passport,
        amount = Amount,
        infraction = Infraction,
        description = Description
    })
    local Day = os.date("%d/%m")
    if Prison then
        if BillsCount[Day] then
            BillsCount[Day] = BillsCount[Day] + 1
        else
            BillsCount[Day] = 1
        end
    end
    if Query then
        exports["bank"]:AddFines(parseInt(Officer),Passport,parseInt(Amount),Description)
        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATE GRAPH INFO
-----------------------------------------------------------------------------------------------------------------------------------------
function GenerateGraphInfo()
    local QueryPrison = vRP.Query("mdt_arrest/GetGraphInfo",{})
    for i=1,#QueryPrison do
        local Info = QueryPrison[i]
        PrisonCount[Info["day"]] = Info["count"]
    end
    local QueryBills = vRP.Query("mdt_bills/GetGraphInfo",{})
    for i=1,#QueryBills do
        local Info = QueryBills[i]
        BillsCount[Info["day"]] = Info["count"]
    end
end