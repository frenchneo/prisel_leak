AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("priselgignnpcFrame")

function ENT:SpawnFunction(ply, tr, classname) 
    if !tr.Hit then return end
    local SpawnPos = tr.HitPos + tr.HitNormal * 0
    local ent = ents.Create(classname)
    ent:SetPos(SpawnPos)
    ent:Spawn()
    ent:Activate()
    return ent
end

function ENT:Use(act, ply)
	if ply:IsGIGN() && ply:isNextToPoliceGignNPC() then
		net.Start("priselgignnpcFrame")
		net.Send(ply)
    else

        ply:ChatPrint("<c=52,152,219>[Prisel]</c> <c=0,200,0>Vous devez être GIGN pour acceder à ce matériel</c>")
	end
end