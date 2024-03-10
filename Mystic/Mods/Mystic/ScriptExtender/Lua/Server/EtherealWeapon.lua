-- Might make this a new mod: Pseudo-attack support
-- Patches ALL IsUnarmedAttack(), IsWeaponAttack()

-- TODO: Patch a bunch of effects to also work with Ethereal Weapon

-- If something has:
-- - IsWeaponAttack()
-- Change it to:
-- - (IsWeaponAttack() or SpellId('Target_Mystic_EtherealWeapon_Melee') or SpellId('Target_Mystic_EtherealWeapon_Ranged'))

-- If something has:
-- - IsMeleeWeaponAttack()
-- Change it to:
-- - (IsMeleeWeaponAttack() or SpellId('Target_Mystic_EtherealWeapon_Melee'))

-- If something has:
-- - IsRangedWeaponAttack()
-- Change it to:
-- - (IsRangedWeaponAttack() or SpellId('Target_Mystic_EtherealWeapon_Ranged'))


-- Or could just patch the khn? But idk if that will work, also not fully comprehensive? Idk