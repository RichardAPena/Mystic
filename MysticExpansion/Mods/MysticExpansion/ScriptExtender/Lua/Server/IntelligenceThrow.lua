-- TODO: Make this work when you have:
-- => MYSTIC ARSENAL (THROWN WEAPON FIGHTING)
-- => WAR ADEPT
-- => HAVE A THROWN WEAPON
-- Also not sure, but will GetHostCharacter always work?? Especially in multiplayer
local function OnThrow(...)
    local args = {...}
    local thrown = args[1]
  
    -- if Ext.Entity.Get(thrown).Weapon.WeaponProperties & 4 then
    if Ext.Entity.Get(thrown).Weapon.WeaponProperties then
      
        local str = Osi.GetAbility(GetHostCharacter(), "Strength")
        local int = Osi.GetAbility(GetHostCharacter(), "Intelligence")

        local mystic_arsenal = true
        local war_adept = true
  
        if int > str and mystic_arsenal and war_adept then
          local diff = (int - str) * 6
          Osi.RemoveStatus(Osi.GetHostCharacter(), "INTELLIGENCE_THROW_BUFF")
          Osi.ApplyStatus(Osi.GetHostCharacter(), "INTELLIGENCE_THROW_BUFF", diff, 0)
        end
      
    end
  end
  
  Ext.Osiris.RegisterListener("OnStartCarrying", 7, "before", OnThrow)
  
  Ext.Osiris.RegisterListener("CastSpellFailed", 5, "before", function(caster, spell, spellType, spellElement, storyActionID)
      if spell == "Throw_Throw" then
          Osi.RemoveStatus(Osi.GetHostCharacter(), "INTELLIGENCE_THROW_BUFF")
      end
  end)
  
  Ext.Osiris.RegisterListener("OnThrown", 7, "before", function(vbl)
      Osi.RemoveStatus(Osi.GetHostCharacter(), "INTELLIGENCE_THROW_BUFF")
  end)