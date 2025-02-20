Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

local HotbarAPI = {}
Tunnel.bindInterface("inventory/hotbar",HotbarAPI)

function HotbarAPI.getHotbar()
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
        return
	end
	local data = {}
	local Inventory = vRP.Inventory(Passport)
    for i=1,5 do
		local v = Inventory[tostring(i)]
		if v == nil then
			table.insert(data,{})
			goto skip
		end
		if (parseInt(v["amount"]) <= 0 or not itemBody(v["item"])) then
			vRP.RemoveItem(Passport,v["item"],parseInt(v["amount"]),false)
		else
			v["amount"] = parseInt(v["amount"])
			v["key"] = v["item"]
			v["slot"] = Index

			local Split = splitString(v["item"],"-")
			if Split[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end
            
            table.insert(data,v)
		end
        ::skip::
	end

	return data
end