-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
local InitPeds = {}
local Peds = exports["variables"]:GetPeds()
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if Peds then
			for i=1,#Peds do
				local Distance = #(Coords - vec3(Peds[i]["Coords"][1],Peds[i]["Coords"][2],Peds[i]["Coords"][3]))
				if Distance <= Peds[i]["Distance"] then
					if not InitPeds[i] and LocalPlayer["state"]["Route"] < 900000 then
						if LoadModel(Peds[i]["Model"]) then
							InitPeds[i] = CreatePed(4,Peds[i]["Model"],Peds[i]["Coords"][1],Peds[i]["Coords"][2],Peds[i]["Coords"][3] - 1,Peds[i]["Coords"][4],false,false)
							SetPedArmour(InitPeds[i],99)
							SetEntityInvincible(InitPeds[i],true)
							FreezeEntityPosition(InitPeds[i],true)
							SetBlockingOfNonTemporaryEvents(InitPeds[i],true)
							if Peds[i]["Custom"] then
								ApplyClothes(InitPeds[i],json.decode(Peds[i]["Custom"]["Clothes"]))
								ApplyFacials(InitPeds[i],json.decode(Peds[i]["Custom"]["Face"]))
							end

							SetModelAsNoLongerNeeded(Peds[i]["Model"])

							if Peds[i]["Model"] == "s_f_y_casino_01" then
								SetPedDefaultComponentVariation(InitPeds[i])
								SetPedComponentVariation(InitPeds[i],0,3,0,0)
								SetPedComponentVariation(InitPeds[i],1,0,0,0)
								SetPedComponentVariation(InitPeds[i],2,3,0,0)
								SetPedComponentVariation(InitPeds[i],3,0,1,0)
								SetPedComponentVariation(InitPeds[i],4,1,0,0)
								SetPedComponentVariation(InitPeds[i],6,1,0,0)
								SetPedComponentVariation(InitPeds[i],7,1,0,0)
								SetPedComponentVariation(InitPeds[i],8,0,0,0)
								SetPedComponentVariation(InitPeds[i],10,0,0,0)
								SetPedComponentVariation(InitPeds[i],11,0,0,0)
								SetPedPropIndex(InitPeds[i],1,0,0,false)
							end

							if Peds[i]["Anim"] ~= nil then
								if LoadAnim(Peds[i]["Anim"][1]) then
									TaskPlayAnim(InitPeds[i],Peds[i]["Anim"][1],Peds[i]["Anim"][2],8.0,8.0,-1,1,0,0,0,0)
								end
							end
						end
					end
				else
					if InitPeds[i] then
						if DoesEntityExist(InitPeds[i]) then
							DeleteEntity(InitPeds[i])
						end

						InitPeds[i] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)

function CheckPed(Table)
    local Coords = vector3(Table[1],Table[2],Table[3])
    local HasPed = true
    for i=1,#Peds do
        local Distance = #(Coords - vec3(Peds[i]["Coords"][1],Peds[i]["Coords"][2],Peds[i]["Coords"][3]))
        if Distance <= 1.5 then
            HasPed = false
        end
    end
    return HasPed
end

function AddPedToList(Table)
    if CheckPed(Table["Coords"]) then
        table.insert(Peds,Table)
    end
end
exports("AddPedToList",AddPedToList)

function ApplyClothes(Ped,Data)
	SetPedComponentVariation(Ped,4,Data["pants"]["item"],Data["pants"]["texture"],1)
	SetPedComponentVariation(Ped,3,Data["arms"]["item"],Data["arms"]["texture"],1)
	SetPedComponentVariation(Ped,5,Data["backpack"]["item"],Data["backpack"]["texture"],1)
	SetPedComponentVariation(Ped,8,Data["tshirt"]["item"],Data["tshirt"]["texture"],1)
	SetPedComponentVariation(Ped,9,Data["vest"]["item"],Data["vest"]["texture"],1)
	SetPedComponentVariation(Ped,11,Data["torso"]["item"],Data["torso"]["texture"],1)
	SetPedComponentVariation(Ped,6,Data["shoes"]["item"],Data["shoes"]["texture"],1)
	SetPedComponentVariation(Ped,1,Data["mask"]["item"],Data["mask"]["texture"],1)
	SetPedComponentVariation(Ped,10,Data["decals"]["item"],Data["decals"]["texture"],1)
	SetPedComponentVariation(Ped,7,Data["accessory"]["item"],Data["accessory"]["texture"],1)

	if Data["hat"]["item"] ~= -1 and Data["hat"]["item"] ~= 0 then
		SetPedPropIndex(Ped,0,Data["hat"]["item"],Data["hat"]["texture"],1)
	else
		ClearPedProp(Ped,0)
	end

	if Data["glass"]["item"] ~= -1 and Data["glass"]["item"] ~= 0 then
		SetPedPropIndex(Ped,1,Data["glass"]["item"],Data["glass"]["texture"],1)
	else
		ClearPedProp(Ped,1)
	end

	if Data["ear"]["item"] ~= -1 and Data["ear"]["item"] ~= 0 then
		SetPedPropIndex(Ped,2,Data["ear"]["item"],Data["ear"]["texture"],1)
	else
		ClearPedProp(Ped,2)
	end

	if Data["watch"]["item"] ~= -1 and Data["watch"]["item"] ~= 0 then
		SetPedPropIndex(Ped,6,Data["watch"]["item"],Data["watch"]["texture"],1)
	else
		ClearPedProp(Ped,6)
	end

	if Data["bracelet"]["item"] ~= -1 and Data["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(Ped,7,Data["bracelet"]["item"],Data["bracelet"]["texture"],1)
	else
		ClearPedProp(Ped,7)
	end
end

function ApplyFacials(Ped,Table)
    if Table then
		Barber = Table
	end

	for Number = 1,50 do
		if not Barber[Number] then
			Barber[Number] = 0
		end
	end

	local Fathers = exports["variables"]:GetParents("Fathers")
	local Mothers = exports["variables"]:GetParents("Mothers")

	SetPedHeadBlendData(Ped,Fathers[Barber[1] + 1],Mothers[Barber[2] + 1],0,Barber[5],0,0,Barber[3] + 0.0,0,0,false)

	SetPedEyeColor(Ped,Barber[4])

	SetPedComponentVariation(Ped,2,Barber[10],0,0)
	SetPedHairColor(Ped,Barber[11],Barber[12])

	SetPedHeadOverlay(Ped,0,Barber[7],0.99)
	SetPedHeadOverlayColor(Ped,0,0,0,0)

	SetPedHeadOverlay(Ped,1,Barber[22],Barber[23])
	SetPedHeadOverlayColor(Ped,1,1,Barber[24],Barber[24])

	SetPedHeadOverlay(Ped,2,Barber[19],Barber[20])
	SetPedHeadOverlayColor(Ped,2,1,Barber[21],Barber[21])

	SetPedHeadOverlay(Ped,3,Barber[9],0.99)
	SetPedHeadOverlayColor(Ped,3,0,0,0)

	SetPedHeadOverlay(Ped,4,Barber[13],Barber[14])
	SetPedHeadOverlayColor(Ped,4,1,Barber[15],Barber[15])

	SetPedHeadOverlay(Ped,5,Barber[25],Barber[26])
	SetPedHeadOverlayColor(Ped,5,1,Barber[27],Barber[27])

	SetPedHeadOverlay(Ped,6,Barber[6],0.99)
	SetPedHeadOverlayColor(Ped,6,0,0,0)

	SetPedHeadOverlay(Ped,8,Barber[16],Barber[17])
	SetPedHeadOverlayColor(Ped,8,1,Barber[18],Barber[18])

	SetPedHeadOverlay(Ped,9,Barber[8],0.99)
	SetPedHeadOverlayColor(Ped,9,0,0,0)

    SetPedHeadOverlay(Ped,10, Barber[48], Barber[49])
    SetPedHeadOverlayColor(Ped, 10, 1, Barber[50], Barber[51])

	SetPedFaceFeature(Ped,0,Barber[28])
	SetPedFaceFeature(Ped,1,Barber[29])
	SetPedFaceFeature(Ped,2,Barber[30])
	SetPedFaceFeature(Ped,3,Barber[31])
	SetPedFaceFeature(Ped,4,Barber[32])
	SetPedFaceFeature(Ped,5,Barber[33])
	SetPedFaceFeature(Ped,6,Barber[44])
	SetPedFaceFeature(Ped,7,Barber[34])
	SetPedFaceFeature(Ped,8,Barber[36])
	SetPedFaceFeature(Ped,9,Barber[35])
	SetPedFaceFeature(Ped,10,Barber[45])
	SetPedFaceFeature(Ped,12,Barber[42])
	SetPedFaceFeature(Ped,13,Barber[46])
	SetPedFaceFeature(Ped,14,Barber[37])
	SetPedFaceFeature(Ped,15,Barber[38])
	SetPedFaceFeature(Ped,16,Barber[40])
	SetPedFaceFeature(Ped,17,Barber[39])
	SetPedFaceFeature(Ped,18,Barber[41])
	SetPedFaceFeature(Ped,19,Barber[43])
end