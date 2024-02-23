
function PsychicDouble_DoSwap(owner, clone, isSwapBack)
	-- print("PsychicDouble_DoSwap: " .. (owner or 'nil') .. ", " .. (clone or 'nil') .. ", " .. (isSwapBack and 'true' or 'false'))

	local kx, ky, kz = Osi.GetPosition(owner)
	-- print("PsychicDouble_DoSwap: last loaded level: " .. (PsychicDouble_LastLoadedLevel or 'nil'))
	-- print("PsychicDouble_DoSwap: owner pos: " .. kx .. ", " .. ky .. ", " .. kz)

	local lastx, lasty, lastz = Osi.GetVarFloat3(owner, "PsychicDouble_LastPos")
	-- if lastz then
		-- print("PsychicDouble_DoSwap: last pos: " .. lastx .. ", " .. lasty .. ", " .. lastz)
	-- else
		-- print("PsychicDouble_DoSwap: last pos: nil")
	-- end

	Osi.SetVarFloat3(owner, "PsychicDouble_LastPos", kx, ky, kz)

	if clone then
		local ex, ey, ez = Osi.GetPosition(clone)
		-- print("PsychicDouble_DoSwap: clone pos: " .. ex .. ", " .. ey .. ", " .. ez)

		local searchRadius = 1000

		local tx, ty, tz = PsychicDouble_FindOutOfSightPosition(clone)
		if not tz then
			-- print("PsychicDouble_DoSwap: out of sight temp pos not found - retrying around clone")
			tx, ty, tz = PsychicDouble_FindValidPosition(ex, ey, ez, searchRadius, clone)
		end

		if tz then
			-- print("PsychicDouble_DoSwap: temp pos: " .. tx .. ", " .. ty .. ", " .. tz)

			-- print("PsychicDouble_DoSwap: Swapping places via triple teleport!")
			Osi.TeleportToPosition(clone, tx, ty, tz, "", 0, 0, 0, 0, 1)
			Osi.TeleportToPosition(owner, ex, ey, ez, "", 0, 0, 0, 0, 1)
			Osi.TeleportToPosition(clone, kx, ky, kz, "", 0, 0, 0, 0, 1)
		else
			-- print("PsychicDouble_DoSwap FAILED! No temp pos found")
			return false
		end
	elseif isSwapBack and lastz then
		-- print("PsychicDouble_DoSwap: Teleporting to last pos!")
		Osi.TeleportToPosition(owner, lastx, lasty, lastz, "", 0, 0, 0, 0, 1)
	else
		-- print("PsychicDouble_DoSwap FAILED! No clone or last pos available")
		return false
	end
	return true
end

function PsychicDouble_Swap_Default(caster)
	-- print("PsychicDouble_Swap_Default: " .. caster)

	local owner, clone = PsychicDouble_GetMysticAndActiveClone(caster)
	-- if not owner then
		-- print("MysticExpansion: 'caster' is not a Mystic or active clone!")
	-- end

	if clone then

		PsychicDouble_DoSwap(owner, clone, false)
	end
end

function PsychicDouble_Swap_Forward_Attack(owner, clone)
	-- print("PsychicDouble_Swap_Forward_Attack: " .. owner .. ", " .. (clone or 'nil'))

	if clone then
		Osi.ApplyStatus(owner, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_SWAPPING', 1)
		Osi.ApplyStatus(clone, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_SWAPPING', 1)

		Osi.ApplyStatus(owner, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_IMMUNITIES', 6)
		Osi.ApplyStatus(owner, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_FORWARD_2', 0)
	end
end

function PsychicDouble_Swap_Forward_Attack_2(owner, clone)
	-- print("PsychicDouble_Swap_Forward_Attack_2: " .. owner .. ", " .. (clone or 'nil'))

	if clone then
		PsychicDouble_DoSwap(owner, clone, false)

		Osi.ApplyStatus(owner, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_MYSTIC', 6)
		Osi.ApplyStatus(clone, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_CLONE', -1, 0, owner)

		Osi.RemoveStatus(clone, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_SWAPPING')
	end

	Osi.RemoveStatus(owner, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_SWAPPING')
end

function PsychicDouble_Swap_Back_Attack(owner, clone)
	-- print("PsychicDouble_Swap_Back_Attack: " .. owner .. ", " .. (clone or 'nil'))

	Osi.ApplyStatus(owner, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_SWAPPING', 1)

	if clone then
		Osi.ApplyStatus(clone, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_SWAPPING', 1)
	end

	Osi.ApplyStatus(owner, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_BACK_2', 0)
end

function PsychicDouble_Swap_Back_Attack_2(owner, clone)
	-- print("PsychicDouble_Swap_Back_Attack_2: " .. owner .. ", " .. (clone or 'nil'))

	PsychicDouble_DoSwap(owner, clone, true)

	Osi.RemoveStatus(owner, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_MYSTIC')

	if clone then
		Osi.RemoveStatus(clone, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_CLONE')
		Osi.RemoveStatus(clone, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_SWAPPING')
	end

	Osi.RemoveStatus(owner, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_SWAPPING')
end

function PsychicDouble_AttackSwap(caster)
	-- print("PsychicDouble_CastSpell_Shout_Mystic_PsychicDouble_AttackSwap: " .. caster)

	local owner, clone = PsychicDouble_GetMysticAndActiveClone(caster)
	-- print("MysticExpansion: owner: " .. (owner or 'nil'))
	-- print("MysticExpansion: clone: " .. (clone or 'nil'))

	if not owner then
		-- print("MysticExpansion: 'caster' is not a Mystic or active clone!")
		return false
	end

	local wasActive = Osi.HasActiveStatus(owner, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_MYSTIC')
	if wasActive == 1 then
		PsychicDouble_Swap_Back_Attack(owner, clone)
	else
		PsychicDouble_Swap_Forward_Attack(owner, clone)
	end
end

function PsychicDouble_StatusApplied_MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_TIMEOUT(object, _, _, _)
	local owner, clone = PsychicDouble_GetMysticAndActiveClone(object)
	if owner then
		PsychicDouble_Swap_Back_Attack(owner, clone)
	end
end
