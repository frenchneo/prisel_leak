local PriselVitesseConfig = {}

PriselVitesseConfig.ColorLoadingText = Color(192, 57, 43)

PriselVitesseConfig.ColorOKTExt = Color(56, 103, 214)

PriselVitesseConfig.CrouchSpeed = 0.3
PriselVitesseConfig.RunSpeed = 240
PriselVitesseConfig.WalkSpeed = 160

PriselVitesseConfig.Rank = {
    --user = 1, 
    vip = 1.1, 
    elite = 1.2, 
    legende = 1.3, 
    empereur = 1.4,
    modotest = 1,
    modo = 1.1,
    helpeur = 1.2,
    admin = 1.3,
    sa = 1.4,
    superadmin = 1.4,
}



if CLIENT then


    surface.CreateFont( "Prisel.Vitesse.Font", {
        font = "BigNoodleTitling",
        size = ScreenScale(16),
        weight = 500,
    } )
    
    local vitesse = -1
    hook.Add("HUDPaint", "Prisel.Vitesse", function()
        if vitesse == 0 then
            draw.SimpleText("Mise en place de votre vitesse de rang !", "Prisel.Vitesse.Font", ScrW()/2, ScrH()/2, PriselVitesseConfig.ColorLoadingText,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif vitesse == 1 then
            draw.SimpleText("Vitesse de rang mis en place !", "Prisel.Vitesse.Font", ScrW()/2, ScrH()/2, PriselVitesseConfig.ColorOKTExt,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end)
    
    net.Receive("Prisel.Vitesse.Check", function()
        vitesse = 0
    
        timer.Simple(10, function()
            vitesse = -1
        end)
    
    end)
    
    net.Receive("Prisel.Vitesse.OkForVitesse", function()
        vitesse = 1
    
        timer.Simple(3, function()
            vitesse = -1
        end)
    end)

   return 
end


util.AddNetworkString("Prisel.Vitesse.Check")
util.AddNetworkString("Prisel.Vitesse.OkForVitesse")

hook.Add("PlayerSpawn", "Prisel.Vitesse.Check", function(ply)

    local v = PriselVitesseConfig.Rank[ply:GetUserGroup()]
    if !v then return end
    net.Start("Prisel.Vitesse.Check")
    net.Send(ply)

    if ply:GetRunSpeed() == PriselVitesseConfig.RunSpeed * v && ply:GetCrouchedWalkSpeed() == PriselVitesseConfig.CrouchSpeed * v
        && ply:GetWalkSpeed() == PriselVitesseConfig.WalkSpeed * v then return end
    
    timer.Simple(5, function()
        ply:SetCrouchedWalkSpeed(PriselVitesseConfig.CrouchSpeed*v)
        ply:SetWalkSpeed(PriselVitesseConfig.WalkSpeed*v)
        ply:SetRunSpeed(PriselVitesseConfig.RunSpeed*v)
    
        net.Start("Prisel.Vitesse.OkForVitesse")
        net.Send(ply)
    end)
end)

local lastCheck = CurTime()
hook.Add("Think", "Prisel.Vitesse.Check", function()
    if lastCheck > CurTime() then return end
    lastCheck = CurTime() + 10

    for _,ply in pairs(player.GetAll()) do
        
        local v = PriselVitesseConfig.Rank[ply:GetUserGroup()]
        if !v then continue end

        if ply:GetRunSpeed() == PriselVitesseConfig.RunSpeed * v && ply:GetCrouchedWalkSpeed() == PriselVitesseConfig.CrouchSpeed * v
            && ply:GetWalkSpeed() == PriselVitesseConfig.WalkSpeed * v then continue end
        
        ply:SetCrouchedWalkSpeed(PriselVitesseConfig.CrouchSpeed*v)
        ply:SetWalkSpeed(PriselVitesseConfig.WalkSpeed*v)
        ply:SetRunSpeed(PriselVitesseConfig.RunSpeed*v)

    end
end)