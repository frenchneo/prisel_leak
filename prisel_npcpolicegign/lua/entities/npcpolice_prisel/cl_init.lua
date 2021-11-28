include("shared.lua") 
function ENT:Draw()
    self:DrawModel();

    local pos = self:GetPos()+ Vector(0, 0, 72)
    local ang = self:GetAngles()


    ang:RotateAroundAxis(ang:Up(), 90);
    ang:RotateAroundAxis(ang:Forward(), 90);
    if LocalPlayer():GetPos():Distance(self:GetPos()) < 400 then
        cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.25)
				draw.SimpleTextOutlined("► Médecin de la police ◄", "fontpriselnpc3", 0, -40, Color(19,71,108), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0.5, Color(50, 50, 50, 255));
                --draw.SimpleTextOutlined("► Prisel.fr ◄", "fontpriselnpc3", 0, -70, Color(0, 120, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, Color(25, 25, 25, 100));  
        cam.End3D2D()
    end;
end;

surface.CreateFont( "fontpriselnpc", {
	font = "Roboto",
	size = 60,
	weight = 1000
} )

surface.CreateFont( "fontpriselnpc2", {
	font = "Roboto",
	size = 23,
	weight = 1000
} )

surface.CreateFont( "fontpriselnpc3", {
	font = "Roboto",
	size = 30,
	weight = 1000
} )

surface.CreateFont( "fontpriselnpc4", {
	font = "Roboto",
	size = 15,
	weight = 1000
} )

surface.CreateFont( "fontpriselnpc5", {
	font = "Roboto",
	size = 21,
	weight = 1000
} )


local function  OpenpriselpolicenpcFrame()
    local scrw, scrh = ScrW(), ScrH()

	local priselpolicenpcFrame = vgui.Create("DFrame")
	priselpolicenpcFrame:SetSize(600, 220)
	priselpolicenpcFrame:SetTitle("") 
	priselpolicenpcFrame:MakePopup()
	priselpolicenpcFrame:Center()
	priselpolicenpcFrame:SetDraggable(false)
	priselpolicenpcFrame:ShowCloseButton(false) 

	priselpolicenpcFrame:MakePopup()

	function priselpolicenpcFrame:Paint(w, h)
		draw.RoundedBox(8, 0, 0, w, h, Color(19,71,108, 255))

		draw.RoundedBox(8, 45, 70, 150, 120, Color(40, 40, 40))
		draw.RoundedBox(8, 45, 35, 150, 30, Color(40, 40, 40))

		draw.RoundedBox(8, 400, 70, 150, 120, Color(40, 40, 40))
		draw.RoundedBox(8, 400, 35, 150, 30, Color(40, 40, 40))
	end



	local priselpolicenpcO = vgui.Create( "Panel", priselpolicenpcFrame)
		priselpolicenpcO:SetPos( 52, -8)
		priselpolicenpcO:SetSize( 175, 225  )
		priselpolicenpcO.Paint = function( self, w, h )
			draw.SimpleText ("         Gilet par balle", "fontpriselnpc5", 50, 58, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

	local priselpolicenpcO = vgui.Create( "Panel", priselpolicenpcFrame)
		priselpolicenpcO:SetPos( 395, -8)
		priselpolicenpcO:SetSize( 175, 225  )
		priselpolicenpcO.Paint = function( self, w, h )
			draw.SimpleText ("         Médicament", "fontpriselnpc5", 61, 58, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end


	local priselpolicenpcB = vgui.Create("DImageButton", priselpolicenpcFrame)
	priselpolicenpcB:SetPos(89, 100)
	priselpolicenpcB:SetSize(64, 64)
	priselpolicenpcB:SetImage("policenpc_prisel/uniform.png")
	priselpolicenpcB.DoClick = function()
	net.Start("SendArmorPolice")
	net.SendToServer()
	priselpolicenpcFrame:Close()
	end

	local priselpolicenpcC = vgui.Create("DImageButton", priselpolicenpcFrame)
	priselpolicenpcC:SetPos(453, 100)
	priselpolicenpcC:SetSize(64, 64)
	priselpolicenpcC:SetImage("policenpc_prisel/medicine.png")
	priselpolicenpcC.DoClick = function()
	net.Start("SendHealthPolice")
	net.SendToServer()
	priselpolicenpcFrame:Close()
	end

	local priselpolicenpcC = vgui.Create("DImageButton", priselpolicenpcFrame)
	priselpolicenpcC:SetPos(215, 30)
	priselpolicenpcC:SetSize(165, 165)
	priselpolicenpcC:SetImage("policenpc_prisel/logo-prisel.png")
	priselpolicenpcC.DoClick = function()
	end

end

net.Receive("priselpolicenpcFrame", OpenpriselpolicenpcFrame)