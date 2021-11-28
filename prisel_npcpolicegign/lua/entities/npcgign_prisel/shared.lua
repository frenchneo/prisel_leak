ENT.Base = "base_ai"
ENT.Type = "anim"
ENT.PrintName        = "NPC GIGN" 
ENT.Category        = "Prisel" 
ENT.Spawnable        = true

function ENT:Initialize( )	
	self:SetModel( "models/player/r6s_doc.mdl" ) 
    self:SetSolid(SOLID_BBOX) 
    if SERVER then self:SetUseType(SIMPLE_USE) self:RegisterPoliceGIGNNpc() end
end