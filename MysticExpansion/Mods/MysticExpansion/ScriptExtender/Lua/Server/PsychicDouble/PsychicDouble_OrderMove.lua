function PsychicDouble_UsingSpellAtPosition_Target_Mystic_PsychicDouble_OrderMove(caster, x, y, z, _, _, _, _)
	local owner, clone = PsychicDouble_GetMysticAndActiveClone(caster)
	if clone then
		-- print("PsychicDouble: Requested clone teleport: " .. clone)
        Osi.UseSpellAtPosition(clone, "Target_Mystic_PsychicDouble_Move_Clone", x, y, z)
	end
end