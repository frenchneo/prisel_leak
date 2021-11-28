util.AddNetworkString("Playerdead")

function playerdead(victim)
    if not victim:IsPlayer() then return end
    net.Start("Playerdead")
    net.Send(victim)
end

hook.Add("PlayerDeath", "RDM", function(ply, _, killer)

    if not killer:IsPlayer() then return end
    ply:SetNWBool("Ekali:ISDeadOrNotMec", true)

end)

hook.Add("PlayerSpawn", "Ekali:SendFKReport", function(ply)

    if ply:GetNWBool("Ekali:ISDeadOrNotMec") then
        playerdead(ply)
        ply:SetNWBool("Ekali:ISDeadOrNotMec", false)
    end
    
end)

hook.Add("PlayerDisconnected", "Ekali:GoToFalseNWBool", function(ply)

    if ply:GetNWBool("Ekali:ISDeadOrNotMec") then
        ply:SetNWBool("Ekali:ISDeadOrNotMec", false)
    end

end)