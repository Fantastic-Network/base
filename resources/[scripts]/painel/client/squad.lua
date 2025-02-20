RegisterNUICallback('getTeamMembers', function(Data, CallBack)
    local Squad = vSERVER.GetSquadInfo(Data["id"]) or {}
    CallBack(Squad)
end)

RegisterNUICallback('getTeams', function(Data, CallBack)
    local SquadsInfo = vSERVER.GetSquads(Group)
    CallBack(SquadsInfo)
end)

RegisterNUICallback('createTeam', function(Data, CallBack)
    vSERVER.CreateSquad(Group,Data["name"])
end)

RegisterNUICallback('inviteUser', function(Data, CallBack)
    vSERVER.InviteUser(Group,parseInt(Data["id"]),parseInt(Data["userId"]))
end)

RegisterNUICallback('saveNewName', function(Data, CallBack)
    vSERVER.ChangeName(Group,parseInt(Data["id"]),Data["name"])
end)

RegisterNUICallback('PostNewTeamsChatMessage', function(Data, CallBack)
    vSERVER.NewMessage(Group,Data["message"],Data["type"])
end)

RegisterNUICallback('setTeamRole', function(Data, CallBack)
    local Name = vSERVER.UpdateUserRole(Group,parseInt(Data["teamId"]),Data["id"],Data["role"])
    CallBack(Name)
end)

RegisterNUICallback('removeTeamMember', function(Data, CalBlack)
    vSERVER.RemoveUser(Group,parseInt(Data["teamId"]),parseInt(Data["id"]))
end)

RegisterNUICallback('deleteTeam', function(Data, CalBlack)
    vSERVER.DeleteSquad(Group,parseInt(Data["id"]))
end)

RegisterNetEvent("Painel:UpdateTeam",function()
    SendNUIMessage({
        action = "updateTeam",
        data = true
    })
end)
