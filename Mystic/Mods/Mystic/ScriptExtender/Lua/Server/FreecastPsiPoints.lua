function FreecastToggle(entity)

    -- _D(entity:GetAllComponents())

    local passiveName = entity.Passive.PassiveId
    local isFreecast = passiveName == "TAD_Freecast"

    if entity and isFreecast then

        local passiveOwnerEntity = entity.Passive.field_10
        local passiveToggledOn = entity.Passive.field_18 == 1
        local character = passiveOwnerEntity.Uuid.EntityUuid

        if passiveToggledOn then
            Osi.ApplyStatus(character, "MYSTIC_FREECAST", -1)
        else
            Osi.RemoveStatus(character, "MYSTIC_FREECAST")
        end

    end

end

Ext.Entity.Subscribe("Passive", FreecastToggle)


local function FreecastPsiPoints_CastSpell(caster, spell, _, _, _)
    
    -- _P("FreecastPsiPoints: CastSpell: caster: " .. caster .. " spell: " .. spell)

    local entity = Ext.Entity.Get(caster)
    local spellInfo = Ext.Stats.Get(spell)
 
    local isPsionicDiscipline = string.find(spellInfo.UseCosts, "PsiPointsResource") ~= nil
    local isFreecastActive = Osi.HasActiveStatus(caster, "MYSTIC_FREECAST") == 1

    if isPsionicDiscipline and entity and isFreecastActive then
        Osi.RemoveStatus(caster, "MYSTIC_FREECAST")
        for _, passive in pairs(entity.PassiveContainer.Passives) do
            if passive.Passive.PassiveId == "TAD_Freecast" then
                Osi.ApplyStatus(caster, "TAD_FREECAST", -1)
            end
        end
    end

end

Ext.Osiris.RegisterListener("CastSpell", 5, "after", FreecastPsiPoints_CastSpell)