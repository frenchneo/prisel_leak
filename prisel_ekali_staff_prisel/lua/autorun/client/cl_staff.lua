AddCSLuaFile()

local function setFont()
    surface.CreateFont( 'Prisel.HG.Menu.Ekali', {
        font = 'BigNoodleTitling',
        extended = false,
        size = ScreenScale(8),
    })
end
setFont()
hook.Add("OnScreenSizeChanged", "Ekali.HG.Prisel.OnSize.Changed", setFont)

net.Receive("Prisel:Staff:See", function()
    local staffs = net.ReadTable()

    local EkaliPanelHGStaff = vgui.Create("KVS.Frame")
    EkaliPanelHGStaff:SetTitle(EkaliStaffSystem.TitleWindow)
    EkaliPanelHGStaff:SetFrameIcon('FAS', 0xf2f2, main_color)
    EkaliPanelHGStaff:SetBorder(true, true, true, true)
    EkaliPanelHGStaff:SetBorderRadius(5)
    EkaliPanelHGStaff:SetSmoothAlpha(true)
    EkaliPanelHGStaff:SetMainColor(main_color)
    EkaliPanelHGStaff:SetToolBarBackgroundColor(EkaliStaffSystem.BackTall)
    EkaliPanelHGStaff:SetBackgroundColor(EkaliStaffSystem.Back)
    EkaliPanelHGStaff:SetSize(ScrW()*.5, ScrH()*.6)
    EkaliPanelHGStaff:SetDraggable(false)
    EkaliPanelHGStaff:MakePopup()
    EkaliPanelHGStaff:Center()

    for k, v in pairs(staffs) do
        local ply = player.GetBySteamID(k)
        if !ply || !IsValid(ply) then continue end

        local tm = string.FormattedTime( CurTime() - v.start)

        butPlayer = vgui.Create("KVS.Button", EkaliPanelHGStaff)
        butPlayer:SetText(ply:Name() .. " | " ..tm.h.." heures "..tm.m.." minutes "..tm.s.." secondes | " ..ply:GetNWInt("Ekali::GetClaimedTicket::StaffHG") .. " Ticket pris")
        butPlayer:Dock(TOP)
        butPlayer:DockMargin(10, 10, 10,0)
        butPlayer:SetFont('VED')
    end
end)