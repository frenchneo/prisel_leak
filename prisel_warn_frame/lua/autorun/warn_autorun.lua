if CLIENT then

    local BackTall = Color(40, 40, 40)
    local back = Color(60, 60, 60)
    local box = Color(80, 80, 80)
    local bgc = Color(52, 73, 94)
    local bg3 = Color(34, 52, 70)
    local TicketBut = Color(41, 128, 185)
    local x, y = ScrW(), ScrH()
    
    local function setFonts()
        x, y = ScrW(), ScrH()
    
        surface.CreateFont( 'Prisel.Warn', {
            font = 'BigNoodleTitling',
            extended = false,
            size = ScreenScale(8),
            weight = 200,
        })
    end
    setFonts()
    hook.Add('OnScreenSizeChanged', 'Prisel.Warn.Hooks.OnScreenSizeChanged', setFonts)
    
    net.Receive('Prisel.Warn.Nets.OpenMenu', function()
        if not IsValid(LocalPlayer()) then return end
        
        local frameWarnPrevent = vgui.Create('KVS.Frame')
        frameWarnPrevent:SetTitle('Vous avez pris un warn.')
        frameWarnPrevent:SetFrameIcon('FAS', 0xf0ca, main_color)
        frameWarnPrevent:SetBorder(true, true, true, true)
        frameWarnPrevent:SetBorderRadius(5)
        frameWarnPrevent:SetSmoothAlpha(true)
        frameWarnPrevent:SetMainColor(main_color)
        frameWarnPrevent:SetToolBarBackgroundColor(BackTall)
        frameWarnPrevent:SetBackgroundColor(back)
        frameWarnPrevent:SetSize(ScrW()*.22, ScrH()*.35)
        frameWarnPrevent:SetDraggable(false)
        frameWarnPrevent:MakePopup()
        frameWarnPrevent:Center()
    
        local dPanel = vgui.Create('DPanel', frameWarnPrevent)
        dPanel:SetSize(x*0.4, y*0.3)
        dPanel:SetPos(x*0.01, y*0.06)
        function dPanel:Paint(w, h)
            draw.WordBox(3, 0, h*.160, '- 3 avertissements kick​', 'Prisel.Warn', box, color_white)
            draw.WordBox(3, 0, h*.235, '- 6 avertissements ban 1 jours​', 'Prisel.Warn', box, color_white)
            draw.WordBox(3, 0, h*.310, '- 10 avertissements ban 3 semaines', 'Prisel.Warn', box, color_white)
            draw.WordBox(3, 0, h*.385, '- 13 avertissements ban 1 mois​​', 'Prisel.Warn', box, color_white)
            draw.WordBox(3, 0, h*.460, '- 16 avertissements 2 mois​', 'Prisel.Warn', box, color_white)
            draw.WordBox(3, 0, h*.535, '- 20 avertissements ban perm sans possibilité de déban​', 'Prisel.Warn', box, color_white)
    
            draw.WordBox(3, 0, h*.650, '', 'Prisel.Warn', Color(0, 0, 0, 0), color_white)
        end
    
        local dLabell = vgui.Create("DLabel", dPanel)
        dLabell:SetSize(dPanel:GetWide(), dPanel:GetTall())
        dLabell:SetPos(0, dPanel:GetTall()*(-.43))
        dLabell:SetText("Vous venez de prendre un warn.\nSuite a cela voici la liste des sanctions, par rapport a cela :")
        dLabell:SetFont('Prisel.Warn')
        dLabell:SetColor(color_white)
        dLabell:SetWrap(true)
    
        local dSecondeChance = vgui.Create("DLabel", dPanel)
        dSecondeChance:SetSize(dPanel:GetWide(), dPanel:GetTall())
        dSecondeChance:SetPos(0, dPanel:GetTall()*.2)
        dSecondeChance:SetText("Vous voulez reset vos warns ? Le pack seconde chance est là !")
        dSecondeChance:SetFont('Prisel.Warn')
        dSecondeChance:SetColor(color_white)
        dSecondeChance:SetWrap(true)
    
    
        local doTick = vgui.Create('KVS.Button', frameWarnPrevent)
        doTick:SetSize(x*0.08, y*0.04)
        doTick:SetText('Pack Seconde Chance')
        doTick:SetFont('Prisel.Warn')
        doTick:SetPos(x*0.02, y*0.3)
        doTick:SetColor(TicketBut)
        doTick:SizeToContents()
        function doTick:DoClick()
            gui.OpenURL('https://prisel.koredia.com/category/packs-darkrp')
        end
    
        local doTick2 = vgui.Create('KVS.Button', frameWarnPrevent)
        doTick2:SetSize(x*0.08, y*0.04)
        doTick2:SetText('Compris')
        doTick2:SetFont('Prisel.Warn')
        doTick2:SetPos(x*0.115, y*0.3)
        doTick2:SetColor(TicketBut)
        doTick2:SizeToContents()
        function doTick2:DoClick()
            frameWarnPrevent:Close()
        end
    end)    
    return
end

util.AddNetworkString('Prisel.Warn.Nets.OpenMenu')
resource.AddFile('resource/fonts/big_noodle_titling.ttf')

hook.Add('AWarnPlayerWarned', 'Prisel.Warn.Hook.AWarnPlayerWarned', function(ply)
    if not IsValid(ply) then return end

    net.Start('Prisel.Warn.Nets.OpenMenu')
    net.Send(ply)
end)