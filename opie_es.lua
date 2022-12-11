local R = OPie.CustomRings
if not (R and R.AddDefaultRing) then return end

local OpieEquipmentSets = {}

OpieEquipmentSets.debugPrint = false

local function OpieEquipmentSets_RebuildRing()
	local ring = {
		name="Equipment Sets", hotkey="ALT-CTRL-O"
	}

	local ids = C_EquipmentSet.GetEquipmentSetIDs()

	for _, id in ipairs(ids)
	do
		local name = C_EquipmentSet.GetEquipmentSetInfo(id)

		if OpieEquipmentSets.debugPrint or false then
			print("Equipment Set: ", name, "(", id, ")")
		end

		table.insert(ring, {"equipmentset", name})
	end

	R:SetExternalRing("EquipmentSets", ring)
end

OpieEquipmentSets.eventHandler = CreateFrame("Frame")

OpieEquipmentSets.eventHandler:RegisterEvent("PLAYER_ENTERING_WORLD")
OpieEquipmentSets.eventHandler:RegisterEvent("EQUIPMENT_SETS_CHANGED")

OpieEquipmentSets.eventHandler:SetScript("OnEvent", function(self, event, ...)
	OpieEquipmentSets_RebuildRing()
end)
