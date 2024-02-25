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

local function WarAdept_ShouldReapplyWarAdept(wielder, weapon)

    if wielder == nil then
        return false
    end

    -- Do not reapply status if user doesn't have War Adept
    local hasWarAdept = Osi.HasPassive(wielder, "Passive_Mystic_WarAdept")
    if not hasWarAdept then
        return false
    end

    -- Mystic Arsenal Statuses
    local hasGreatWeaponStatus = Osi.HasActiveStatus(wielder, "MYSTIC_MYSTIC_ARSENAL_GREAT_WEAPON_FIGHTING") == 1
    local hasDuelingStatus = Osi.HasActiveStatus(wielder, "MYSTIC_MYSTIC_ARSENAL_DUELING") == 1
    local hasArcheryStatus = Osi.HasActiveStatus(wielder, "MYSTIC_MYSTIC_ARSENAL_ARCHERY") == 1
    local hasThrownWeaponStatus = Osi.HasActiveStatus(wielder, "MYSTIC_MYSTIC_ARSENAL_THROWN_WEAPON_FIGHTING") == 1

    -- Get equipped weapons
    local meleeMainHand = Osi.GetEquippedItem(wielder, "Melee Main Weapon")
    local meleeOffHand = Osi.GetEquippedItem(wielder, "Melee Offhand Weapon")
    local hasShield = Osi.GetEquippedShield(wielder) == true
    local rangedMainHand = Osi.GetEquippedItem(wielder, "Ranged Main Weapon")
    local rangedOffHand = Osi.GetEquippedItem(wielder, "Ranged Offhand Weapon")

    -- Get equipped weapon properties
    local meleeMainHandProperties = 0
    local meleeOffHandProperties = 0
    local rangedMainHandProperties = 0
    local rangedOffHandProperties = 0

    if meleeMainHand then
        meleeMainHandProperties = Ext.Entity.Get(meleeMainHand).Weapon.WeaponProperties
    end
    if meleeOffHand then
        meleeOffHandProperties = Ext.Entity.Get(meleeOffHand).Weapon.WeaponProperties
    end
    if rangedMainHand then
        rangedMainHandProperties = Ext.Entity.Get(rangedMainHand).Weapon.WeaponProperties
    end
    if rangedOffHand then
        rangedOffHandProperties = Ext.Entity.Get(rangedOffHand).Weapon.WeaponProperties
    end

    -- Two-handed and Melee
    local hasTwoHandedWeapon = ((meleeMainHandProperties & 1024) and (meleeMainHandProperties & 4096)) > 0
    -- print("hasTwoHandedWeapon: " .. tostring(hasTwoHandedWeapon))

    -- Versatile and no melee off-hand or shield
    local hasVersatileWeaponOnly = (meleeMainHandProperties & 2048) and not (meleeOffHandProperties & 4096) and not hasShield
    -- print("hasVersatileWeaponOnly: " .. tostring(hasVersatileWeaponOnly))

    -- Non-versatile weapon
    local hasNonVersatileWeapon = (meleeMainHandProperties & 4096) and not (meleeMainHandProperties & 2048) and not (meleeMainHandProperties & 1024) and not (meleeOffHandProperties & 4096) and not (meleeOffHandProperties & 2)
    -- print("hasVersatileWeaponOnly: " .. tostring(hasVersatileWeaponOnly))

    -- Versatile melee weapon with shield
    local hasVersatileWeaponAndShield = (meleeMainHandProperties & 4096) and (meleeMainHandProperties & 2048) and hasShield
    -- print("hasVersatileWeaponOnly: " .. tostring(hasVersatileWeaponOnly))

    -- Ranged weapon
    local hasRangedWeapon = ((rangedMainHandProperties & 2) or (rangedOffHandProperties & 2)) > 0

    -- Thrown weapon
    local hasThrownWeapon = (meleeMainHandProperties & 512) > 0

    local hasGreatWeaponEquipped =  hasTwoHandedWeapon or hasVersatileWeaponOnly
    local hasDuelingWeaponEquipped = hasNonVersatileWeapon or hasVersatileWeaponAndShield 
    local hasArcheryWeaponEquipped = hasRangedWeapon
    local hasThrownWeaponEquipped = hasThrownWeapon

    -- Need to check the weapon being sent in as an argument
    local currentWeaponProperties = Ext.Entity.Get(weapon).Weapon.WeaponProperties
    local isCurrentWeaponGreat = ((currentWeaponProperties & 1024) > 0) or ((currentWeaponProperties & 2048) > 0) -- Twohanded or Versatile
    local isCurrentWeaponDueling = (currentWeaponProperties & 4096) > 0 -- Melee
    local isCurrentWeaponArchery = (currentWeaponProperties & 2) > 0 -- Ranged
    local isCurrentWeaponThrown = (currentWeaponProperties & 512) > 0 -- Thrown

    -- print("hasGreatWeaponStatus: ".. tostring(hasGreatWeaponStatus))
    -- print("hasGreatWeaponEquipped: " .. tostring(hasGreatWeaponEquipped))
    -- print("isCurrentWeaponGreat: " .. tostring(isCurrentWeaponGreat))
    -- print("hasDuelingStatus: " .. tostring(hasDuelingStatus))
    -- print("hasDuelingWeaponEquipped: " .. tostring(hasDuelingWeaponEquipped))
    -- print("isCurrentWeaponDueling: " .. tostring(isCurrentWeaponDueling))
    -- print("hasArcheryStatus: " .. tostring(hasArcheryStatus))
    -- print("hasArcheryWeaponEquipped: " .. tostring(hasArcheryWeaponEquipped))
    -- print("isCurrentWeaponArchery: " .. tostring(isCurrentWeaponArchery))
    -- print("hasThrownWeaponStatus: " .. tostring(hasThrownWeaponStatus))
    -- print("hasThrownWeaponEquipped: " .. tostring(hasThrownWeaponEquipped))
    -- print("isCurrentWeaponThrown: " .. tostring(isCurrentWeaponThrown))

    if (hasGreatWeaponStatus and hasGreatWeaponEquipped and isCurrentWeaponGreat)
    or (hasDuelingStatus and hasDuelingWeaponEquipped and isCurrentWeaponDueling)
    or (hasArcheryStatus and hasArcheryWeaponEquipped and isCurrentWeaponArchery)
    or (hasThrownWeaponStatus and hasThrownWeaponEquipped and isCurrentWeaponThrown)
    then
        return true
    end

    return false

end


local function WarAdept_StatusRemoved(object, status, causee, applyStoryActionID)

    -- print("WarAdept: StatusRemoved: " .. object .. ", " .. status .. ", " .. causee)
    if not Osi.IsWeapon(object) or status ~= "MYSTIC_WAR_ADEPT" then
        return
    end

    local wielder = Osi.GetOwner(object)
    -- print("WarAdept: wielder: " .. wielder)
    -- print("WarAdept: properties: " .. (Ext.Entity.Get(object).Weapon.WeaponProperties or 0))

    if WarAdept_ShouldReapplyWarAdept(wielder, object) then
        Osi.ApplyStatus(object, "MYSTIC_WAR_ADEPT", 10, 0, wielder)
    end

end

-- local function WarAdept_StatusApplied(object, status, causee, applyStoryActionID)
    -- print("Heloge from WarAdept StatusApplied")
    -- print("Weapon owner hopefully: " .. Osi.GetOwner(object))
    -- print("Weapon: " .. object.Weapon)
    -- print(Ext.Entity.Get(object).Weapon.WeaponProperties)
    -- print("WeaponProperties: " .. object.WeaponProperties)
-- end


-- Ext.Osiris.RegisterListener("StatusApplied", 4, "after", WarAdept_StatusApplied)
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", WarAdept_StatusRemoved)