if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Taser Ammo"
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Stuns the enemy", TFA.AttachmentColors["-"], "90% reduced damage", "90% reduced RPM" }
ATTACHMENT.Icon = "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "STUN"
ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat * 0.1 end,
		["RPM"] = function( wep, stat ) return stat * 0.1 end,
		["RPM_Semi"] = function( wep, stat ) return stat * 0.1 end,
	},
}

function ATTACHMENT:Attach(wep)
	wep.CustomBulletCallbackOld = wep.CustomBulletCallbackOld or wep.CustomBulletCallback
	wep.CustomBulletCallback = function(a, tr, dmg)
		local wep = dmg:GetInflictor()
		wep.Owner:LagCompensation(true)

        local tr = util.TraceLine(util.GetPlayerTrace( wep.Owner ))
        wep.Owner:LagCompensation(false)

        if SERVER then
            wep.Owner:EmitSound("npc/turret_floor/shoot1.wav",100,100)
        end

        local ent = tr.Entity
        if CLIENT then return end

        if not IsValid(ent) or not ent:IsPlayer() then return end
        if ent == wep.Owner then return end
        if IsValid(ent.tazeragdoll) or ent:GetNWBool("tazefrozen", false) then return end

        local canTaze = hook.Run("PlayerCanTaze", wep.Owner, ent)
        if canTaze == false then return end

        if canTaze != true and (
            ent.tazeimmune or
            STUNGUN.IsPlayerImmune(ent) or
            (not STUNGUN.AllowFriendlyFire and STUNGUN.SameTeam(wep.Owner, ent))
        ) then
            return
        end

        if STUNGUN.DropWeaponOnTaze then
            STUNGUN.DropActiveWeapon(ent)
        end

        if (STUNGUN.StunDamage and STUNGUN.StunDamage > 0) and not ent.tazeimmune then
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(STUNGUN.StunDamage)
            dmginfo:SetAttacker(wep.Owner)
            dmginfo:SetInflictor(wep)
            dmginfo:SetDamageType(DMG_SHOCK)
            dmginfo:SetDamagePosition(tr.HitPos)
            dmginfo:SetDamageForce(wep.Owner:GetAimVector() * 30)
            ent:TakeDamageInfo(dmginfo)
        end

        if ent:Alive() then
            hook.Run("PlayerTazed", ent, wep.Owner)

            STUNGUN.Electrocute( ent, (ent:GetPos() - wep.Owner:GetPos()):GetNormal() )
        end
	end
end

function ATTACHMENT:Detach(wep)
	wep.CustomBulletCallback = wep.CustomBulletCallbackOld
	wep.CustomBulletCallbackOld = nil
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end