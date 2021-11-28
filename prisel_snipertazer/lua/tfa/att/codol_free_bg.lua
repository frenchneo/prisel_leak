if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Nilfgaardian Finish"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Black", "Gold Accents" }
ATTACHMENT.Icon = "entities/tfa_ins2_codol_free_bg.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "NILF"

ATTACHMENT.WeaponTable = {
	["Skin"] = 1
}

function ATTACHMENT:Attach( wep )
	wep.VElements["sights_folded"].skin_old = wep.VElements["sights_folded"].skin_old or wep.VElements["sights_folded"].skin
	wep.VElements["sights_folded"].skin = self.WeaponTable.Skin
end

function ATTACHMENT:Detach( wep )
	wep.VElements["sights_folded"].skin = wep.VElements["sights_folded"].skin_old
end


if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end

