AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel(guide_config.model)
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetSolid(SOLID_BBOX)
    self:SetMoveType(MOVETYPE_STEP)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
    self:SetMaxYawSpeed(5000)
    self:SetUseType(SIMPLE_USE)
end

util.AddNetworkString("guideMenu")

function ENT:AcceptInput(name, activator, caller)
    if (not caller:IsValid() or not caller:IsPlayer() or name ~= "Use") then return end
    net.Start("guideMenu")
    net.Send(caller)
end