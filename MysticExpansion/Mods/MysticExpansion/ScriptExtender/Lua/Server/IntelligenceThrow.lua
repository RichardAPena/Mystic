local function IntelligenceThrow_OnStartCarrying(carriedObject, carriedObjectTemplate, carrier, storyActionID, pickupPosX, pickupPosY, pickupPosZ)
    local thrown = carriedObject
    if not thrown then
        return
    end

    local weaponEntity = Ext.Entity.Get(thrown)
    if not weaponEntity then
        return
    end

    local weapon = weaponEntity.Weapon
    if not weapon then
        return
    end

    if weapon.WeaponProperties & 512 then

        local str = Osi.GetAbility(carrier, "Strength")
        local int = Osi.GetAbility(carrier, "Intelligence")

        local hasMysticArsenal = Osi.HasActiveStatus(carrier, "MYSTIC_MYSTIC_ARSENAL_THROWN_WEAPON_FIGHTING") == 1
        local hasWarAdept = Osi.HasPassive(carrier, "Passive_Mystic_WarAdept") == 1

        if int > str and hasMysticArsenal and hasWarAdept then
          local diff = (int - str) * 6
          Osi.RemoveStatus(carrier, "INTELLIGENCE_THROW_BUFF")
          Osi.ApplyStatus(carrier, "INTELLIGENCE_THROW_BUFF", diff, 0)
        end

    end
end

local function IntelligenceThrow_CastSpellFailed(caster, spell, spellType, spellElement, storyActionID)
    if spell == "Throw_Throw" then
        Osi.RemoveStatus(caster, "INTELLIGENCE_THROW_BUFF")
    end
end

local function IntelligenceThrow_OnThrown(thrownObject, thrownObjectTemplate, thrower, storyActionID, throwPosX, throwPosY, throwPosZ)
    Osi.RemoveStatus(thrower, "INTELLIGENCE_THROW_BUFF")
end

-- local function IntelligenceThrow_StartedPreviewingSpell(caster, spell, isMostPowerful, hasMultipleLevels)
--     if (spell ~= "Throw_Throw") then
--         return
--     end

-- end

-- Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "after", IntelligenceThrow_StartedPreviewingSpell)
Ext.Osiris.RegisterListener("OnStartCarrying", 7, "before", IntelligenceThrow_OnStartCarrying)
Ext.Osiris.RegisterListener("CastSpellFailed", 5, "before", IntelligenceThrow_CastSpellFailed)
Ext.Osiris.RegisterListener("OnThrown", 7, "before", IntelligenceThrow_OnThrown)