include("shared.lua")

SWEP.PrintName = "Megaphone"
SWEP.Author = "Ekali"
SWEP.Purpose = "Amplifie la distance de votre voix."
SWEP.Instructions = ""

SWEP.BobScale = 0
SWEP.SwayScale = 0
SWEP.BounceWeaponIcon = false

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.slot = 5

function SWEP:PostDrawViewModel(vm,wep,ply)
  cam.Start3D()
    local dis = math.sqrt(self:GetDistance())
    local AllTalk = self:GetAllTalk()
    render.SetColorMaterial()
    render.DrawSphere(ply:GetPos(),AllTalk and -200 or -dis,20,20,AllTalk and Color(255,0,0,40) or Color(0,255,0,40))
  cam.End3D()
end
