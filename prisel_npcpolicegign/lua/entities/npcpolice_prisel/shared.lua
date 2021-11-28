ENT.Base = "base_ai"
ENT.Type = "anim"
ENT.PrintName        = "NPC POLICE" 
ENT.Category        = "Prisel" 
ENT.Spawnable        = true  

function ENT:Initialize()
    self:SetModel("models/player/portal/f_police2_armor.mdl") 
    self:SetSolid(SOLID_BBOX) 
    if SERVER then self:SetUseType(SIMPLE_USE) self:RegisterPoliceGIGNNpc() end
end