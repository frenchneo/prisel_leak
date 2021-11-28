ENT.Base	    			= "base_ai"
ENT.Type	    			= "ai"
ENT.PrintName				= "Licence Printer/Drogue"
ENT.Author					= "Ekali"
ENT.Category				= "Prisel.fr"
ENT.Contact					= ""
ENT.Instructions			= "Approchez vous du NPC et actionnez votre touche [USE]"
ENT.Spawnable				= true
ENT.AdminSpawnable			= true
ENT.AutomaticFrameAdvance	= true

function ENT:SetAutomaticFrameAdvance(byUsingAnim)
	self.AutomaticFrameAdvance = byUsingAnim
end
