function PsychicDouble_KillClone(owner, clone)
	if not clone or Osi.GetVarInteger(clone, "PsychicDouble_Killed") == 1 then
		return
	end

	print("MysticExpansion: Killing Clone (not from damage): " .. (owner or 'nil') .. ", " .. clone)

	Osi.SetVarInteger(clone, "PsychicDouble_Killed", 1)
	Osi.Die(clone)
end

function PsychicDouble_KillCloneFromDamage(owner, clone)
	if not clone or Osi.GetVarInteger(clone, "PsychicDouble_Killed") == 1 then
		return
	end

	print("MysticExpansion: Killing Clone from taking damage: " .. owner .. ", " .. clone)

	Osi.SetVarInteger(clone, "PsychicDouble_Killed", 1)
	Osi.Die(clone)
end

function PsychicDouble_Clone_Cleanup(clone)
	print("PsychicDouble_Clone_Cleanup: " .. clone)

	local shortCharacter = PsychicDouble_ShortUUID(clone)
	local owner = Osi.CharacterGetOwner(clone)
	local mostRecentClone = Osi.GetVarUUID(owner, "PsychicDouble_Clone")

	Osi.ApplyStatus(clone, "MYSTIC_PSYCHIC_DOUBLE_CLEANUP", -1, 1)

	if shortCharacter == mostRecentClone then
		print("MysticExpansion: Current Clone removed: " .. clone)

		Osi.SetVarUUID(owner, "PsychicDouble_Clone", PsychicDouble_NullUUID_Long)
	else
		print("MysticExpansion: Discarded Clone removed: " .. clone)
	end

	Osi.ApplyStatus(clone, "MYSTIC_PSYCHIC_DOUBLE_REQUEST_DELETE", -1, 1)
end

function PsychicDouble_Clone_RequestDelete(clone)
	print("MysticExpansion: Requesting delete: " .. clone)
	Osi.RequestDeleteTemporary(clone)
end