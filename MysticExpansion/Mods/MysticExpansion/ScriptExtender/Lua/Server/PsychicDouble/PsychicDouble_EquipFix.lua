
local function PsychicDouble_EquipFix_IsNullUUID(uuid)
	return (uuid == nil) or uuid:find('00000000[-]0000[-]0000[-]0000[-]000000000000$')
end

local PsychicDouble_EquipFix_DyedSlots = {
	[0] = 1,
	[1] = 1,
	[2] = 1,
	[9] = 1,
	[10] = 1,

	[17] = 2,
	[18] = 2,

	[8] = 3,
}

function PsychicDouble_EquipFix_TemplateAddedTo_Internal(item, character, equipStatus, unequipHelmet, unequipInstrument)
	-- print("EquipFix: TemplateAddedTo_Internal: " .. item .. ", " .. character .. ", " .. (equipStatus or 'nil') .. ", " .. (unequipHelmet and 'true' or 'false') .. ", " .. (unequipInstrument and 'true' or 'false'))

	local equipSlot = Osi.GetEquipmentSlotForItem(item)
	local isShieldOrWeapon = equipSlot >= 3 and equipSlot <= 6
	local isMelee = equipSlot >= 3 and equipSlot <= 4
	local isHelmet = equipSlot == 0
	local isInstrument = equipSlot == 16

	local equip = not isShieldOrWeapon
	if equip and ((isHelmet and unequipHelmet) or (isInstrument and unequipInstrument)) then
		equip = false
	end

	if isHelmet then
		Osi.SetVarUUID(character, "PsychicDouble_Helmet", item)
	end

	if PsychicDouble_EquipFix_DyedSlots[equipSlot] then
		local owner = Osi.CharacterGetOwner(character)
		if owner then
			local slotEnum = Ext.Enums.StatsItemSlot[equipSlot]
			local ownerItem = Osi.GetEquippedItem(owner, slotEnum.Label)
			if ownerItem then
				local ownerItem_ = Ext.Entity.Get(ownerItem)

				if ownerItem_ and ownerItem_.ItemDye then
					local item_ = Ext.Entity.Get(item)

					if item_.ItemDye == nil then
						item_:CreateComponent("ItemDye")
					end

					item_.ItemDye.Color = ownerItem_.ItemDye.Color
					item_:Replicate("ItemDye")
				end
			end
		end
	end

	if equip then
		Osi.Equip(character, item)
	else
		Osi.Unequip(character, item)

		if isMelee then
			local melee1 = Osi.GetVarUUID(character, "PsychicDouble_Melee_1")
			if PsychicDouble_EquipFix_IsNullUUID(melee1) then
				Osi.SetVarUUID(character, "PsychicDouble_Melee_1", item)
			else
				Osi.SetVarUUID(character, "PsychicDouble_Melee_2", item)
			end
			if equipStatus then
				Osi.ApplyStatus(character, equipStatus, 0)
			end
		end
	end
end

function PsychicDouble_EquipFix_SetEquippedSavedMelee(character, equip)
	-- print("EquipFix: SetEquippedSavedMelee: " .. character .. ", " .. (equip and 'true' or 'false'))

	local melee1 = Osi.GetVarUUID(character, "PsychicDouble_Melee_1")
	local melee2 = Osi.GetVarUUID(character, "PsychicDouble_Melee_2")

	local equipped = false
	if not PsychicDouble_EquipFix_IsNullUUID(melee1) then
		if equip then
			Osi.Equip(character, melee1)
		else
			Osi.Unequip(character, melee1)
		end
		equipped = true
	end
	if not PsychicDouble_EquipFix_IsNullUUID(melee2) then
		if equip then
			Osi.Equip(character, melee2)
		else
			Osi.Unequip(character, melee2)
		end
		equipped = true
	end

	if Osi.IsTorch(melee1) == 1 or Osi.IsTorch(melee2) == 1 then
		Osi.PushUnsheathedState(character, 1)
	end

	return equipped
end

function PsychicDouble_EquipFix_SetEquippedSavedHelmet(character, equip)
	-- print("EquipFix: SetEquippedSavedHelmet: " .. character .. ", " .. (equip and 'true' or 'false'))

	local helmet = Osi.GetVarUUID(character, "PsychicDouble_Helmet")

	local equipped = false
	if not PsychicDouble_EquipFix_IsNullUUID(helmet) then
		if equip then
			Osi.Equip(character, helmet)
		else
			Osi.Unequip(character, helmet)
		end
		equipped = true
	end
	return equipped
end
