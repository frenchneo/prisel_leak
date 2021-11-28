local staffs = {}

local function sendStaffSortie(ply)
    if !staffs[ply:SteamID()] then return false end
    
    local tm = string.FormattedTime( CurTime() - staffs[ply:SteamID()].start)

    http.Post( "https://www.yaguxxxx.fr/ekali/index.php", {
        title_bot = "Prisel.fr - Heure Staff",
        title_embed = "Heure Staff - Sortie de Staff",
        fill_title = "Nom",
        fill_desc = ply:Nick(),
        filld_title = "Heures Totales",
        filld_desc = tm.h.." Heures "..tm.m.." Minutes "..tm.s.." Secondes",
        fill_steamid = "SteamID",
        fill_steamidjoueur = ply:SteamID(),
        fill_hourenter = "Heure d'entrée",
        fill_hourenterm = staffs[ply:SteamID()].heure,
        fill_hourexit = "Heure de sortie",
        fill_hourexitm = os.date("%H:%M:%S"),
        fill_money = "Tickets",
        fill_m = ply:GetNWInt("Ekali::GetClaimedTicket::StaffHG").. " Ticket pris",
        web_type = "onexit",
        color = "12597547",
        footer_text = "Prisel.fr - Heure Staff",
        img_web = "https://i.imgur.com/4LYJDkD.png",
        webhook_url = ""
    } )

    staffs[ply:SteamID()] = nil

    return true
end

hook.Add( "PlayerChangedTeam", "Ekali.Prisel.Staff.ComeJob", function( ply, oldTeam, newTeam )
    if table.HasValue(EkaliStaffSystem.Staff, ply:GetUserGroup()) && team.GetName(newTeam) == "Staff en service" then
        staffs[ply:SteamID()] = {
            start = CurTime(),
            heure = os.date("%H:%M:%S")
        }
        return
    end

    if !table.HasValue(EkaliStaffSystem.Staff, ply:GetUserGroup()) || team.GetName(oldTeam) != "Staff en service" || !staffs[ply:SteamID()] then return end
    if !sendStaffSortie(ply) then print("Error while sending staff ending session, no staff information") end
end )

hook.Add("PlayerDisconnected", "Prisel.HG.Heure.Staff.Disconnect.Staff", function(ply)
    if !table.HasValue(EkaliStaffSystem.Staff, ply:GetUserGroup()) || team.GetName(ply:Team()) != "Staff en service" then return end
    if !sendStaffSortie(ply) then print("Error while sending staff ending session, no staff information") end
    ply:SetNWInt("Ekali::GetClaimedTicket::StaffHG", 0)
end)

hook.Add("OnPlayerChat", "Ekali.Prisel.Open.HG.Menu", function(pl, str)

    local str = string.lower(str)

    if str != EkaliStaffSystem.Commande then return end
    if !table.HasValue(EkaliStaffSystem.HautGrade, pl:GetUserGroup()) then return end

    net.Start("Prisel:Staff:See")
    net.WriteTable(staffs)
    net.Send(pl)
end)