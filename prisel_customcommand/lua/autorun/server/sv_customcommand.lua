local function getCommands()
    return util.JSONToTable(file.Read("prisel_commands.txt") or "[]")
end

local function setCommands(c)
    file.Write("prisel_commands.txt", util.TableToJSON(c))
    return c
end

local function commandExists(command)
    return concommand.GetTable()[command]
end

local function initCommands()
    local c = getCommands()
    for command,tbl in pairs(c) do
        if commandExists(command) then concommand.Remove(command) end

        concommand.Add(command, function(ply)
            if ply:SteamID() != tbl.sid then return end
            for k,v in pairs(tbl.weapons) do
                ply:Give(v)
            end
        end)
        print(command .. " initialisé pour "..tbl.sid)
    end
end

concommand.Add("prisel_newcommand", function(ply, _, args)
    if IsValid(ply) then return end

    local sid, command, list_str = args[1], args[2], args[3]
    
    if sid == "" || command == "" || list_str == "" then
        print("Mauvais arguments !", "SID: "..sid, "Command: "..command, "Armes: "..list_str)
        return
    end
    local c = getCommands()

    if command == "delete" then
        local command = sid
        if !c[command] then print(command.. " est inexistant !") return end

        if commandExists(command) then
            concommand.Remove(command)
        end
        c[command] = nil
        setCommands(c)
        print(command .. " supprimée")
        return
    end

    local list = {}
    for k,v in pairs(string.Explode(',', list_str, false)) do
        local weap = string.gsub(v, " ", "")
        table.insert(list, weap)
    end
    if table.IsEmpty(list) then print("No weapon !") return end

    local command_tbl = {
        sid = sid,
        command = command,
        weapons = list
    }

    c[command] = command_tbl
    setCommands(c)
    initCommands()
    print(command .. " ajouté pour "..sid)
end)

initCommands()