local path = 'prisel_discord'

local function Loading()
    if SERVER then
        local files = file.Find(path..'/config/*.lua', 'LUA')
        for _, file in ipairs(files) do
            AddCSLuaFile(path..'/config/'..file)
            include(path..'/config/'..file)
        end

        local files = file.Find(path..'/shared/*.lua', 'LUA')
        for _, file in ipairs(files) do
            AddCSLuaFile(path..'/shared/'..file)
            include(path..'/shared/'..file)
        end
    
        local files = file.Find(path..'/client/*.lua', 'LUA')
        for _, file in ipairs(files) do
            AddCSLuaFile(path..'/client/'..file)
        end
    end
    
    if CLIENT then
        local files = file.Find(path..'/config/*.lua', 'LUA')
        for _, file in ipairs(files) do
            include(path..'/config/'..file)
        end
        
        local files = file.Find(path..'/shared/*.lua', 'LUA')
        for _, file in ipairs(files) do
            include(path..'/shared/'..file)
        end
    
        local files = file.Find(path..'/client/*.lua', 'LUA')
        for _, file in ipairs(files) do
            include(path..'/client/'..file)
        end
    end
end

Loading()

concommand.Add('prisel_discord_reload', Loading)