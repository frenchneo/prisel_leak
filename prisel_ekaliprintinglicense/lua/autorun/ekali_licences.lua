EkaliLicences = EkaliLicences or {}
EkaliLicences.MayorTeam = TEAM_MAYOR
EkaliLicences.openCommand = "!plicence"

EkaliLicences.Licences = {
    ["drugs"] = {
        name = "Drogues",
        price = 100000,
        set = function(ply, bool)
            if ply:GetNWBool("DrugsLicenseEkali", !bool) == bool then return false end
            ply:SetNWBool("DrugsLicenseEkali", bool)
        end,
        get = function(ply)
            return ply:GetNWBool("DrugsLicenseEkali")
        end
    },
    ["printer"] = {
        name = "Printers",
        price = 50000,
        set = function(ply, bool)
            if ply:GetNWBool("PrintingLicenseEkali") == bool then return end
            ply:SetNWBool("PrintingLicenseEkali", bool)
        end,
        get = function(ply)
            return ply:GetNWBool("PrintingLicenseEkali")
        end
    },
    ["weapons"] = {
        name = "Armes",
        price = 8500,
        set = function(ply, bool)
            if ply:getDarkRPVar("HasGunlicense") == bool || RPExtraTeams[ply:Team()].hasLicense then return false end
            ply:setDarkRPVar("HasGunlicense", bool)

            return true
        end,
        get = function(ply)
            return ply:getDarkRPVar("HasGunlicense")
        end
    }
}

if SERVER then

    util.AddNetworkString("Ekali::Licence::GiveLicence")

    net.Receive("Ekali::Licence:GiveLicence", function(_,ply)
        local lType = net.ReadString()
        local toGive = net.ReadEntity()

        if ply:Team() != TEAM_MAYOR then return end
        if !ply:canAfford(lic.price) then DarkRP.notify(ply, 1, 5, "Vous n'avez pas assez d'argent !") return end
        
        local lic = EkaliLicences.Licences[lType]
        if !lic then return end

        if !lic.set(toGive, true) then return end
        ply:addMoney(-lic.price)

    end)

    hook.Add("PlayerSpawn", "Ekali::LicensePrinting::Drugs", function(ply)
    
        timer.Simple(1, function()
            for k,v in pairs(EkaliLicences.Licences) do v.set(ply, false) end
        end)

    end)
else

    local function setFonts()
        surface.CreateFont( "FASS", {
            font = "Font Awesome 5 Free Solid",
            extended = true,
            size = ScreenScale(6),
        } )
        
        surface.CreateFont( "VEDD", {
            font = "Vegur",
            extended = true,
            size = ScreenScale(8),
        } )

        surface.CreateFont( "VEDDD", {
            font = "Vegur",
            extended = true,
            size = ScreenScale(6),
        } )
        
    end
    setFonts()
    
    hook.Add("OnScreenSizeChanged", "Ekali::LicencePrinter::NewResolution::Changed", setFonts)

    local FrameGive
    local framePanel
    local butDrugsLicence
    local butPrintingLicence

    hook.Add("OnPlayerChat", "Ekali::LicensePrinter::MayorCommand", function(ply, str)
        if (ply != LocalPlayer() ) then return end 

        str = string.lower(str)

        if str != EkaliLicences.openCommand || ply:Team() != EkaliLicences.MayorTeam then return end

        framePanel = vgui.Create("KVS.Frame")
        :SetTitle("Gestionnaire de licences")
        :SetFrameIcon('FASS', 0xf2c1, main_color)
        :SetBorder(true, true, true, true)
        :SetBorderRadius(5)
        :SetSmoothAlpha(true)
        :SetMainColor(main_color)
        :SetToolBarBackgroundColor(Color(52, 73, 94))
        :SetBackgroundColor(Color(34, 52, 70))
        :SetSize(ScrW()*.2, ScrH()*.5)
        :SetDraggable(false)
        :Center()
        :MakePopup()
        Derma_Query("Vous êtes autorisé à vendre les licences de printers et drogues seulement en dictature ! Contacter un staff pour demander l'autorisation de faire une dictature (.// + votre message)", "Notification", "OK")
        local scroll = vgui.Create( "DScrollPanel", framePanel )
        scroll:Dock( FILL )
        scroll:DockMargin(20, 10, 20, 10)
    
        
        local sbar = scroll:GetVBar()
        function sbar:Paint(w, h)
            draw.RoundedBox(3, 0, 0, w, h, Color(30, 30, 30, 100))
        end
        function sbar.btnGrip:Paint(w, h)
            draw.RoundedBox(3, 0, 0, w, h, Color(150, 150, 150, 200))
        end
        sbar:SetSize(framePanel:GetWide()*.01, framePanel:GetTall()*.02)
        sbar:SetHideButtons(true)

        for k, v in pairs(player.GetAll()) do
            local but = vgui.Create("KVS.Button", scroll)
            but:Dock(TOP)
            but:DockMargin(0, 0, 5, 10)
            but:SetText(v:Name())
            but:SetFont('VEDD')
            but.DoClick = function(self)
                if IsValid(FrameGive) then FrameGive:Remove() end
                FrameGive = vgui.Create("KVS.Frame")
                FrameGive:SetTitle(v:Name())
                FrameGive:SetFrameIcon('FASS', 0xf2c1, main_color)
                FrameGive:SetBorder(true, true, true, true)
                FrameGive:SetBorderRadius(5)
                FrameGive:SetSmoothAlpha(true)
                FrameGive:SetMainColor(main_color)
                FrameGive:SetToolBarBackgroundColor(Color(52, 73, 94))
                FrameGive:SetBackgroundColor(Color(34, 52, 70))
                FrameGive:SetSize(ScrW()*.2, ScrH()*.2)
                FrameGive:SetDraggable(false)
                FrameGive:SetPos(ScrW()/2 - FrameGive:GetWide()/2, ScrH()*.25)
                FrameGive:MakePopup()
                FrameGive:MoveTo(ScrW()*.62, ScrH()*.25, 0.8, 0, -1)
                FrameGive.Think = function(self)
                    if not IsValid(framePanel) then self:Remove() end
                end

                local scroll = vgui.Create( "DScrollPanel", FrameGive )
                scroll:Dock( FILL )
                scroll:DockMargin(20, 10, 20, 10)

                local sbar = scroll:GetVBar()
                function sbar:Paint(w, h)
                    draw.RoundedBox(3, 0, 0, w, h, Color(30, 30, 30, 100))
                end
                function sbar.btnGrip:Paint(w, h)
                    draw.RoundedBox(3, 0, 0, w, h, Color(150, 150, 150, 200))
                end
                sbar:SetSize(FrameGive:GetWide()*.01, FrameGive:GetTall()*.02)
                sbar:SetHideButtons(true)

                for lType, infos in ipairs(EkaliLicences.Licences) do
                    local but = vgui.Create("KVS.Button", scroll)
                    but:Dock(TOP)
                    but:DockMargin(0, 0, 5, 10)
                    but:SetText("Donner une licence de "..infos.name.." | "..DarkRP.formatMoney(infos.price))
                    but:SetFont('VEDDD')
                    but.DoClick = function(self)

                        if !LocalPlayer():canAfford(infos.price) then notification.AddLegacy("Vous n'avez pas assez d'argent !", NOTIFY_ERROR, 4) return end
                        if infos.get(v) then notification.AddLegacy("La personne a déjà cette licence !", NOTIFY_ERROR, 4) return end
                        
                        net.Start("Ekali::Licence:GiveLicence")
                        net.WriteString(lType)
                        net.WriteEntity(v)
                        net.SendToServer()

                        FrameGive:Close()
                    end
                end
            end
        end
        
        return true
        

    end)

end