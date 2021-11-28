local bgc = Color(52, 73, 94)
local bg3 = Color(34, 52, 70)
local TicketBut = Color(39, 174, 96)
local refuseBut = Color(180, 60, 60)

local MessageTicket = ".// Bonjour, on m'a freekill ! Merci de me téléporter."

net.Receive("Playerdead", function(length)
    
    local bFrame = vgui.Create("KVS.Frame")
    bFrame:SetTitle("Signaler un freekill ?")
    bFrame:SetFrameIcon('FASS', 0xf714, main_color)
    bFrame:SetBorder(true, true, true, true)
    bFrame:SetBorderRadius(5)
    bFrame:SetSmoothAlpha(true)
    bFrame:SetMainColor(main_color)
    bFrame:SetToolBarBackgroundColor(bgc)
    bFrame:SetBackgroundColor(bg3)
    bFrame:SetSize(ScrW()*.2, ScrH()*.1)
    bFrame:ShowCloseButton(false)
    bFrame:SetDraggable(false)
    bFrame:Center()
    bFrame:MakePopup()
    bFrame:MoveToBack()

    local doTick = vgui.Create("KVS.Button", bFrame)
    doTick:SetSize(bFrame:GetWide()*.4, bFrame:GetTall()*.3)
    doTick:SetText("Oui")
    doTick:SetFont('VEDD')
    doTick:SetPos(bFrame:GetWide()*.05, bFrame:GetTall()*.57)
    doTick:SetColor(TicketBut)
    doTick:SizeToContents()

    function doTick:DoClick()
        RunConsoleCommand("say", MessageTicket)
        chat.AddText( refuseBut, "[Prisel-Administration]", TicketBut, " Votre message a bien été transmis aux équipe de modération !")
        bFrame:Close()
    end

    local RefuseBut = vgui.Create("KVS.Button", bFrame)
    RefuseBut:SetSize(bFrame:GetWide()*.4, bFrame:GetTall()*.3)
    RefuseBut:SetText("Non")
    RefuseBut:SetFont('VEDD')
    RefuseBut:SetPos(bFrame:GetWide()*.55, bFrame:GetTall()*.57)
    RefuseBut:SetColor(refuseBut)
    RefuseBut:SizeToContents()

    function RefuseBut:DoClick()
        bFrame:Close()
    end
end)