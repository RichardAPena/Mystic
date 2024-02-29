function PsionicFists_Equipped(item, character)

    if not Osi.IsWeapon(item) then
        return
    end

    local weaponProperties = Ext.Entity.Get(item).Weapon.WeaponProperties
    local isTwoHanded = (weaponProperties & 1024) > 0
    local isHeavy = (weaponProperties & 8) > 0
    local isProficient = Osi.IsProficientWith(character, item)

    if Osi.HasPassive(character, "Passive_PsionicFists")
    and not isTwoHanded
    and not isHeavy
    and isProficient
    then
        Osi.ApplyStatus(item, "MYSTIC_PSIONIC_FISTS", -1, 1, character)
    end

end

function PsionicFists_Unequipped(item, character)

    Osi.RemoveStatus(item, "MYSTIC_PSIONIC_FISTS")

end

-- function PsionicFists_TemplateEquipped(item, character)

-- end

-- function PsionicFists_TemplateUnequipped(item, character)

-- end

Ext.Osiris.RegisterListener("Equipped", 2, "after", PsionicFists_Equipped)
Ext.Osiris.RegisterListener("Unequipped", 2, "before", PsionicFists_Unequipped)
-- Ext.Osiris.RegisterListener("TemplateEquipped", 2, "after", PsionicFists_TemplateEquipped)
-- Ext.Osiris.RegisterListener("TemplateUnequipped", 2, "after", PsionicFists_TemplateUnequipped)