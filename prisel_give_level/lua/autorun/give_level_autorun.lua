local path = 'give_level'

local function Loading()
    if SERVER then
        local files = file.Find(path..'/server/*.lua', 'LUA')
        for _, file in ipairs(files) do
            include(path..'/server/'..file)
        end
    end
end

Loading()