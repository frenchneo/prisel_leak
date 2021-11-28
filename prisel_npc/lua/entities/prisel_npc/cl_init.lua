include("shared.lua")
local blur = Material("pp/blurscreen")

local function blurPanel(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)

    for i = 1, 6 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

surface.CreateFont("GeneralFont", {
    font = "Roboto",
    size = 20,
    weight = 1000,
    antialias = true
})

surface.CreateFont("GeneralFont2", {
    font = "Roboto Condensed",
    size = 20,
    weight = 1000,
    antialias = true
})

surface.CreateFont("NPCFont", {
    font = "Coolvetica",
    size = 50,
    weight = 1000,
    antialias = true
})

surface.CreateFont("NPCFont2", {
    font = "Roboto",
    size = 20,
    weight = 1000,
    antialias = true
})

local movingicons = {Material("icon16/exclamation.png"), Material("icon16/delete.png"), Material("icon16/key.png"), Material("icon16/cancel.png"), Material("icon16/rainbow.png"), Material("icon16/wand.png"), nil}
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw()
    self:DrawModel()
    local eye = LocalPlayer():EyeAngles()
    local Pos = self:LocalToWorld(self:OBBCenter()) + Vector(0, 0, 50)
    local Ang = Angle(0, eye.y - 90, 90)
    local clr = HSVToColor(((CurTime() * 10) % 360), 0.5, 0.5)
    if self:GetPos():Distance(LocalPlayer():GetPos()) > 190 then return end
    cam.Start3D2D(Pos + Vector(0, 0, math.sin(CurTime()) * 2), Ang, 0.2)
    draw.SimpleTextOutlined("Owen le guide", "NPCFont", 0, -20, Color(255, 255, 255), TEXT_ALIGN_CENTER, 0, 1.5, Color(0, 0, 0, 255))
    draw.SimpleTextOutlined("Viens par ici !", "NPCFont2", 0, 25, Color(clr.r, clr.g, clr.b, 220), TEXT_ALIGN_CENTER, 0, 1, Color(0, 0, 0, 255))
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(Material("icon16/star.png"))
    surface.DrawTexturedRect(-10, -60, 32, 32)
    cam.End3D2D()
end

net.Receive("guideMenu", function()
    local f = vgui.Create("DFrame")
    f:SetTitle("")
    f:SetSize(ScrW() * 0.35, ScrH() * 0.472)
    f:SetAlpha(0)
    f:AlphaTo(255, 0.25, 0)
    f:Center()
    f:ShowCloseButton(false)
    f:MakePopup()

    f.Paint = function(self, w, h)
        blurPanel(f, 5)
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 220))
        draw.RoundedBox(0, 0, 0, self:GetWide(), 25, Color(41, 128, 255, 50))
        draw.DrawText("Un PNJ qui t'évite de contacter le staff !", "GeneralFont", self:GetWide() / 2, 4, color_white, TEXT_ALIGN_CENTER)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    local c = vgui.Create("DButton", f)
    c:SetText("X")
    c:SetTextColor(color_white)
    c:SetPos(f:GetWide() - 45, 3)
    c:SetSize(40, 20)

    c.DoClick = function()
        f:AlphaTo(0, 0.25, 0, function()
            f:Close()
        end)
    end

    c.Paint = function(self, w, h)
        local kcol

        if self.hover then
            kcol = Color(math.abs(math.sin(CurTime() * 5) * 255), 0, 0, 255)
        else
            kcol = Color(200, 79, 79)
        end

        draw.RoundedBox(0, 0, 0, w, h, kcol)
    end

    c.OnCursorEntered = function(self)
        self.hover = true
    end

    c.OnCursorExited = function(self)
        self.hover = false
    end

    local scroll = vgui.Create("DScrollPanel", f)
    scroll:SetSize(ScrW() * 0.41, ScrH() * 0.43)
    scroll:Dock(TOP)
    local scrollbar = scroll:GetVBar()

    function scrollbar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end

    function scrollbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, 4, 0, w, h, Color(41, 128, 255, 255))
    end

    function scrollbar.btnUp:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end

    function scrollbar.btnDown:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end

    for k, v in ipairs(Guide.Options) do
        local name = Guide.Options[k].name
        local action = Guide.Options[k].action
        local done = Guide.Options[k].done
        local option = vgui.Create("DButton", scroll)
        option:SetSize(50, 60)
        option:SetPos(f:GetWide() / 2, 25)
        option:Dock(TOP)
        option:DockMargin(35, 5, 35, 0)
        option:SetText(name)
        option:SetFont("GeneralFont")
        option:SetTextColor(color_white)

        option.Paint = function(self, w, h)
            local bcol

            if self.hover then
                bcol = Color(41, 128, 255, 100)

                for i, icon in pairs(movingicons) do
                    local seed = i
                    local tick = (CurTime() + seed * 40)
                    local speed = seed % 4 + 1 + (seed * 0.05)
                    local loltick = (CurTime() * 2 + tick * speed * 100) % w
                    surface.SetDrawColor(255, 255, 255)
                    surface.SetMaterial(icon)
                    local iw, ih = 20, 20
                    surface.DrawTexturedRect(loltick, 0 + (h * 2 / 4) + math.sin(loltick / 30) * 5, iw, ih)
                end
            else
                bcol = Color(44, 62, 80, 60)
            end

            draw.RoundedBox(0, 0, 0, w, h, bcol)
            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawOutlinedRect(0, 0, w, h)
        end

        option.OnCursorEntered = function(self, w, h)
            self.hover = true
        end

        option.OnCursorExited = function(self)
            self.hover = false
        end

        local function DrawPopUpFrame()
            local frame = vgui.Create("DFrame")
            frame:SetTitle("")
            frame:SetSize(ScrW() * 0.3, ScrH() * 0.2)
            frame:SetAlpha(0)
            frame:AlphaTo(255, 0.25)
            frame:Center()
            frame:ShowCloseButton(false)
            frame:MakePopup()

            frame.Paint = function(self, w, h)
                blurPanel(self, 5)
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 220))
                draw.RoundedBox(0, 0, 0, w, 30, Color(41, 128, 255, 50))
                draw.DrawText("Tu te fait guider...", "GeneralFont", self:GetWide() / 2, 4, color_white, TEXT_ALIGN_CENTER)
                surface.SetDrawColor(0, 0, 0)
                surface.DrawOutlinedRect(0, 0, w, h)
            end

            local but = vgui.Create("DButton", frame)
            but:SetColor(Color(255, 255, 255))
            but:SetText("Merci de l'aide !")
            but:SetTextColor(color_white)
            but:SetFont("GeneralFont")
            but:SetSize(0, 37)
            but:Dock(BOTTOM)

            but.DoClick = function()
                frame:Close()
            end

            but.Paint = function(self, w, h)
                local bcol

                if self.Hovered then
                    bcol = Color(41, 128, 255, 100)
                else
                    bcol = Color(44, 62, 80, 60)
                end

                draw.RoundedBox(0, 0, 0, w, h, bcol)
                surface.SetDrawColor(0, 0, 0)
                surface.DrawOutlinedRect(0, 0, w, h)
            end

            local dl = vgui.Create("DLabel", frame)
            dl:Dock(TOP)
            dl:SetText(done)
            dl:SetTextColor(color_white)
            dl:SetFont("GeneralFont")
            dl:SetAutoStretchVertical(true)
            dl:SetWrap(true)
        end

        local function DrawPopUpHTMLFrame()
            local frame2 = vgui.Create("DFrame")
            frame2:SetTitle("")
            frame2:SetSize(ScrW() * 0.8, ScrH() * 0.8)
            frame2:SetAlpha(0)
            frame2:AlphaTo(255, 0.25)
            frame2:Center()
            frame2:ShowCloseButton(false)
            frame2:MakePopup()

            frame2.Paint = function(self, w, h)
                blurPanel(self, 5)
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 220))
                draw.RoundedBox(0, 0, 0, w, 30, Color(41, 128, 255, 50))
                draw.DrawText("Merci de patienter pendant le chargement.", "GeneralFont", self:GetWide() / 2, 4, color_white, TEXT_ALIGN_CENTER)
                surface.SetDrawColor(0, 0, 0)
                surface.DrawOutlinedRect(0, 0, w, h)
            end

            local html = vgui.Create("DHTML", frame2)
            html:Dock(FILL)
            html:SetHTML(done)
            html:OpenURL(done)
            local but2 = vgui.Create("DButton", frame2)
            but2:SetColor(Color(255, 255, 255))
            but2:SetText("Merci de l'aide !")
            but2:SetTextColor(color_white)
            but2:SetFont("GeneralFont")
            but2:SetSize(0, 37)
            but2:Dock(BOTTOM)

            but2.DoClick = function()
                frame2:Close()
            end

            but2.Paint = function(self, w, h)
                local bcol

                if self.Hovered then
                    bcol = Color(41, 128, 255, 100)
                else
                    bcol = Color(44, 62, 80, 60)
                end

                draw.RoundedBox(0, 0, 0, w, h, bcol)
                surface.SetDrawColor(0, 0, 0)
                surface.DrawOutlinedRect(0, 0, w, h)
            end
        end

        if action == "URL" then
            option.DoClick = function()
                --LocalPlayer():ChatPrint("Forwarding you to " .. done)

                if guide_config.htmllinkpopup then
                    DrawPopUpHTMLFrame()
                else
                    gui.OpenURL(done)
                end
            end
        elseif action == "MSG" then
            option.DoClick = function()
                DrawPopUpFrame()
            end
        end
    end
end)