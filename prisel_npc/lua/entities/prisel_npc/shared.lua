ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Owen Le Guide"
ENT.Category = "Prisel"
ENT.Instructions = "Appuyer sur E (Touche 'USE')"
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end

guide_config = {}
guide_config.model = "models/eli.mdl"
guide_config.htmllinkpopup = true
AddCSLuaFile()
Guide = {} or Guide
Guide.Options = {}

function Guide:AddOption(name, action, done)
    if action == "URL" or action == "MSG" then
        table.insert(Guide.Options, {
            name = name,
            action = action,
            done = done
        })
    end
end

Guide:AddOption("Je recherche la boutique", "MSG", "Fais !vip pour acceder a notre boutique automatisée !")
Guide:AddOption("Je recherche le forum", "MSG", "Notre forum : prisel.fr/forum")
Guide:AddOption("Je recherche les addons", "MSG", "Les addons sont disponibles sur prisel.fr (en bas de page)")
Guide:AddOption("J'aimerais le Discord !", "MSG", "Voici le Discord officiel du serveur Prisel : discord.gg/prisel")
Guide:AddOption("J'aimerais le TeamSpeak !", "MSG", "Voici le TeamSpeak officiel du serveur Prisel : ts.prisel.fr")
Guide:AddOption("J'aimerai rejoindre le staff", "MSG", "Les recrutements sont #ON ! Rendez-vous sur le forum !")
Guide:AddOption("Comment parler en [Publicité] ?", "MSG", "Il suffit de faire la commande /ad 'Mon texte'")
Guide:AddOption("Je suis bloqué dans un mur/props !", "MSG", "Fais /unstuck pour te débloquer sans déranger un admin !")
