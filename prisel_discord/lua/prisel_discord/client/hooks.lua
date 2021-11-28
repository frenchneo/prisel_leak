surface.CreateFont("Ekali::Prisel::Discord::Icon", {
    font = "Font Awesome 5 Solid",
    extended = true,
    size = ScreenScale(7)
})

surface.CreateFont( "Ekali::Prisel::Discord", {
    font = "Vegur",
    extended = true,
    size = ScreenScale(7),
} )

hook.Add("OnScreenSizeChanged", "Ekali::Prisel::Discord::ResolutionChanged", function()

    surface.CreateFont("Ekali::Prisel::Discord::Icon", {
        font = "Font Awesome 5 Solid",
        extended = true,
        size = ScreenScale(7)
    })
    
    surface.CreateFont( "Ekali::Prisel::Discord", {
        font = "Vegur",
        extended = true,
        size = ScreenScale(7),
    } )
    
end)

hook.Add("OnPlayerChat", "Ekali::Prisel::Discord::OpenCommandChat", function(pl, str)

    if ( pl != LocalPlayer() ) then return end

    if str == Prisel_Discord_Config.CommandT then
        local frameDiscord = vgui.Create("KVS.Frame")
        frameDiscord:SetTitle("Rejoignez nos Discords")
        frameDiscord:SetFrameIcon('Ekali::Prisel::Discord::Icon', 0xf0ca, main_color)
        frameDiscord:SetBorder(true, true, true, true)
        frameDiscord:SetBorderRadius(5)
        frameDiscord:SetSmoothAlpha(true)
        frameDiscord:SetMainColor(main_color)
        frameDiscord:SetToolBarBackgroundColor(Prisel_Discord_Config.ConfigBackTall)
        frameDiscord:SetBackgroundColor(Prisel_Discord_Config.ConfigBack)
        frameDiscord:SetSize(ScrW()*.3, ScrH()*.25)
        frameDiscord:SetDraggable(false)
        frameDiscord:MakePopup()
        frameDiscord:Center()

        local dPanel = vgui.Create("DPanel", frameDiscord)
        dPanel:SetSize(frameDiscord:GetWide()*.95, frameDiscord:GetTall()*.3)
        dPanel:SetPos(frameDiscord:GetWide()/2 - dPanel:GetWide()/2, frameDiscord:GetTall()*.15)

        function dPanel:Paint(w, h)
            -- draw.WordBox(3, 0, 0, Prisel_Discord_Config.TextLabel1, "VED", Prisel_Discord_Config.ConfigBox, color_white)
            -- draw.WordBox(3, 0, h*.3, Prisel_Discord_Config.TextLabel2, "VED", Prisel_Discord_Config.ConfigBox, color_white)
            -- draw.WordBox(3, 0, h*.6, Prisel_Discord_Config.TextLabel3, "VED", Prisel_Discord_Config.ConfigBox, color_white)
        end

        local dLabel = vgui.Create("DLabel", dPanel)
        dLabel:SetFont('Ekali::Prisel::Discord')
        dLabel:SetSize(dPanel:GetWide(), dPanel:GetTall())
        dLabel:SetText(Prisel_Discord_Config.TextLabel)
        dLabel:SetWrap(true)

        for k, v in ipairs(Prisel_Discord_Config.List) do
            local butPair = vgui.Create("KVS.Button", frameDiscord)
            butPair:Dock(TOP)
            butPair:DockMargin(20, 60, 20, -50)
            butPair:SetText(v.name)
            butPair:SetFont('Ekali::Prisel::Discord')

            function butPair:DoClick()
                gui.OpenURL(v.link)
            end
        end

        return true
    end

end)