-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("tattooshop",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("playerdata/InsertUpdateT","INSERT INTO playerdata(Passport,dkey,dvalue) VALUES(@Passport,@dkey,@dvalue) ON DUPLICATE KEY UPDATE dvalue = @dvalue")
function Creative.Update(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Query("playerdata/InsertUpdateT",{ Passport = Passport, dkey = "Tattooshop", dvalue = Table })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Cancel()
	local Source = source
    local passport = vRP.Passport(source)

    if (passport) then
        local Bucket = 1
        if GetPlayerRoutingBucket(source) == 12 then
            return
        end
        exports["vrp"]:ChangePlayerBucket(Source,Bucket)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Open()
	local Source   = source
    local passport = vRP.Passport(source)

    local Bucket = parseInt(Source)+5001
    if GetPlayerRoutingBucket(source) == 12 then
        return
    end
    exports["vrp"]:ChangePlayerBucket(Source,Bucket)
end