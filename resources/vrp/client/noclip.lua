-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local NoClip = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ReturnNoClip()
	return NoClip
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.noClip()
	NoClip = not NoClip
	local Ped = PlayerPedId()

	if NoClip then
		LocalPlayer["state"]["Invincible"] = true
		LocalPlayer["state"]["Invisible"] = true

		SetEntityInvincible(Ped,true)
		SetEntityVisible(Ped,false,false)
		SetEntityCollision(Ped,false,false)
        SetLocalPlayerAsGhost(true)
        SetGhostedEntityAlpha(254)
	else
		SetEntityInvincible(Ped,false)
		SetEntityVisible(Ped,true,false)
		SetEntityCollision(Ped,true,true)
        SetLocalPlayerAsGhost(false)

		LocalPlayer["state"]["Invisible"] = false
		LocalPlayer["state"]["Invincible"] = false
	end
    Wait(10)
    local Ped = PlayerPedId()
	while NoClip do
		local Speed = 1.0
		local cX,cY,cZ = GetCamDirections()
		local Coords = GetEntityCoords(Ped)
		local X,Y,Z = table.unpack(Coords)

		if IsControlPressed(1,21) then
			Speed = 5.0
		end

        if IsControlPressed(1,32) then
            X = X + Speed * cX
            Y = Y + Speed * cY
            Z = Z + Speed * cZ
        end
        
        if IsControlPressed(1,34) then
            X = X - Speed * cY
            Y = Y + Speed * cX
        end

        if IsControlPressed(1,35) then
            X = X + Speed * cY
            Y = Y - Speed * cX
        end
        
        if IsControlPressed(1,269) then
            X = X - Speed * cX
            Y = Y - Speed * cY
            Z = Z - Speed * cZ
        end

		if IsControlPressed(1,10) then
			Z = Z + 0.25
		end

		if IsControlPressed(1,11) then
			Z = Z - 0.25
		end

		SetEntityCoordsNoOffset(Ped,X,Y,Z,false,false,false)
		Wait(0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCAMDIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCamDirections()
	local Ped = PlayerPedId()
	local Pitch = GetGameplayCamRelativePitch()
	local Heading = GetGameplayCamRelativeHeading() + GetEntityHeading(Ped)
	local x = -math.sin(Heading * math.pi / 180.0)
	local y = math.cos(Heading * math.pi / 180.0)
	local z = math.sin(Pitch * math.pi / 180.0)
	local Len = math.sqrt(x * x + y * y + z * z)
	if Len ~= 0 then
		x = x / Len
		y = y / Len
		z = z / Len
	end

	return x,y,z
end