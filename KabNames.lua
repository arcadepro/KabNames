local f 			= CreateFrame("Frame")
local events 		= {}
local _debug		= false

local function debug(msg)
	if (_debug) then
		ChatFrame1:AddMessage(msg)
	end
end

local function checkStatus()
	local isInstance, instanceType = IsInInstance()
	local inCombat = InCombatLockdown()

	if not inCombat then

		if isInstance then

			--Hostile and Quest NPCs
			SetCVar("UnitNameFriendlySpecialNPCName", "1")
			SetCVar("UnitNameHostleNPC", "1")
			SetCVar("UnitNameInteractiveNPC", "1")
			SetCVar("UnitNameNPC", "1")
			--SetCVar("ShowQuestUnitCircles", "1")

			SetCVar("nameplateShowAll", "1")

			if instanceType == "pvp" or instanceType == "arena" then
				SetCVar("UnitNameEnemyPlayerName", "1")
				debug ("KabNames: PVP Names")
			end

			debug ("KabNames: Hostile and Quest NPCs, All plates")

		else

			--Quest NPCs
			SetCVar("UnitNameFriendlySpecialNPCName", "1")
			SetCVar("UnitNameHostleNPC", "1")
			SetCVar("UnitNameInteractiveNPC", "0")
			SetCVar("UnitNameNPC", "0")
			--SetCVar("ShowQuestUnitCircles", "1")
			SetCVar("UnitNameEnemyPlayerName", "0")

			SetCVar("nameplateShowAll", "0")

			debug ("KabNames: Quest NPCs, Plates only in combat")

		end
	end
end

function events:PLAYER_ENTERING_WORLD(...)
	checkStatus()
end

function events:ZONE_CHANGED_NEW_AREA(...)
	checkStatus()
end

f:SetScript("OnEvent", function(self, event, ...)
	events[event](self, ...)	-- call one of the functions above
end)

for k, v in pairs(events) do
	f:RegisterEvent(k)			-- Register all events for which handlers have been defined
end
