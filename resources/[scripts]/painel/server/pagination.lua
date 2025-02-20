function compareMembers(a, b)
    if a.online ~= b.online then
        return a.online and not b.online
    else
        local roleA = tonumber(a.role)
        local roleB = tonumber(b.role)
        if roleA and roleB then
            return roleA < roleB
        elseif roleA then
            return true
        elseif roleB then
            return false
        else
            return false
        end
    end
end

function searchTableById(data, id)
    local map = false
    for i=1, #data do
        local DataId = tostring(data[i]["id"])
        if string.find(DataId,tostring(id)) then
            if not map then
                map = {}
            end
            table.insert(map, data[i])
        end
    end
    return map
end

function searchTableByName(data, name)
    if type(data) ~= "table" or type(name) ~= "string" then
        return nil -- Return nil if data is not a table or name is not a string
    end

    local map = false
    for i, v in ipairs(data) do
        if type(v.name) == "string" then -- Make sure v.name is a string
            local Name = string.lower(v.name)
            if string.find(Name, string.lower(name), 1, true) then -- Use pattern matching (4th argument 'true') to avoid potential pattern-related issues
                if not map then
                    map = {}
                end
                table.insert(map, v)
            end
        end
    end
    return map
end

function getDataPerPage(data, page)
    local maxResults = 20
    local startIndex = (page - 1) * maxResults + 1
    local endIndex = math.min(startIndex + maxResults - 1, #data)
    local pageData = {}
    for i = startIndex, endIndex do
        pageData[#pageData + 1] = data[i]
    end
    return pageData
end

function getNumPages(data)
    local maxResults = 20
    return math.ceil(#data / maxResults)
end

function getUserPosition(Data,Id)
    local Position = false
    for i=1,#Data do
        if Data[i]["id"] and Data[i]["id"] == Id then
            Position = i
        end
    end
    return Position
end