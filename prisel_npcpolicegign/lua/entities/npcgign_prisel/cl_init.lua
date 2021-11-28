include("shared.lua") 
function ENT:Draw()
    self:DrawModel();

    local pos = self:GetPos()+ Vector(0, 0, 72)
    local ang = self:GetAngles()


    ang:RotateAroundAxis(ang:Up(), 90);
    ang:RotateAroundAxis(ang:Forward(), 90);
    if LocalPlayer():GetPos():Distance(self:GetPos()) < 400 then
        cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.25)
				draw.SimpleTextOutlined("► Médecin du GIGN ◄", "fontpriselnpc3", 0, -40, Color(19,71,108), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0.5, Color(50, 50, 50, 255));
                --draw.SimpleTextOutlined("► Prisel.fr ◄", "fontpriselnpc3", 0, -70, Color(0, 120, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, Color(25, 25, 25, 100));  
        cam.End3D2D()
    end;
end;


local function  OpenpriselgignnpcFrame()
	local priselgignnpcFrame = vgui.Create("DFrame")
	priselgignnpcFrame:SetSize(600, 220)
	priselgignnpcFrame:SetTitle("") 
	priselgignnpcFrame:MakePopup()
	priselgignnpcFrame:Center()
	priselgignnpcFrame:SetDraggable(false)
	priselgignnpcFrame:ShowCloseButton(false) 

	priselgignnpcFrame:MakePopup()

	function priselgignnpcFrame:Paint(w, h)
		draw.RoundedBox(8, 0, 0, w, h, Color(19,71,108, 255))

		draw.RoundedBox(8, 45, 70, 150, 120, Color(40, 40, 40))
		draw.RoundedBox(8, 45, 35, 150, 30, Color(40, 40, 40))

		draw.RoundedBox(8, 400, 70, 150, 120, Color(40, 40, 40))
		draw.RoundedBox(8, 400, 35, 150, 30, Color(40, 40, 40))
	end



	local priselgignnpcO = vgui.Create( "Panel", priselgignnpcFrame)
		priselgignnpcO:SetPos( 52, -8)
		priselgignnpcO:SetSize( 175, 225  )
		priselgignnpcO.Paint = function( self, w, h )
			draw.SimpleText ("         Gilet par balle", "fontpriselnpc5", 50, 58, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

	local priselgignnpcO = vgui.Create( "Panel", priselgignnpcFrame)
		priselgignnpcO:SetPos( 395, -8)
		priselgignnpcO:SetSize( 175, 225  )
		priselgignnpcO.Paint = function( self, w, h )
			draw.SimpleText ("         Médicament", "fontpriselnpc5", 61, 58, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end


	local priselgignnpcB = vgui.Create("DImageButton", priselgignnpcFrame)
	priselgignnpcB:SetPos(89, 100)
	priselgignnpcB:SetSize(64, 64)
	priselgignnpcB:SetImage("policenpc_prisel/uniform.png")
	priselgignnpcB.DoClick = function()
	net.Start("SendArmorGIGN")
	net.SendToServer()
	priselgignnpcFrame:Close()
	end

	local priselgignnpcC = vgui.Create("DImageButton", priselgignnpcFrame)
	priselgignnpcC:SetPos(453, 100)
	priselgignnpcC:SetSize(64, 64)
	priselgignnpcC:SetImage("policenpc_prisel/medicine.png")
	priselgignnpcC.DoClick = function()
	net.Start("SendHealthGIGN")
	net.SendToServer()
	priselgignnpcFrame:Close()
	end

	local priselgignnpcC = vgui.Create("DImageButton", priselgignnpcFrame)
	priselgignnpcC:SetPos(215, 30)
	priselgignnpcC:SetSize(165, 165)
	priselgignnpcC:SetImage("policenpc_prisel/logo-prisel.png")
	priselgignnpcC.DoClick = function()
	end

end

net.Receive("priselgignnpcFrame", OpenpriselgignnpcFrame)