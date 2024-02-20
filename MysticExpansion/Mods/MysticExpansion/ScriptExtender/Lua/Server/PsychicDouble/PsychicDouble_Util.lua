PsychicDouble_NullUUID_Short = "00000000-0000-0000-0000-000000000000"
PsychicDouble_NullUUID_Long = "NULL_00000000-0000-0000-0000-000000000000"
PsychicDouble_LastLoadedLevel = "<no level loaded>"

function PsychicDouble_ShortUUID(uuid)
	return (uuid and string.sub(uuid, -36)) or PsychicDouble_NullUUID_Short
end

function PsychicDouble_IsNullUUID(uuid)
    return (uuid == nil) or uuid:find('00000000[-]0000[-]0000[-]0000[-]000000000000$')
end

function PsychicDouble_IsSameUUID(uuid1, uuid2)
	return PsychicDouble_ShortUUID(uuid1) == PsychicDouble_ShortUUID(uuid2)
end

function PsychicDouble_IsClone(uuid)
    return uuid:find("^Mystic_PsychicDouble_Character")
end

function PsychicDouble_GetActiveMysticForClone(clone)
	if PsychicDouble_IsNullUUID(clone) then
		return nil
	end

	local owner = Osi.CharacterGetOwner(clone)
	if PsychicDouble_IsNullUUID(owner) then
		return nil
	end

	local clone2 = Osi.GetVarUUID(owner, "PsychicDouble_Clone")
	if PsychicDouble_ShortUUID(clone) == clone2 then
		return owner
	end
end

function PsychicDouble_GetActiveCloneForMystic(owner)
	if PsychicDouble_IsNullUUID(owner) then
		return nil
	end

	local clone = Osi.GetVarUUID(owner, "PsychicDouble_Clone")
	if PsychicDouble_IsNullUUID(clone) then
		return nil
	end

	local owner2 = Osi.CharacterGetOwner(clone)
	if PsychicDouble_ShortUUID(owner) == owner2 then
		return clone
	end
end

function PsychicDouble_GetMysticAndActiveClone(character)
	if PsychicDouble_IsNullUUID(character) then
		return nil, nil
	end

	if Osi.HasPassive(character, "Discipline_PsychicDistortion") == 1 then
		return character, PsychicDouble_GetActiveCloneForMystic(character)
	else
		local owner = PsychicDouble_GetActiveMysticForClone(character)
		if owner then
			return owner, character
		end
	end
	return nil, nil
end

function PsychicDouble_GetMysticIDStatusName(id)
	return "PsychicDouble_ID_" .. id .. "_MYSTIC"
end

function PsychicDouble_GetCloneIDStatusName(id)
	return "PsychicDouble_ID_" .. id .. "_CLONE"
end

function PsychicDouble_GetMysticID(owner)
	for id = 1, 4 do
		if Osi.HasActiveStatus(owner, PsychicDouble_GetMysticIDStatusName(id)) == 1 then
			return id
		end
	end
end