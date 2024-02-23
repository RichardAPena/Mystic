function PsychicDouble_Init_1(owner, clone)
	-- print("MysticExpansion: Double joined: " .. clone)
	-- print("MysticExpansion: Double owner: " .. owner)

	Osi.SetVarUUID(owner, "PsychicDouble_Clone", clone)

	Osi.CopyCharacterEquipment(clone, owner)
	Osi.SetArmourSet(clone, Osi.GetArmourSet(owner))

	PsychicDouble_Init_Boosts(owner, clone)

	local level = Osi.GetLevel(owner)
	if level >= 17 then
		Osi.ApplyStatus(clone, "MYSTIC_PSYCHIC_DOUBLE_PROFICIENCY_6", -1, 0, owner)
	elseif level >= 13 then
		Osi.ApplyStatus(clone, "MYSTIC_PSYCHIC_DOUBLE_PROFICIENCY_5", -1, 0, owner)
	elseif level >= 9 then
		Osi.ApplyStatus(clone, "MYSTIC_PSYCHIC_DOUBLE_PROFICIENCY_4", -1, 0, owner)
	elseif level >= 5 then
		Osi.ApplyStatus(clone, "MYSTIC_PSYCHIC_DOUBLE_PROFICIENCY_3", -1, 0, owner)
	else
		Osi.ApplyStatus(clone, "MYSTIC_PSYCHIC_DOUBLE_PROFICIENCY_2", -1, 0, owner)
	end
end

function PsychicDouble_Init_2(owner, clone)
	if clone then
		-- local isCustomAppearanceCharacter = true
		--	   Osi.IsTagged(owner, "730e82f3-c067-44a4-985b-0dfe079d4fea") == 1 -- GENERIC
		--	or Osi.IsTagged(owner, "cd611d7d-b67d-42b4-a75c-a0c6091ef8a2") == 1 -- DARK_URGE

		-- if isCustomAppearanceCharacter then
			-- Osi.Transform(clone, owner, "1c6b3ef3-057e-4e8f-9549-ab7afc0f4160") -- Mystic_ShapeshiftClone_KeepIcon
		-- else
			Osi.Transform(clone, owner, "dc1b0875-1d2b-4a1f-913a-bb648b7e8891") -- Mystic_ShapeshiftClone_ChangeIcon
		-- end
	end
end

function PsychicDouble_Init_Boosts(owner, clone)
	-- print("MysticExpansion: Copying ability scores: " .. clone .. " = " .. owner)

	local abilityNames = { 'Strength', 'Dexterity', 'Constitution', 'Intelligence', 'Wisdom', 'Charisma' }
	for _, abilityName in pairs(abilityNames) do
		local value = Osi.GetAbility(owner, abilityName)
		local boostStr = "AbilityOverrideMinimum(" .. abilityName .. "," .. value .. ")"
		Osi.AddBoosts(clone, boostStr, '', '')
	end
end