-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

cityName = GetConvar("cityName","Base")
vKEYBOARD = Tunnel.getInterface("keyboard")

Server = {}
Proxy.addInterface('mdt',Server)
Tunnel.bindInterface('mdt',Server)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Wanted = {}
PrisonCount = {}
BillsCount = {}
News = {}
Reports = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("mdt_wanted/GetWanteds", "SELECT * FROM mdt_wanted WHERE wanted = 1")
vRP.Prepare("mdt_wanted/SetWanted", "INSERT INTO mdt_wanted(passport, officer, reason, wanted) VALUES (@passport, @officer, @reason, 1)")
vRP.Prepare("mdt_wanted/RemoveWanted","UPDATE mdt_wanted SET wanted = 0 WHERE passport = @passport")
vRP.Prepare("mdt_wanted/GetWanted", "SELECT * FROM mdt_wanted WHERE passport = @passport and wanted = 1")
vRP.Prepare("mdt_arrest/SetArrest", "INSERT INTO mdt_arrest(passport, officer, description, infraction,time) VALUES (@passport, @officer, @description, @infraction, @time)")
vRP.Prepare("mdt_arrest/GetArrested", "SELECT * FROM mdt_arrest WHERE passport = @passport AND time > 0")
vRP.Prepare("mdt_arrest/GetAllTimeArrested", "SELECT * FROM mdt_arrest WHERE passport = @passport")
vRP.Prepare("mdt_arrest/GetArresteds", "SELECT * FROM mdt_arrest WHERE arrested = 1")
vRP.Prepare("mdt_arrest/UpdateArrested","UPDATE mdt_arrest SET time = @time WHERE passport = @passport and arrested = 1")
vRP.Prepare("mdt_arrest/RemoveArrested","UPDATE mdt_arrest SET arrested = 0 AND time = 0 WHERE passport = @passport and arrested = 1")
vRP.Prepare("mdt_bills/GetBills","SELECT * FROM mdt_bills WHERE passport = @passport and paid = 0")
vRP.Prepare("mdt_bills/ClearBills","UPDATE mdt_bills SET paid = 1 WHERE passport = @passport")
vRP.Prepare("mdt_bills/GetAlltimeBills","SELECT * FROM mdt_bills WHERE passport = @passport")
vRP.Prepare("mdt_bills/GetBillsCount","SELECT DATE(datatime) AS day, COUNT(*) AS count FROM mdt_bills WHERE datatime >= DATE_SUB(NOW(), INTERVAL 7 DAY) GROUP BY day ORDER BY day DESC;")
vRP.Prepare("mdt_bills/SetBills","INSERT INTO mdt_bills(passport, officer, description, amount,infraction) VALUES (@passport, @officer, @description, @amount, @infraction)")
vRP.Prepare("mdt_news/GetNews","SELECT * FROM mdt_news ORDER BY uid DESC LIMIT 10")
vRP.Prepare("mdt_news/AddNews","INSERT INTO mdt_news(user, message) VALUES (@user, @message)")
vRP.Prepare("mdt_news/DelNews","DELETE FROM mdt_news WHERE uid = @uid")
vRP.Prepare("mdt_reports/GetReports","SELECT * FROM mdt_reports WHERE status = 0 ORDER BY id ASC")
vRP.Prepare("mdt_reports/SetReport","INSERT INTO mdt_reports(officer,suspectId,requester,title,description,status) VALUES (@officer,@suspectId,@requester,@title,@description,0)")
vRP.Prepare("mdt_reports/DeleteReport","DELETE FROM mdt_reports WHERE id = @id")
vRP.Prepare("characters/SetWeapon","UPDATE characters SET weapon = @weapon WHERE id = @id")
vRP.Prepare("mdt_arrest/GetGraphInfo","SELECT DATE_FORMAT(`datetime`, '%d/%m') AS day, COUNT(*) AS count FROM `mdt_arrest` WHERE `datetime` >= CURDATE() - INTERVAL 7 DAY GROUP BY day ORDER BY `datetime` ASC;")
vRP.Prepare("mdt_bills/GetGraphInfo","SELECT DATE_FORMAT(`datetime`, '%d/%m') AS day, COUNT(*) AS count FROM `mdt_arrest` WHERE `datetime` >= CURDATE() - INTERVAL 7 DAY GROUP BY day ORDER BY `datetime` ASC;")
vRP.Prepare("vehicles/UserVehiclesMDT","SELECT vehicle,tax,plate FROM vehicles WHERE Passport = @Passport AND work = 'false'")

CreateThread(function()
    Wait(100)
    GenerateWantedCache()
    GenerateNewsCache()
    GenerateReportsCache()
    GenerateGraphInfo()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.IsPlayerACop()
    local source = source
    local Passport = vRP.Passport(source)
    local Valid = false
    if Passport then
        Valid = vRP.HasGroup(Passport,"Policia",3)
    end
    return Valid
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET OFFICER DATA
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.GetOfficerData()
    local source = source
    local Passport = vRP.Passport(source)
    local Info = {
        username = vRP.FullName(Passport),
        passport = Passport,
        isManager = vRP.HasGroup(Passport,"Policia",1),
    }
    return Info
end

function Server.GetGraphData()
    local source = source
    local Passport = vRP.Passport(source)
    local Info = {
        prisons = PrisonCount,
        fines = BillsCount,
    }
    return Info
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET PASSPORT NAME
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.GetPassportName(Player)
    local source = source
    local Passport = vRP.Passport(source)
    local Name = "Nome ou Passaporte inválido"
    if Passport then
        Name = vRP.FullName(Player) or "Nome ou Passaporte inválido"
    end
    return Name
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET USER INFO
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.GetUserInfo(Player)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",4) then
        local Table = GetUserInfo(Player) or {}
        local Info = {
            success = false,
            result = {}
        }
        if Table and Table["name"] then
            Info["success"] = true
            Info["result"] = Table
        end
        return Info
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET NEWS
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.GetNews()
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        return GetNews()
    end
end

function Server.AddNews(Message)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        AddNews(Passport,Message)
    end
end

function Server.DelNews(Id)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        DelNews(Id)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET REPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.GetReports(Page)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        return GetReports(Page or 1)
    end
end

function Server.GetReport(Id)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        return GetReport(Id)
    end
end

function Server.CreateReport(requester,description,title,suspect)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        CreateReport(Passport,requester,description,title,suspect)
    end
end

function Server.EditReport(reportId,requester,description,title,suspect,status)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        UpdateReport(reportId,Passport,requester,description,title,suspect)
    end
end

function Server.DeleteReport(Id)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        DeleteReport(Id)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLE WEAPON PASSPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.ToggleWeapon(Player)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        vRP.ChangeWeaponPort(Player)
    end
end