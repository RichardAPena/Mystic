






Ext.Require("Server/PsychicDouble/PsychicDouble_Despawn.lua")
Ext.Require("Server/PsychicDouble/PsychicDouble_ID.lua")
Ext.Require("Server/PsychicDouble/PsychicDouble_Init.lua")
Ext.Require("Server/PsychicDouble/PsychicDouble_OrderMove.lua")
Ext.Require("Server/PsychicDouble/PsychicDouble_Positioning.lua")
Ext.Require("Server/PsychicDouble/PsychicDouble_Swap.lua")
Ext.Require("Server/PsychicDouble/PsychicDouble_Util.lua")

-- Functions --

local function PsychicDouble_StatusApplied_MYSTIC_PSYCHIC_DOUBLE_INIT(character)
	local owner = Osi.CharacterGetOwner(character)
	PsychicDouble_Init_1(owner, character)
	Osi.ApplyStatus(character, "MYSTIC_PSYCHIC_DOUBLE_INIT_2", 0, 1)
	PsychicDouble_TryAssignMysticAndCloneID(owner, character)
end


local function PsychicDouble_StatusRemoved_MYSTIC_PSYCHIC_DOUBLE_INIT_2(object, _, _, _)
	local owner, clone = PsychicDouble_GetMysticAndActiveClone(object)
	PsychicDouble_Init_2(owner, clone)
	Osi.ApplyStatus(object, "MYSTIC_PSYCHIC_DOUBLE_INIT_3", 0, 1)
end

local function PsychicDouble_StatusRemoved_MYSTIC_PSYCHIC_DOUBLE_INIT_3(object, _, _, _)
	Osi.RemoveStatus(object, "MYSTIC_PSYCHIC_DOUBLE_INIT")
end

local function PsychicDouble_StatusApplied_MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_FORWARD_2(object, _, _, _)
	local owner, clone = PsychicDouble_GetMysticAndActiveClone(object)
	if owner then
		PsychicDouble_Swap_Forward_Attack_2(owner, clone)
	end
end

local function PsychicDouble_StatusApplied_MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_BACK_2(object, _, _, _)
	local owner, clone = PsychicDouble_GetMysticAndActiveClone(object)
	if owner then
		PsychicDouble_Swap_Back_Attack_2(owner, clone)
	end
end

local function PsychicDouble_StatusApplied_MYSTIC_PSYCHIC_DOUBLE_KILL_CLONE(object, _, _, _)
	local owner, clone = PsychicDouble_GetMysticAndActiveClone(object)
	if clone then
		PsychicDouble_KillClone(owner, clone)
	end
end

local function PsychicDouble_StatusRemoved_MYSTIC_PSYCHIC_DOUBLE_ACTIONS(object, _, _, _)
	print("MysticExpansion: MYSTIC_PSYCHIC_DOUBLE_ACTIONS has been removed!")
	local owner, clone = PsychicDouble_GetMysticAndActiveClone(object)
	if clone then
		PsychicDouble_KillClone(owner, clone)
	end
end

local function PsychicDouble_CastSpell_Shout_Mystic_PsychicDouble_Dismiss_Self(caster, _, _, _, _)
	print("PsychicDouble: Dismissing clone: " .. caster)

	local owner, clone = PsychicDouble_GetMysticAndActiveClone(caster)
	if clone then
		PsychicDouble_KillClone(owner, clone)
	end
end

-- Tables --

local PsychicDouble_StatusApplied_Table = {
	MYSTIC_PSYCHIC_DOUBLE_INIT = PsychicDouble_StatusApplied_MYSTIC_PSYCHIC_DOUBLE_INIT,
	MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_TIMEOUT = PsychicDouble_StatusApplied_MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_TIMEOUT,
	MYSTIC_PSYCHIC_DOUBLE_KILL_CLONE = PsychicDouble_StatusApplied_MYSTIC_PSYCHIC_DOUBLE_KILL_CLONE,
	MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_FORWARD_2 = PsychicDouble_StatusApplied_MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_FORWARD_2,
	MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_BACK_2 = PsychicDouble_StatusApplied_MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_BACK_2,
	MYSTIC_PSYCHIC_DOUBLE_REQUEST_DELETE = PsychicDouble_Clone_RequestDelete,
}

local PsychicDouble_StatusRemoved_Table = {
	MYSTIC_PSYCHIC_DOUBLE_INIT_2 = PsychicDouble_StatusRemoved_MYSTIC_PSYCHIC_DOUBLE_INIT_2,
	MYSTIC_PSYCHIC_DOUBLE_INIT_3 = PsychicDouble_StatusRemoved_MYSTIC_PSYCHIC_DOUBLE_INIT_3,
	MYSTIC_PSYCHIC_DOUBLE_ACTIONS = PsychicDouble_StatusRemoved_MYSTIC_PSYCHIC_DOUBLE_ACTIONS,
}

local PsychicDouble_CastSpell_Table = {
	Shout_Mystic_PsychicDouble_Swap = PsychicDouble_Swap_Default,
	Shout_Mystic_PsychicDouble_AttackSwap = PsychicDouble_AttackSwap,
	Shout_Mystic_PsychicDouble_Dismiss_Self = PsychicDouble_CastSpell_Shout_Mystic_PsychicDouble_Dismiss_Self,
}

local PsychicDouble_UsingSpellAtPosition_Table = {
	Target_Mystic_PsychicDouble_OrderMove = PsychicDouble_UsingSpellAtPosition_Target_Mystic_PsychicDouble_OrderMove,
}

-- Handlers --


local function PsychicDouble_TemplateAddedTo(_, item, character, addType)
	-- print("MysticExpansion: TemplateAddedTo: _, item: " .. item .. " character: " .. character .. " addType: " .. addType)

end

local function PsychicDouble_CharacterJoinedParty(character)
	print("MysticExpansion: CharacterJoinedParty: " .. character)

	local owner, clone = PsychicDouble_GetMysticAndActiveClone(character)
	if owner then
		PsychicDouble_TryAssignMysticAndCloneID(owner, clone)
	end
end

local function PsychicDouble_CharacterLeftParty(character)
	print("MysticExpansion: CharacterLeftParty: " .. character)

	if PsychicDouble_IsClone(character) then
		local owner = PsychicDouble_GetActiveMysticForClone(character)
		Osi.RemoveStatus(owner, "MYSTIC_PSYCHIC_DOUBLE_ACTIONS")
		PsychicDouble_Clone_Cleanup(character)
	else
		PsychicDouble_RemoveMysticIDStatus(character)
	end
end

local function PsychicDouble_StatusApplied(object, status, causee, storyActionID)
    -- print("MysticExpansion: StatusApplied: object: " .. object .. " status: " .. status .. " causee: " .. causee .. " storyActionID:" .. storyActionID)

    local handler = PsychicDouble_StatusApplied_Table[status]
	if handler then
		handler(object, status, causee, storyActionID)
	end
end

local function PsychicDouble_StatusRemoved(object, status, causee, applyStoryActionID)
    -- print("MysticExpansion: StatusRemoved: object: " .. object .. " status: " .. status .. " causee: " .. causee .. " applyStoryActionID: " .. applyStoryActionID)

	local handler = PsychicDouble_StatusRemoved_Table[status]
	if handler then
		handler(object, status, causee, applyStoryActionID)
	end
end

local function PsychicDouble_EnteredCombat(object, combatGuid)
	-- print("MysticExpansion: EnteredCombat: object: " .. object .. " combatGuid: " .. combatGuid)
	if PsychicDouble_IsClone(object) then
		Osi.ApplyStatus(object, "MYSTIC_PSYCHIC_DOUBLE_CLONE_IMMOBILIZE", -1, 0, object) -- MYSTIC_PSYCHIC_DOUBLE_CLONE_IMMOBILIZE
	end
end

local function PsychicDouble_LeftCombat(object, combatGuid)
   	-- print("MysticExpansion: LeftCombat: object: " .. object .. " combatGuid: " .. combatGuid)
	if PsychicDouble_IsClone(object) then
		Osi.RemoveStatus(object, "MYSTIC_PSYCHIC_DOUBLE_CLONE_IMMOBILIZE") -- MYSTIC_PSYCHIC_DOUBLE_CLONE_IMMOBILIZE
		-- Osi.RemoveStatus(clone, 'MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_SWAPPING')
	end
end

local function PsychicDouble_UsingSpellAtPosition(caster, x, y, z, spell, spellType, spellElement, storyActionID)
	print("MysticExpansion: UsingSpellAtPosition: caster: " .. caster .. " x: " .. x .. " y: " .. y .. " z: " .. z .. " spell: " .. spell .. " spellType: " .. spellType .. " spellElement: " .. spellElement .. " storyActionID: " .. storyActionID)

	local handler = PsychicDouble_UsingSpellAtPosition_Table[spell]
	if handler then
		handler(caster, x, y, z, spell, spellType, spellElement, storyActionID)
	end
end

local function PsychicDouble_CastSpell(caster, spell, spellType, spellElement, storyActionID)
    -- print("MysticExpansion: CastSpell: caster: " .. caster .. " spell: " .. spell .. " spellType: " .. spellType .. " spellElement: " .. spellElement .. " storyActionID: " .. storyActionID)

	local handler = PsychicDouble_CastSpell_Table[spell]
	if handler then
		handler(caster, spell, spellType, spellElement, storyActionID)
	end
end

local PsychicDouble_DamageTypeImmunities = { Poison = true, Psychic = true }

local function PsychicDouble_AttackedBy(defender, attackerOwner, attacker2, damageType, damageAmount, damageCause, storyActionID)
	print("MysticExpansion: AttackedBy: defender: " .. defender .. " attackerOwner: " .. attackerOwner .. " attacker2: " .. attacker2 .. " damageType: " .. damageType .. " damageAmount: " .. damageAmount .. " damageCause: " .. damageCause .. " storyActionID: " .. storyActionID)

	if damageType ~= '' and PsychicDouble_IsClone(defender) then
		local owner, clone = PsychicDouble_GetMysticAndActiveClone(defender)
		if clone then
			print("MysticExpansion: Clone took " .. damageType .. " damage")
			if PsychicDouble_DamageTypeImmunities[damageType] then
				return
			end

			-- ignore damage during attack swap
			if Osi.HasActiveStatus(clone, "MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_CLONE") == 1
				or Osi.HasActiveStatus(clone, "MYSTIC_PSYCHIC_DOUBLE_ATTACKSWAP_SWAPPING") == 1 then
				return
			end

			PsychicDouble_KillCloneFromDamage(owner, clone)
		end
	end
end

local function PsychicDouble_LevelLoaded(newLevel)
    -- print("MysticExpansion: LevelLoaded: " .. newLevel)
    PsychicDouble_LastLoadedLevel = newLevel
end

-- Listeners --

Ext.Osiris.RegisterListener("TemplateAddedTo", 4, "after", PsychicDouble_TemplateAddedTo)
Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", PsychicDouble_CharacterJoinedParty)
Ext.Osiris.RegisterListener("CharacterLeftParty", 1, "after", PsychicDouble_CharacterLeftParty)
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", PsychicDouble_StatusApplied)
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", PsychicDouble_StatusRemoved)
Ext.Osiris.RegisterListener("EnteredCombat", 2, "after", PsychicDouble_EnteredCombat)
Ext.Osiris.RegisterListener("LeftCombat", 2, "after", PsychicDouble_LeftCombat)
Ext.Osiris.RegisterListener("UsingSpellAtPosition", 8, "after", PsychicDouble_UsingSpellAtPosition)
Ext.Osiris.RegisterListener("CastSpell", 5, "before", PsychicDouble_CastSpell)
Ext.Osiris.RegisterListener("AttackedBy", 7, "after", PsychicDouble_AttackedBy)
Ext.Osiris.RegisterListener("LevelLoaded", 1, "after", PsychicDouble_LevelLoaded)