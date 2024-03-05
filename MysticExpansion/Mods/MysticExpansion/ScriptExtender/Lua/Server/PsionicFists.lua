function PsionicFists_Equipped(item, character)

    if item == nil then
        return
    end

    if character == nil then
        return
    end

    if not Osi.IsWeapon(item) then
        return
    end

    local weaponEntity = Ext.Entity.Get(item)

    if weaponEntity == nil then
        return
    end

    local weapon = weaponEntity.Weapon

    if weapon == nil then
        return
    end

    local weaponProperties = weapon.WeaponProperties
    local isTwoHanded = (weaponProperties & 1024) > 0
    local isHeavy = (weaponProperties & 8) > 0
    local isProficient = Osi.IsProficientWith(character, item) == 1
    local isMelee = (weaponProperties & 4096) > 0

    if Osi.HasPassive(character, "Passive_Mystic_PsionicFists") == 1
    and not isTwoHanded
    and not isHeavy
    and isProficient
    and isMelee
    then
        Osi.ApplyStatus(item, "MYSTIC_PSIONIC_FISTS", -1, 1, character)
    end

end

function PsionicFists_Unequipped(item, _)

    if item == nil then
        return
    end

    Osi.RemoveStatus(item, "MYSTIC_PSIONIC_FISTS")
end

Ext.Osiris.RegisterListener("Equipped", 2, "after", PsionicFists_Equipped)
Ext.Osiris.RegisterListener("Unequipped", 2, "before", PsionicFists_Unequipped)