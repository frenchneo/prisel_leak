PRS = {}

--[[ Edit these settings to your liking ]]--

PRS.Enabled = true -- Pretty self-explanatory :D
PRS.KickTooMany = false -- If a person with access to reserved slot joins, but the server is full, it kicks the person with the shortest time on the server
PRS.HiddenReserved = false -- Should he reserved slots be hidden from the menu. So if this is true when people look at the server in menu, they see that there are no slots left, if false they will see empty slots, but if they have no access to reserved slots they won't be able to join
PRS.SlotNum = 18 -- How many slots should be reserved, remember if your server is set to have 16 slots and you reserver 2, so if there are 14 people on, only specified SteamID's will
PRS.AlwaysOpenSlot = false -- Set to true if you want 1 slot to always be open, this will make it so players with reserved slot ability can join the server 1st try even if it is full, because else gmod blocks them from entering even if another person is kicked.
PRS.ReservedGroups = { "superadmin", "sa", "admin", "helpeur", "modo", "modotest", "vip", "empereur", "elite", "legende" } -- Groups that will be able to join the reserved slots, add them this way: { "admin", "Owner", "user"} and so on (Case sensitive!) {} if no groups. If you use AssMod then you must have the ranks number based because that's how AssMod works
PRS.ReservedSteamIDs = { "STEAM_0:1:117060447", "STEAM_0:0:85116110" } -- SteamIDs that will be able to join the reserved slots even if they don't have a reserved group, add them this way: { "admin", "Owner", "user"} and so on. {} if no SteamIDs

PRS.LetReservedPastPass = false -- Will not check if password is correct if the person has a rank with reserved slots
PRS.KickLowestTime = true -- If true it will kick the person that has connected the most recently, if false it will kick the person that has joined the longest time ago

PRS.BlockMsg = [[
--------------------------------------------------------------------
								PRISEL
    		Désolé, mais les derniers slots sont réservés
				Les VIP ont le privilège d'y accéder
						prisel.fr/boutique
--------------------------------------------------------------------
]] -- Message that will show up for the person that couldn't join because the server had no normal slots open
PRS.KickMsg = [[
	--------------------------------------------------------------------
									PRISEL
				Désolé, mais les derniers slots sont réservés
					Les VIP ont le privilège d'y accéder
							prisel.fr/boutique
	--------------------------------------------------------------------
]] -- Message that will show up for the person that was kicked to free a spot for reserved
PRS.NoSlotsToFreeMsg = [[
	--------------------------------------------------------------------
									PRISEL
				Désolé, mais les derniers slots sont réservés
					Les VIP ont le privilège d'y accéder
							prisel.fr/boutique
	--------------------------------------------------------------------
]] -- Message that will show up for the person that couldn't join because everyone on the server has reserved slot and noone can be kicked
PRS.FullServerMsg = [[
	--------------------------------------------------------------------
									PRISEL
				Désolé, mais les derniers slots sont réservés
					Les VIP ont le privilège d'y accéder
							prisel.fr/boutique
	--------------------------------------------------------------------
]] -- Message that will show up for the person that couldn't join when the server is full and "KickTooMany" is off


PRS.KickFunction = function(Ply)

end -- Function that will be run on a player before they get kicked, can be used for giving the person points as compensation

PRS.ExtraCheck = function(SteamID, PlayerName)

end -- Function that you can use to add different ways of reserved slot access, for example if a user has a specific PData value. return true inside it if the person should be let in the reserved slots

--[[ Example for PRS.ExtraCheck
	PRS.ExtraCheck = function(SteamID, PlayerName)
		return util.GetPData(SteamID, "PRSReserverSlot", "0") == "1"
	end
]]-- So if you want a person to have reserved slots, you set their PData ("PRSReserverSlot") to "1" and to disable it just remove it or set to anything else. To set someone to have reserved slot privilege use Ply:SetPData("PRSReserverSlot", "1")

--[[ Example for PRS.ExtraCheck
	PRS.ExtraCheck = function(SteamID, PlayerName)
		if string.find(PlayerName, "special_string_here", 1, true) then
			return true
		end
	end
]]-- Example to use if specific text in players name gives them reserved slot




local function DebugLog(...)
	local text = os.time() .. ": "
	for n, j in pairs({...}) do
		text = text .. " | " .. j
	end
	file.Append("prsdebug.txt", text .. "\n")
end




--[[ Do NOT edit anything further than this, unless you know what you are doing! ]]--


PRS.Initialized = false
PRS.SGSteamIDs = {}
PRS.SAMSteamIDs = {}
PRS.NormalSlotsNum = 999
PRS.NoBotPlayerNum = 0

if RealTime() < 30 then
	PRS.OnlinePlayerNum = 0
	DebugLog("FIRST START", RealTime() )
else
	PRS.OnlinePlayerNum = tonumber(util.GetPData("STEAM_0:1:117060447", "ProperReservedSlotsPlayers", 0) )
	PRS.NoBotPlayerNum = PRS.OnlinePlayerNum
	DebugLog("REPEATED START", RealTime(), PRS.OnlinePlayerNum, PRS.NoBotPlayerNum)
end



hook.Add("PostGamemodeLoaded","ProperReservedSlotsPostGMHook", function()
	if PRS.Enabled then
		hook.Add("CheckPassword", "ProperReservedSlotsCheckPasswordHook", function(Steam64, IP, ServerPass, ClientPass, PlayerName)
			local SteamID = util.SteamIDFrom64(Steam64)
			DebugLog("CheckPassword", SteamID)

			if ServerPass != nil && ServerPass != "" && ServerPass != ClientPass then
				if PRS.IsReservedID(SteamID, PlayerName) && PRS.LetReservedPastPass then
					return true
				end
			end

			if PRS.OnlinePlayerNum >= game.MaxPlayers() - (PRS.AlwaysOpenSlot and 1 or 0) then
				if PRS.IsReservedID(SteamID, PlayerName) then
					if PRS.KickTooMany then
						local TimePlayer = nil
						local Time = 9999999
						if !PRS.KickLowestTime then
							Time = 0
						end

						for n, j in ipairs(player.GetAll() ) do
							local CurPlyTime = j:TimeConnected()
							if !PRS.IsReservedPly(j) && ( (Time > CurPlyTime && PRS.KickLowestTime) || (Time < CurPlyTime && !PRS.KickLowestTime) )  then
								Time = CurPlyTime
								TimePlayer = j
							end
						end

						if TimePlayer != nil then
							local FRun = PRS.KickFunction or function() MsgC(Color(255, 0, 0), "[PRS] Missing config PRS.KickFunction!\n") end
							FRun(TimePlayer)
							TimePlayer:Kick(PRS.KickMsg)
						else
							return false, PRS.NoSlotsToFreeMsg
						end
					else
						return false, PRS.FullServerMsg
					end
				else
					return false, PRS.FullServerMsg
				end
			elseif PRS.OnlinePlayerNum >= PRS.NormalSlotsNum then
				if !PRS.IsReservedID(SteamID) then
					return false, PRS.BlockMsg
				end
			end
		end)

		PRS.Initialize()
	end
end)

function PRS.IsReservedID(SteamID, PlayerName)
	if table.HasValue(PRS.ReservedSteamIDs, SteamID) then
		return true
	end

	if PRS.ExtraCheck then
		if PRS.ExtraCheck(SteamID, PlayerName) then
			return true
		end
	end

	if ULib then
		local User = ULib.ucl.users[SteamID]
		if User then
			if table.HasValue(PRS.ReservedGroups, User.group) then
				return true
			end
		end
	elseif evolve then
		for n, j in pairs(evolve.PlayerInfo) do
			if j.SteamID == SteamID then
				if table.HasValue(PRS.ReservedGroups, j.Rank) then
					return true
				else
					return false
				end
			end
		end
	elseif moderator then
		local Rank = moderator.users[SteamID]
		if table.HasValue(PRS.ReservedGroups, Rank) then
			return true
		end
	elseif ASS_VERSION then
		local T = ASS_GetRankingTable()
		if T then
			local User = T[SteamID]
			if User then
				if table.HasValue(PRS.ReservedGroups, tonumber(User.Rank) ) then
					return true
				end
			end
		end
	elseif serverguard then
		if table.HasValue(PRS.SGSteamIDs, SteamID) then
			return true
		end
	elseif sam then
		if table.HasValue(PRS.SAMSteamIDs, SteamID) then
			return true
		end
	else
		Msg("\n[Proper Reserved Slots] Couldn't find a supported admin mod, can't tell if player has reserved slot!\n")
	end
	return false
end

function PRS.IsReservedPly(Ply)
	if PRS.ExtraCheck then
		if PRS.ExtraCheck(Ply:SteamID(), (isfunction(Ply.SteamName) and Ply:SteamName() or Ply:Nick() ) ) then
			return true
		end
	end

	local Rank = ""
	if ULib then
		Rank = Ply:GetUserGroup() or ""
	elseif evolve then
		Rank = Ply:GetProperty("Rank", "")
	elseif moderator then
		Rank = moderator.GetGroup(Ply) or ""
	elseif ASS_VERSION then
		Rank = Ply:GetLevel() or ""
	elseif serverguard then
		Rank = serverguard.player:GetRank(Ply) or ""
	elseif sam then
		Rank = Ply:GetUserGroup() or ""
	else
		MsgC(Color(255, 0, 0), "\n[Proper Reserved Slots] Couldn't find a supported admin mod to check what player to kick for a reserved slot!\n")
		return false
	end

	if table.HasValue(PRS.ReservedGroups, Rank) then
		return true
	else
		return false
	end
end

function PRS.Initialize()
	PRS.NormalSlotsNum = game.MaxPlayers() - PRS.SlotNum - (PRS.AlwaysOpenSlot and 1 or 0)
	if PRS.HiddenReserved then
		game.ConsoleCommand("sv_visiblemaxplayers " .. PRS.NormalSlotsNum .. "\n")
	end
	PRS.Initialized = true
	DebugLog("PRSInitialized", PRS.NormalSlotsNum, PRS.SlotNum, game.MaxPlayers(), PRS.AlwaysOpenSlot and 1 or 0)
end

hook.Add("serverguard.mysql.OnConnected", "ProperReservedSlotsServerGuardRanks", function()
	local QueryObj = serverguard.mysql:Select("serverguard_users")
		QueryObj:Select("steam_id")
		QueryObj:Select("rank")
		QueryObj:Callback(function(Data)
			if istable(Data) then
				for n, j in pairs(Data) do
					if table.HasValue(PRS.ReservedGroups, j.rank) then
						table.insert(PRS.SGSteamIDs, j.steam_id)
					end
				end
			end
		end)
		QueryObj:Execute()
end)

hook.Add("SAM.DatabaseLoaded", "ProperReservedSlotsSAMRanks", function()
	local Query = [[
		SELECT
			steamid,
			rank
		FROM
			`sam_players`]]
	sam.SQL.Query(Query, function(Data)
		if istable(Data) then
			for n, j in pairs(Data) do
				if table.HasValue(PRS.ReservedGroups, j.rank) then
					table.insert(PRS.SAMSteamIDs, j.steamid)
				end
			end
		end
	end, false)
end)

local function updateSAMRank(steamid, rank, old_rank) 
	if table.HasValue(PRS.ReservedGroups, rank) then
		if !table.HasValue(PRS.SAMSteamIDs, steamid) then
			table.insert(PRS.SAMSteamIDs, steamid)
		end
	else
		if table.HasValue(PRS.SAMSteamIDs, steamid) then
			table.RemoveByValue(PRS.SAMSteamIDs, steamid)
		end
	end
end

hook.Add("SAM.ChangedSteamIDRank", "ProperReservedSlotsSAMRanksChange", function(steamid, rank, old_rank)
	updateSAMRank(steamid, rank, old_rank)
end)

hook.Add("SAM.ChangedPlayerRank", "ProperReservedSlotsSAMRanksChange2", function(ply, rank, old_rank)
	updateSAMRank(ply:SteamID(), rank, old_rank) 
end)


gameevent.Listen("player_disconnect")
hook.Add("player_disconnect","ProperReservedSlotsDisconnectHook", function(data)
	PRS.OnlinePlayerNum = PRS.OnlinePlayerNum - 1
	if !data.bot then
		PRS.NoBotPlayerNum = PRS.NoBotPlayerNum - 1
	end
	DebugLog("player_disconnect", data.networkid, data.bot, data.reason, PRS.OnlinePlayerNum, PRS.NoBotPlayerNum, #player.GetAll(), #player.GetHumans() )
end)

gameevent.Listen("player_connect")
hook.Add("player_connect","ProperReservedSlotsConnectHook244468995", function(data)
	PRS.OnlinePlayerNum = PRS.OnlinePlayerNum + 1
	if !data.bot then
		PRS.NoBotPlayerNum = PRS.NoBotPlayerNum + 1
	end
	DebugLog("player_connect", data.networkid, data.bot, PRS.OnlinePlayerNum, PRS.NoBotPlayerNum, #player.GetAll(), #player.GetHumans() )
end)

hook.Add("PlayerDisconnected","ProperReservedSlotsPlayerDisconnected", function(Ply)
    DebugLog("PlayerDisconnect", Ply:SteamID(), PRS.OnlinePlayerNum, PRS.NoBotPlayerNum, #player.GetAll(), #player.GetHumans() )
end)

hook.Add("PlayerConnect","ProperReservedSlotsPlayerConnect", function(Name, IP)
    DebugLog("PlayerConnect", Name, PRS.OnlinePlayerNum, PRS.NoBotPlayerNum, #player.GetAll(), #player.GetHumans() )
end)

hook.Add("ShutDown", "ProperReservedSlotsSavePlayers", function()
	util.SetPData("STEAM_1:0:85116110", "ProperReservedSlotsPlayers", PRS.NoBotPlayerNum)
	DebugLog("ShutDown", PRS.OnlinePlayerNum, PRS.NoBotPlayerNum, #player.GetAll(), #player.GetHumans() )
end)

if !file.Exists("prsdebug.txt", "DATA") then
	file.Write("prsdebug.txt", "Start\n")
end