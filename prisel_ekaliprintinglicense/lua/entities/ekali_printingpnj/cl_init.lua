include('shared.lua')

local function setFont()
    surface.CreateFont( "Prisel::FAS::PNJ::LICENCE", {
        font = "Font Awesome 5 Free Solid",
        extended = true,
        weight = 1000,
        shadow = true,
        size = ScreenScale(6),
    } )
    
    surface.CreateFont( "Prisel::OnExterieur::Font::Licence", {
        font = "Vegur",
        size = ScreenScale(14),

    } )

    surface.CreateFont( "Prisel::MenuButton::Licencs", {
        font = "Vegur",
        size = ScreenScale(6),
    } ) 
end
setFont()


hook.Add("OnScreenSizeChanged", "Ekali::DDed::NewResolution::Changed", setFont)
    
function ENT:Draw()

	self:DrawModel()

    plypos = LocalPlayer():GetPos()
    image = (plypos:Distance(self:GetPos()) /200)
    eye = LocalPlayer():EyeAngles()
    pos = self:LocalToWorld(self:OBBCenter()) + Vector(0, 0, 50)
    ang = Angle( 0, eye.y - 90, 90 )
    image = math.Clamp(1.75 - image, 0 ,1)

    ent = self

	if plypos:DistToSqr(self:GetPos()) < 350^2 then

		cam.Start3D2D(pos + Vector(0, 0, math.sin(CurTime())*3), ang, 0.13)
            draw.RoundedBox(3, ScrW()/-22.5, ScrH()*(-0.0005), ScrW()*0.1, ScrH()*0.05, Color(52, 73, 94))
			draw.SimpleText("Licences", "Prisel::OnExterieur::Font::Licence", ScrW()/-35, ScrH()*.003, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        cam.End3D2D()

    end
end

net.Receive( "Ek_Licence:OpenFrameBasic", function()
  	local selfnpc = net.ReadEntity()
    if !LocalPlayer():IsValid() || !LocalPlayer():Alive() || plypos:DistToSqr(ent:GetPos()) > 350^2 then return end
    if team.NumPlayers(EkaliLicences.MayorTeam) >= 1 then notification.AddLegacy("Il y a un maire, va lui demander plutôt!", NOTIFY_ERROR, 4) return end 
    
    local tbl = EkaliLicences.Licences["weapons"]
    if !tbl then return end
    
    if tbl.get(LocalPlayer()) then notification.AddLegacy("Vous avez déjà une licence, pourquoi en racheter une ?", NOTIFY_ERROR, 4) return end

    surface.PlaySound("vo/coast/odessa/nlo_cub_hello.wav")


    if IsValid(FrameGive) then FrameGive:Remove() end
    local FrameGive = vgui.Create("KVS.Frame")
    FrameGive:SetTitle("Acheter une licence")
    FrameGive:SetFrameIcon('Prisel::FAS::PNJ::LICENCE', 0xf2c1, main_color)
    FrameGive:SetBorder(true, true, true, true)
    FrameGive:SetBorderRadius(5)
    FrameGive:SetSmoothAlpha(true)
    FrameGive:SetMainColor(main_color)
    FrameGive:SetToolBarBackgroundColor(Color(52, 73, 94))
    FrameGive:SetBackgroundColor(Color(34, 52, 70))
    FrameGive:SetSize(ScrW()*.2, ScrH()*.12)
    FrameGive:SetDraggable(false)
    FrameGive:MakePopup()
    FrameGive:Center()

    local scroll = vgui.Create( "DScrollPanel", FrameGive )
    scroll:Dock( FILL )
    scroll:DockMargin(20, 15, 20, 3)


    local sbar = scroll:GetVBar()
    function sbar:Paint(w, h)
        draw.RoundedBox(3, 0, 0, w, h, Color(30, 30, 30, 100))
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(3, 0, 0, w, h, Color(150, 150, 150, 200))
    end
    sbar:SetSize(FrameGive:GetWide()*.01, FrameGive:GetTall()*.02)
    sbar:SetHideButtons(true)

    local but = vgui.Create("KVS.Button", scroll)
    but:Dock(TOP)
    but:DockMargin(0, 0, 5, 10)
    but:SetText("Acheter une licence d'armes | "..DarkRP.formatMoney(tbl.price))
    but:SetFont('Prisel::MenuButton::Licencs')

    function but:DoClick()
        if !LocalPlayer():canAfford(tbl.price) then notification.AddLegacy("Vous n'avez pas assez d'argent !", NOTIFY_ERROR, 4) return end
        if tbl.get(LocalPlayer()) then notification.AddLegacy("Vous avez déjà une licence !", NOTIFY_ERROR, 4) return end
        
        net.Start("Ek_Licence:BuyWeaponLicence")
        net.WriteEntity(selfnpc)
        net.SendToServer()

        FrameGive:Close()
    end
end )
