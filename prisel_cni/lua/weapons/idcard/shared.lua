if SERVER then
    AddCSLuaFile("shared.lua")
end

if CLIENT then
    SWEP.PrintName = "Carte d'identité"
    SWEP.Slot = 2
    SWEP.SlotPos = 2
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
end

SWEP.Author = "Prisel"
SWEP.Instructions = "Gardez cette carte en main pour la montrer aux autres joueurs."
SWEP.Contact = "http://steamcommunity.com/groups/prisel"
SWEP.Purpose = ""
SWEP.HoldType = "pistol"
SWEP.WorldModel = ""
SWEP.AnimPrefix = "pistol"
SWEP.Category = "Prisel"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
    self:SetHoldType("pistol")
end

function SWEP:CanPrimaryAttack()
    return false
end

function SWEP:CanSecondaryAttack()
    return false
end

function SWEP:DrawWorldModel()
end

function SWEP:PreDrawViewModel(vm)
    return true
end

if CLIENT then
    surface.CreateFont("prisel_font", {
        font = "Roboto",
        size = 24,
        weight = 1500,
        antialias = true
    })

    surface.CreateFont("prisel_font_bis", {
        font = "Roboto",
        size = 20,
        weight = 1500,
        antialias = true
    })

    surface.CreateFont("prisel_font_yn", {
        font = "Roboto",
        size = 28,
        weight = 1500,
        antialias = true
    })

    local VUMat = Material("id_card_french.png")

    function SWEP:DrawHUD()
        local LW, LH = 500, 250
        local W, H = ScrW() - LW - 5, ScrH() - LH - 5
        local LP = LocalPlayer()

        LP.PIcon = LP.PIcon or vgui.Create("ModelImage")
        LP.PIcon:SetSize(146, 144)
        LP.PIcon:SetModel(LP:GetModel())
        surface.SetMaterial(VUMat)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(W, H, LW, LH)
        LP.PIcon:SetPos(W + 25, H + 71)
        LP.PIcon:SetPaintedManually(false)
        LP.PIcon:PaintManual()
        LP.PIcon:SetPaintedManually(true)

        local TextW, TextH = W + 175, H + 75
        draw.SimpleText(LP:Nick(), "prisel_font", TextW, TextH, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(LP:SteamID(), "prisel_font", TextW, TextH + 30, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Licence d'armes :", "prisel_font", TextW, TextH + 60, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Licence de printer :", "prisel_font", TextW, TextH + 90, Color(0, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Licence de drogue :", "prisel_font", TextW, TextH + 120, Color(0, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        if LP:getDarkRPVar("HasGunlicense") then
            draw.SimpleText("OUI", "prisel_font", TextW + 160, TextH + 61, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("NON", "prisel_font", TextW + 160, TextH + 61, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        if LP:GetNWBool("PrintingLicenseEkali") then
            draw.SimpleText("OUI", "prisel_font", TextW + 170, TextH + 90, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("NON", "prisel_font", TextW + 170, TextH + 90, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        if LP:GetNWBool("DrugsLicenseEkali") then
            draw.SimpleText("OUI", "prisel_font", TextW + 175, TextH + 120, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("NON", "prisel_font", TextW + 175, TextH + 120, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        local DIS = 0
        local CS = 5
        local LicenseW, LicenseH = W + 325, H + 90
    end

    local lastCheck = CurTime()
    hook.Add("PreDrawTranslucentRenderables", "DrawDICards", function()
        if lastCheck > CurTime() then return end
        lastCheck = lastCheck + .5
        local LPlayer = LocalPlayer()

        for k, v in pairs(player.GetAll()) do
            local CurWep = v:GetActiveWeapon()

            if v ~= LPlayer and IsValid(CurWep) and v:GetActiveWeapon():GetClass() == "idcard" and v:HasWeapon("idcard") then
                if LPlayer:GetPos():Distance(v:GetPos()) > 400 then return end
                lastCheck = 0
                v.PIcon = v.PIcon or vgui.Create("ModelImage")
                v.PIcon:SetSize(90, 93)
                v.PIcon:SetModel(v:GetModel())
                local boneindex = v:LookupBone("ValveBiped.Bip01_R_Hand")

                if boneindex then
                    local HPos, HAng = v:GetBonePosition(boneindex)
                    HAng:RotateAroundAxis(HAng:Forward(), -90)
                    HAng:RotateAroundAxis(HAng:Right(), -90)
                    HAng:RotateAroundAxis(HAng:Up(), 5)
                    HPos = HPos + HAng:Up() * 4 + HAng:Right() * -5 + HAng:Forward() * 1
                    cam.Start3D2D(HPos, HAng, 1)
                    surface.SetMaterial(VUMat)
                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.DrawTexturedRect(0, 0, 15, 8)
                    cam.End3D2D()
                    cam.Start3D2D(HPos, HAng, .05)
                    v.PIcon:SetPos(12, 45)
                    v.PIcon:SetPaintedManually(false)
                    v.PIcon:PaintManual()
                    v.PIcon:SetPaintedManually(true)
                    local TextW = 105
                    draw.SimpleText(v:Nick(), "prisel_font_bis", TextW, 50, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(v:SteamID(), "prisel_font_bis", TextW, 70, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText("Licence d'armes : ", "prisel_font_bis", TextW, 90, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText("Licence de printer : ", "prisel_font_bis", TextW, 110, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText("Licence de drogue : ", "prisel_font_bis", TextW, 130, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                    if v:getDarkRPVar("HasGunlicense") then
                        draw.SimpleText("OUI", "prisel_font_bis", TextW + 135, 90, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText("NON", "prisel_font_bis", TextW + 135, 90, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    end

                    if v:GetNWBool("PrintingLicenseEkali") then 
                        draw.SimpleText("OUI", "prisel_font_bis", TextW + 142, 110, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText("NON", "prisel_font_bis", TextW + 142, 110, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    end

                    if v:GetNWBool("DrugsLicenseEkali") then 
                        draw.SimpleText("OUI", "prisel_font_bis", TextW + 144, 130, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText("NON", "prisel_font_bis", TextW + 144, 130, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    end

                    local LicenseW = 225
                    local DIS = 35
                    local CS = 40
                    cam.End3D2D()
                end
            end
        end
    end)
end