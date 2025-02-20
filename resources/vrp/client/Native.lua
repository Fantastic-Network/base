-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadModel(Hash)
	local Hash = GetHashKey(Hash)

	while not HasModelLoaded(Hash) do
		RequestModel(Hash)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadAnim(Dict)
	while not HasAnimDictLoaded(Dict) do
		RequestAnimDict(Dict)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADTEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadTexture(Library)
	while not HasStreamedTextureDictLoaded(Library) do
		RequestStreamedTextureDict(Library,false)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMOVEMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadMovement(Library)

	while not HasAnimSetLoaded(Library) do
		RequestAnimSet(Library)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADPTFXASSET
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadPtfxAsset(Library)

	while not HasNamedPtfxAssetLoaded(Library) do
		RequestNamedPtfxAsset(Library)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADPARTICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadParticle(fx)
	if LoadPtfxAsset(fx) then
		UseParticleFxAssetNextCall(fx)

		local Ped = PlayerPedId()
		if fx == "core" then
			StartParticleFxLoopedOnPedBone("ent_amb_peeing",Ped,0.0,0.2,-0.2,-140.0,0.0,0.0,GetPedBoneIndex(Ped,11816),2.5,false,false,false)
		elseif fx == "scr_amb_chop" then
			StartParticleFxLoopedOnPedBone("ent_anim_dog_poo",Ped,0.0,0.0,-0.6,0.0,0.0,20.0,GetPedBoneIndex(Ped,11816),2.0,false,false,false)
		end

		SetTimeout(4000,function()
			vRP.stopAnim()
			RemoveParticleFxFromEntity(Ped)
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADNETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadNetwork(Network)
    Wait(100)

    if NetworkDoesNetworkIdExist(Network) then
        local Object = NetToEnt(Network)

        if DoesEntityExist(Object) then
            NetworkRequestControlOfEntity(Object)
            while not NetworkHasControlOfEntity(Object) do
                Wait(1)
            end

            SetEntityAsMissionEntity(Object,true,true)
            while not IsEntityAMissionEntity(Object) do
                Wait(1)
            end

            return Object
        end
    end

    return false
end