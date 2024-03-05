-- local WeaponPropertyBitFlags = {
--     Light = 1,
--     Ammunition = 2,
--     Finesse = 4,
--     Heavy = 8,
--     Loading = 16,
--     Range = 32,
--     Reach = 64,
--     Lance = 128,
--     Net = 256,
--     Thrown = 512,
--     Twohanded = 1024,
--     Versatile = 2048,
--     Melee = 4096,
--     Dippable = 8192,
--     Torch = 16384,
--     NoDualWield = 32768,
--     Magical = 65536,
--     NeedDualWieldingBoost = 131072,
--     NotSheathable = 262144,
--     Unstowable = 524288,
--     AddToHotBar = 1048576
-- }

function WarAdept_RemoveEffect(character)

    if character == nil then
        return
    end

    local meleeMainHand = Osi.GetEquippedItem(character, "Melee Main Weapon")
    local meleeOffHand = Osi.GetEquippedItem(character, "Melee Offhand Weapon")
    local rangedMainHand = Osi.GetEquippedItem(character, "Ranged Main Weapon")
    local rangedOffHand = Osi.GetEquippedItem(character, "Ranged Offhand Weapon")

    local hasGreatWeaponStatus = Osi.HasActiveStatus(character, "MYSTIC_MYSTIC_ARSENAL_GREAT_WEAPON_FIGHTING") == 1
    local hasDuelingStatus = Osi.HasActiveStatus(character, "MYSTIC_MYSTIC_ARSENAL_DUELING") == 1
    local hasArcheryStatus = Osi.HasActiveStatus(character, "MYSTIC_MYSTIC_ARSENAL_ARCHERY") == 1
    local hasThrownWeaponStatus = Osi.HasActiveStatus(character, "MYSTIC_MYSTIC_ARSENAL_THROWN_WEAPON_FIGHTING") == 1

    if not hasGreatWeaponStatus
    and not hasGreatWeaponStatus
    and not hasArcheryStatus
    and not hasThrownWeaponStatus
    then
        if meleeMainHand then
            Osi.RemoveStatus(meleeMainHand, "MYSTIC_WAR_ADEPT")
        end
        if meleeOffHand then
            Osi.RemoveStatus(meleeOffHand, "MYSTIC_WAR_ADEPT")
        end
        if rangedMainHand then
            Osi.RemoveStatus(rangedMainHand, "MYSTIC_WAR_ADEPT")
        end
        if rangedOffHand then
            Osi.RemoveStatus(rangedOffHand, "MYSTIC_WAR_ADEPT")
        end
    end

    if hasGreatWeaponStatus then
        if meleeOffHand then
            Osi.RemoveStatus(meleeOffHand, "MYSTIC_WAR_ADEPT")
        end
        if rangedMainHand then
            Osi.RemoveStatus(rangedMainHand, "MYSTIC_WAR_ADEPT")
        end
        if rangedOffHand then
            Osi.RemoveStatus(rangedOffHand, "MYSTIC_WAR_ADEPT")
        end
    end

    if hasDuelingStatus then
        if meleeOffHand then
            Osi.RemoveStatus(meleeOffHand, "MYSTIC_WAR_ADEPT")
        end
        if rangedMainHand then
            Osi.RemoveStatus(rangedMainHand, "MYSTIC_WAR_ADEPT")
        end
        if rangedOffHand then
            Osi.RemoveStatus(rangedOffHand, "MYSTIC_WAR_ADEPT")
        end
    end

    if hasArcheryStatus then
        if meleeMainHand then
            Osi.RemoveStatus(meleeMainHand, "MYSTIC_WAR_ADEPT")
        end
        if meleeOffHand then
            Osi.RemoveStatus(meleeOffHand, "MYSTIC_WAR_ADEPT")
        end
    end

    if hasThrownWeaponStatus then
        if rangedMainHand then
            Osi.RemoveStatus(rangedMainHand, "MYSTIC_WAR_ADEPT")
        end
        if rangedOffHand then
            Osi.RemoveStatus(rangedOffHand, "MYSTIC_WAR_ADEPT")
        end
    end

end

function WarAdept_GreatWeaponFighting(character)

    local meleeMainHand = Osi.GetEquippedItem(character, "Melee Main Weapon")
    local meleeOffHand = Osi.GetEquippedItem(character, "Melee Offhand Weapon")
    local hasShield = Osi.GetEquippedShield(character) == true
    local meleeMainHandProperties = 0
    local meleeOffHandProperties = 0

    if meleeMainHand then
        local meleeMainHandWeaponEntity = Ext.Entity.Get(meleeMainHand)
        if meleeMainHandWeaponEntity then
            local meleeMainHandWeapon = meleeMainHandWeaponEntity.Weapon
            if meleeMainHandWeapon then
                meleeMainHandProperties = meleeMainHandWeapon.WeaponProperties
            end
        end
    end

    if meleeOffHand then
        local meleeOffHandWeaponEntity = Ext.Entity.Get(meleeOffHand)
        if meleeOffHandWeaponEntity then
            local meleeOffHandWeapon = meleeOffHandWeaponEntity.Weapon
            if meleeOffHandWeapon then
                meleeOffHandProperties = meleeOffHandWeapon.WeaponProperties
            end
        end
    end

    local hasTwoHandedWeapon = ((meleeMainHandProperties & 1024) and (meleeMainHandProperties & 4096)) > 0
    local hasVersatileWeaponOnly = (meleeMainHandProperties & 2048) and not (meleeOffHandProperties & 4096) and not hasShield
    local hasGreatWeaponStatus = Osi.HasActiveStatus(character, "MYSTIC_MYSTIC_ARSENAL_GREAT_WEAPON_FIGHTING") == 1

    if hasGreatWeaponStatus
    and (hasTwoHandedWeapon or hasVersatileWeaponOnly)
    then
        if meleeMainHand then
            Osi.ApplyStatus(meleeMainHand, "MYSTIC_WAR_ADEPT", -1, 1, character)
        end
    end

end

function WarAdept_Dueling(character)

    local meleeMainHand = Osi.GetEquippedItem(character, "Melee Main Weapon")
    local meleeOffHand = Osi.GetEquippedItem(character, "Melee Offhand Weapon")
    local hasShield = Osi.GetEquippedShield(character) == true
    local meleeMainHandProperties = 0
    local meleeOffHandProperties = 0

    if meleeMainHand then
        local meleeMainHandWeaponEntity = Ext.Entity.Get(meleeMainHand)
        if meleeMainHandWeaponEntity then
            local meleeMainHandWeapon = meleeMainHandWeaponEntity.Weapon
            if meleeMainHandWeapon then
                meleeMainHandProperties = meleeMainHandWeapon.WeaponProperties
            end
        end
    end

    if meleeOffHand then
        local meleeOffHandWeaponEntity = Ext.Entity.Get(meleeOffHand)
        if meleeOffHandWeaponEntity then
            local meleeOffHandWeapon = meleeOffHandWeaponEntity.Weapon
            if meleeOffHandWeapon then
                meleeOffHandProperties = meleeOffHandWeapon.WeaponProperties
            end
        end
    end

    local hasNonVersatileWeapon = (meleeMainHandProperties & 4096) and not (meleeMainHandProperties & 2048) and not (meleeMainHandProperties & 1024) and not (meleeOffHandProperties & 4096) and not (meleeOffHandProperties & 2)
    local hasVersatileWeaponAndShield = (meleeMainHandProperties & 4096) and (meleeMainHandProperties & 2048) and hasShield
    local hasDuelingStatus = Osi.HasActiveStatus(character, "MYSTIC_MYSTIC_ARSENAL_DUELING") == 1

    if hasDuelingStatus
    and (hasNonVersatileWeapon or hasVersatileWeaponAndShield)
    then
        if meleeMainHand then
            Osi.ApplyStatus(meleeMainHand, "MYSTIC_WAR_ADEPT", -1, 1, character)
        end
    end

end

function WarAdept_Archery(character)

    local rangedMainHand = Osi.GetEquippedItem(character, "Ranged Main Weapon")
    local rangedOffHand = Osi.GetEquippedItem(character, "Ranged Offhand Weapon")
    local rangedMainHandProperties = 0
    local rangedOffHandProperties = 0

    if rangedMainHand then
        rangedMainHandProperties = Ext.Entity.Get(rangedMainHand).Weapon.WeaponProperties
    end
    if rangedOffHand then
        rangedOffHandProperties = Ext.Entity.Get(rangedOffHand).Weapon.WeaponProperties
    end

    if rangedMainHand then
        local rangedMainHandWeaponEntity = Ext.Entity.Get(rangedMainHand)
        if rangedMainHandWeaponEntity then
            local rangedMainHandWeapon = rangedMainHandWeaponEntity.Weapon
            if rangedMainHandWeapon then
                rangedMainHandProperties = rangedMainHandWeapon.WeaponProperties
            end
        end
    end

    if rangedOffHand then
        local rangedOffHandWeaponEntity = Ext.Entity.Get(rangedOffHand)
        if rangedOffHandWeaponEntity then
            local rangedOffHandWeapon = rangedOffHandWeaponEntity.Weapon
            if rangedOffHandWeapon then
                rangedOffHandProperties = rangedOffHandWeapon.WeaponProperties
            end
        end
    end

    local hasRangedWeapon = ((rangedMainHandProperties & 2) or (rangedOffHandProperties & 2)) > 0
    local hasArcheryStatus = Osi.HasActiveStatus(character, "MYSTIC_MYSTIC_ARSENAL_ARCHERY") == 1

    if hasArcheryStatus
    and hasRangedWeapon
    then
        if rangedMainHand then
            Osi.ApplyStatus(rangedMainHand, "MYSTIC_WAR_ADEPT", -1, 1, character)
        end

        if rangedOffHand then
            Osi.ApplyStatus(rangedOffHand, "MYSTIC_WAR_ADEPT", -1, 1, character)
        end
    end

end

function WarAdept_ThrownWeaponFighting(character)

    local meleeMainHand = Osi.GetEquippedItem(character, "Melee Main Weapon")
    local meleeOffHand = Osi.GetEquippedItem(character, "Melee Offhand Weapon")
    local meleeMainHandProperties = 0

    if meleeMainHand then
        local meleeMainHandWeaponEntity = Ext.Entity.Get(meleeMainHand)
        if meleeMainHandWeaponEntity then
            local meleeMainHandWeapon = meleeMainHandWeaponEntity.Weapon
            if meleeMainHandWeapon then
                meleeMainHandProperties = meleeMainHandWeapon.WeaponProperties
            end
        end
    end

    local hasThrownWeapon = (meleeMainHandProperties & 512) > 0
    local hasThrownWeaponStatus = Osi.HasActiveStatus(character, "MYSTIC_MYSTIC_ARSENAL_THROWN_WEAPON_FIGHTING") == 1

    if hasThrownWeaponStatus
    and hasThrownWeapon
    then
        if meleeMainHand then
            Osi.ApplyStatus(meleeMainHand, "MYSTIC_WAR_ADEPT", -1, 1, character)
        end

        if meleeOffHand then
            Osi.ApplyStatus(meleeOffHand, "MYSTIC_WAR_ADEPT", -1, 1, character)
        end
    end

end

function WarAdept_ApplyEffect(character)

    if character == nil then
        return
    end

    if Osi.HasPassive(character, "Passive_Mystic_WarAdept") == 0 then
        return
    end

    WarAdept_GreatWeaponFighting(character)
    WarAdept_Dueling(character)
    WarAdept_Archery(character)
    WarAdept_ThrownWeaponFighting(character)

end

function WarAdept_Equipped(item, character)

    if not Osi.IsWeapon(item)
    or not item
    or not character
    then
        return
    end

    WarAdept_ApplyEffect(character)

end

function WarAdept_Unequipped(item, _)
    if item then
        Osi.RemoveStatus(item, "MYSTIC_WAR_ADEPT")
    end
end

local function WarAdept_StartedPreviewingSpell(caster, _, _, _)

    WarAdept_ApplyEffect(caster)

end

local function WarAdept_StatusApplied(object, _, _, _)

    if Osi.IsCharacter(object) then
        WarAdept_RemoveEffect(object)
        WarAdept_ApplyEffect(object)
    end

end

local function WarAdept_StatusRemoved(object, _, _, _)

    if Osi.IsCharacter(object) then
        WarAdept_RemoveEffect(object)
        WarAdept_ApplyEffect(object)
    end

end

local function WarAdept_EnteredCombat(object, _)

    WarAdept_RemoveEffect(object)
    WarAdept_ApplyEffect(object)

end

local function WarAdept_CastSpell(caster, _, _, _, _)

    WarAdept_RemoveEffect(caster)
    WarAdept_ApplyEffect(caster)

end

local function WarAdept_CastedSpell(caster, _, _, _, _)

    WarAdept_RemoveEffect(caster)
    WarAdept_ApplyEffect(caster)

end

local function WarAdept_LeveledUp(character)

    WarAdept_RemoveEffect(character)
    WarAdept_ApplyEffect(character)

end

-- Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", WarAdept_StatusRemoved)
Ext.Osiris.RegisterListener("EnteredCombat", 2, "after", WarAdept_EnteredCombat)
Ext.Osiris.RegisterListener("CastSpell", 5, "before", WarAdept_CastSpell)
Ext.Osiris.RegisterListener("CastedSpell", 5, "before", WarAdept_CastedSpell)
Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "after", WarAdept_StartedPreviewingSpell)
-- Ext.Osiris.RegisterListener("StatusApplied", 4, "after", WarAdept_StatusApplied)
Ext.Osiris.RegisterListener("Equipped", 2, "after", WarAdept_Equipped)
Ext.Osiris.RegisterListener("Unequipped", 2, "before", WarAdept_Unequipped)