concommand.Add("prisel_add_level", function(ply, cmd, args)
    if ply:IsPlayer() then return end

    local stid = args[1]..args[2]..args[3]..args[4]..args[5]
    local sti64 = util.SteamIDTo64(stid)
    local playerE = player.GetBySteamID(stid)

    if ply:IsPlayer() then return end

    if not playerE then
        if not file.Exists("prisel_level", "DATA") then file.CreateDir("prisel_level") end
        if not file.Exists("prisel_level/" .. sti64..".txt", "DATA") then file.Append("prisel_level/" .. sti64..".txt", args[6]) return end
        if file.Exists("prisel_level", "DATA") and file.Exists("prisel_level/" .. sti64..".txt", "DATA") then
            local openPri = file.Read("prisel_level/" .. sti64..".txt", "DATA")

            file.Write("prisel_level/" .. sti64..".txt", tonumber(openPri) + tonumber(args[6]))
        
        end
    return end
    
    GlorifiedLeveling.AddPlayerLevels(playerE, args[6])
    playerE:ChatPrint( "[Prisel-Boutique] Vos " ..args[6].. " niveaux vous ont été ajoutés !" )

end)

hook.Add("PlayerInitialSpawn", "Ekali::Boutique::LevelAdd::OnOffline", function(ply)

    local sti64 = ply:SteamID64()

    if not file.Exists("prisel_level/" .. sti64..".txt", "DATA") then return end
    
    if file.Exists("prisel_level", "DATA") and file.Exists("prisel_level/" .. sti64..".txt", "DATA") then
        local openPri = file.Read("prisel_level/" .. sti64..".txt", "DATA")

        timer.Simple(10, function()
            ply:ChatPrint("[Prisel-Boutique] Vos " .. openPri.. " niveaux ont été acheté quand vous n'étiez pas en ligne ! Ils vous ont donc été ajouté !")
            GlorifiedLeveling.AddPlayerLevels(ply, openPri)
        end)

        file.Delete("prisel_level/" .. sti64..".txt")
    
    end

end)