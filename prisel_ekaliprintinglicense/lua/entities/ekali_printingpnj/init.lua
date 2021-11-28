AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNetworkString( "Ek_Licence:OpenFrameBasic" )
util.AddNetworkString("Ek_Licence:BuyWeaponLicence")

function ENT:Initialize()
	self:SetModel("models/gman_high.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetMaxYawSpeed(90)
end

function ENT:OnTakeDamage()
	return false
end

function ENT:AcceptInput( name, activator, caller )
	if name != "Use" || !caller:IsPlayer() || !caller:Alive() then return end
	
	net.Start("Ek_Licence:OpenFrameBasic")
	net.WriteEntity(self)
	net.Send(caller)
end

net.Receive("Ek_Licence:BuyWeaponLicence", function(_, ply)
	local npc = net.ReadEntity()

	if npc:GetClass() != "ekali_printingpnj" then return end

	local tbl = EkaliLicences.Licences["weapons"]
	if !tbl then return end

	if !ply:canAfford(tbl.price) then return end
	
	if !tbl.set(ply, true) then return end

	ply:addMoney(-tbl.price)

end)