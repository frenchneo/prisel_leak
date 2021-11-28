util.AddNetworkString("SendArmorGIGN")
util.AddNetworkString("SendArmorPolice")
util.AddNetworkString("SendHealthGIGN")
util.AddNetworkString("SendHealthPolice")

local gignteam = {}
local policeteam = {}
local npcs = {}

local meta = FindMetaTable("Player")
function meta:isNextToPoliceGignNPC()
  for k,v in pairs(npcs) do
    if !IsValid(v) then continue end
    if self:GetPos():Distance(v:GetPos()) < 200 then return true end
  end
  return false
end

local entt = FindMetaTable("Entity")
function entt:RegisterPoliceGIGNNpc()
	npcs[self:EntIndex()] = self
end

hook.Add("Initialize", "SetupGignTeam", function()
  gignteam = {
    [TEAM_GIGN] = true,
    [TEAM_MEDICGIGN] = true,
    [TEAM_SNIPERG] = true,
    [TEAM_CHEFGIGN] = true,
  }
    policeteam = {
    [TEAM_DOUANE] = true,
    [TEAM_POLICE] = true,
    [TEAM_BAC] = true,
    [TEAM_CHIEF] = true,
    [TEAM_GARDEPAIX] = true,
    [TEAM_BRIGADIER] = true,
    [TEAM_MAJOR] = true,
    [TEAM_CAPITAINE] = true,
    [TEAM_MOTARD] = true,
    [TEAM_COMMANDANT] = true,
  }
  chiefteam = {
    [TEAM_CHIEF] = true,
  }
end)

function meta:IsGIGN()
	return isnumber(self:Team()) and gignteam[self:Team()]
end

function meta:IsPolice()
	return isnumber(self:Team()) and policeteam[self:Team()]
end

function meta:IsChief()
	return isnumber(self:Team()) and chiefteam[self:Team()]
end

net.Receive("SendArmorGIGN", function(_,ply)
	if !ply:IsGIGN() or !ply:isNextToPoliceGignNPC() then return end
	ply:SetArmor( 250 )
end)

net.Receive("SendHealthGIGN", function(_,ply)
	if !ply:IsGIGN() or !ply:isNextToPoliceGignNPC() then return end
	ply:SetHealth( 100 )
end)

net.Receive("SendArmorPolice", function(_,ply)
	if !ply:IsPolice() or !ply:isNextToPoliceGignNPC() then return end
    if ply:IsChief() then
        ply:SetArmor( 150 )
    else
        ply:SetArmor( 100 )
    end
end)

net.Receive("SendHealthPolice", function(_,ply)
	if !ply:IsPolice() or !ply:isNextToPoliceGignNPC() then return end
	ply:SetHealth( 100) 
end)

