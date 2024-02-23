-- TODO: Make this work when you have:
-- => MYSTIC ARSENAL (THROWN WEAPON FIGHTING)
-- => WAR ADEPT
-- => HAVE A THROWN WEAPON
-- Also not sure, but will GetHostCharacter always work?? Especially in multiplayer




local function OnThrow(carriedObject, carriedObjectTemplate, carrier, storyActionID, pickupPosX, pickupPosY, pickupPosZ)
    local thrown = carriedObject
  
    -- if Ext.Entity.Get(thrown).Weapon.WeaponProperties & 4 then
    if Ext.Entity.Get(thrown).Weapon.WeaponProperties & 4 then
      
        local str = Osi.GetAbility(carrier, "Strength")
        local int = Osi.GetAbility(carrier, "Intelligence")

        local mystic_arsenal = true
        local war_adept = true

        if int > str and mystic_arsenal and war_adept then
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

Ext.Osiris.RegisterListener("OnStartCarrying", 7, "before", OnThrow)
Ext.Osiris.RegisterListener("CastSpellFailed", 5, "before", IntelligenceThrow_CastSpellFailed)
Ext.Osiris.RegisterListener("OnThrown", 7, "before", IntelligenceThrow_OnThrown)