local monkSkills = {
    Target_MainHandAttack = true,
    Target_OffhandAttack = true,
    Projectile_MainHandAttack = true,
    Projectile_OffhandAttack = true,
    Shout_Mystic_RapidStep = true,
    Shout_Mystic_RapidStep_1 = true,
    Shout_Mystic_RapidStep_2 = true,
    Shout_Mystic_RapidStep_3 = true,
    Shout_Mystic_RapidStep_4 = true,
    Shout_Mystic_RapidStep_5 = true,
    Shout_Mystic_RapidStep_6 = true,
    Shout_Mystic_RapidStep_7 = true,
    Shout_Mystic_AgileDefense = true,
    Shout_Mystic_BlurOfMotion = true,
    Shout_Mystic_SurgeOfSpeed = true,
    Shout_Mystic_SurgeOfAction = true,
    Projectile_Mystic_WindStep = true,
    Projectile_Mystic_WindStep_1 = true,
    Projectile_Mystic_WindStep_2 = true,
    Projectile_Mystic_WindStep_3 = true,
    Projectile_Mystic_WindStep_4 = true,
    Projectile_Mystic_WindStep_5 = true,
    Projectile_Mystic_WindStep_6 = true,
    Projectile_Mystic_WindStep_7 = true,
    Zone_Mystic_WindStream = true,
    Zone_Mystic_WindStream_1 = true,
    Zone_Mystic_WindStream_2 = true,
    Zone_Mystic_WindStream_3 = true,
    Zone_Mystic_WindStream_4 = true,
    Zone_Mystic_WindStream_5 = true,
    Zone_Mystic_WindStream_6 = true,
    Zone_Mystic_WindStream_7 = true,
    Shout_Mystic_CloakOfAir = true,
    Shout_Mystic_WindForm = true,
    Shout_Mystic_MistyForm = true,
    Target_Mystic_AnimateAir = true,
    Target_Mystic_Combustion = true,
    Target_Mystic_Combustion_1 = true,
    Target_Mystic_Combustion_2 = true,
    Target_Mystic_Combustion_3 = true,
    Target_Mystic_Combustion_4 = true,
    Target_Mystic_Combustion_5 = true,
    Target_Mystic_Combustion_6 = true,
    Target_Mystic_Combustion_7 = true,
    Target_Mystic_RollingFlame = true,
    Target_Mystic_Detonation = true,
    Shout_Mystic_FireForm = true,
    Target_Mystic_AnimateFire = true,
    Target_Mystic_Push = true,
    Target_Mystic_Push_1 = true,
    Target_Mystic_Push_2 = true,
    Target_Mystic_Push_3 = true,
    Target_Mystic_Push_4 = true,
    Target_Mystic_Push_5 = true,
    Target_Mystic_Push_6 = true,
    Target_Mystic_Push_7 = true,
    Shout_Mystic_InertialArmor = true,
    Wall_Mystic_TelekineticBarrier = true,
    Target_Mystic_Grasp = true,
    Target_Mystic_Crush = true,
    Throw_Mystic_Move = true,
    Throw_Mystic_Move_5 = true,
    Throw_Mystic_Move_6 = true,
    Throw_Mystic_Move_7 = true,
    Projectile_Mystic_IceSpike = true,
    Projectile_Mystic_IceSpike_1 = true,
    Projectile_Mystic_IceSpike_2 = true,
    Projectile_Mystic_IceSpike_3 = true,
    Projectile_Mystic_IceSpike_4 = true,
    Projectile_Mystic_IceSpike_5 = true,
    Projectile_Mystic_IceSpike_6 = true,
    Projectile_Mystic_IceSpike_7 = true,
    Target_Mystic_IceSheet = true,
    Shout_Mystic_FrozenSanctuary = true,
    Target_Mystic_FrozenRain = true,
    Target_Mystic_FrozenRain_5 = true,
    Target_Mystic_FrozenRain_6 = true,
    Target_Mystic_FrozenRain_7 = true,
    Wall_Mystic_IceBarrier = true,
    Target_Mystic_Darkness = true,
    Target_Mystic_Darkness_1 = true,
    Target_Mystic_Darkness_2 = true,
    Target_Mystic_Darkness_3 = true,
    Target_Mystic_Darkness_4 = true,
    Target_Mystic_Darkness_5 = true,
    Target_Mystic_Darkness_6 = true,
    Target_Mystic_Darkness_7 = true,
    Target_Mystic_Light = true,
    Target_Mystic_ShadowBeasts = true,
    Projectile_Mystic_RadiantBeam = true,
    Projectile_Mystic_RadiantBeam_5 = true,
    Projectile_Mystic_RadiantBeam_6 = true,
    Projectile_Mystic_RadiantBeam_7 = true,
    Target_Mystic_Dessicate = true,
    Target_Mystic_Dessicate_1 = true,
    Target_Mystic_Dessicate_2 = true,
    Target_Mystic_Dessicate_3 = true,
    Target_Mystic_Dessicate_4 = true,
    Target_Mystic_Dessicate_5 = true,
    Target_Mystic_Dessicate_6 = true,
    Target_Mystic_Dessicate_7 = true,
    Target_Mystic_WateryGrasp = true,
    Target_Mystic_WateryGrasp_2 = true,
    Target_Mystic_WateryGrasp_3 = true,
    Target_Mystic_WateryGrasp_4 = true,
    Target_Mystic_WateryGrasp_5 = true,
    Target_Mystic_WateryGrasp_6 = true,
    Target_Mystic_WateryGrasp_7 = true,
    Zone_Mystic_WaterWhip = true,
    Zone_Mystic_WaterWhip_3 = true,
    Zone_Mystic_WaterWhip_4 = true,
    Zone_Mystic_WaterWhip_5 = true,
    Zone_Mystic_WaterWhip_6 = true,
    Zone_Mystic_WaterWhip_7 = true,
    Target_Mystic_WaterSphere = true,
    Target_Mystic_AnimateWater = true,
    Projectile_Mystic_HungryLightning = true,
    Projectile_Mystic_HungryLightning_1 = true,
    Projectile_Mystic_HungryLightning_2 = true,
    Projectile_Mystic_HungryLightning_3 = true,
    Projectile_Mystic_HungryLightning_4 = true,
    Projectile_Mystic_HungryLightning_5 = true,
    Projectile_Mystic_HungryLightning_6 = true,
    Projectile_Mystic_HungryLightning_7 = true,
    Wall_Mystic_WallOfClouds = true,
    Target_Mystic_Whirlwind = true,
    Rush_Mystic_Lightning_Leap = true,
    Rush_Mystic_Lightning_Leap_5 = true,
    Rush_Mystic_Lightning_Leap_6 = true,
    Rush_Mystic_Lightning_Leap_7 = true,
    Wall_Mystic_WallOfThunder = true,
    Target_Mystic_ThunderClap = true,
    Projectile_Mystic_AnimateWeapon = true,
    Projectile_Mystic_AnimateWeapon_1 = true,
    Projectile_Mystic_AnimateWeapon_2 = true,
    Projectile_Mystic_AnimateWeapon_3 = true,
    Projectile_Mystic_AnimateWeapon_4 = true,
    Projectile_Mystic_AnimateWeapon_5 = true,
    Projectile_Mystic_AnimateWeapon_6 = true,
    Projectile_Mystic_AnimateWeapon_7 = true,
    Target_Mystic_WarpWeapon = true,
    Target_Mystic_WarpArmor = true,
    Wall_Mystic_WallOfWood = true,
    Shout_Mystic_ArmoredForm = true,
    Target_Mystic_AnimateEarth = true,
    Target_Mystic_StepOfADozenPaces = true,
    Target_Mystic_StepOfADozenPaces_1 = true,
    Target_Mystic_StepOfADozenPaces_2 = true,
    Target_Mystic_StepOfADozenPaces_3 = true,
    Target_Mystic_StepOfADozenPaces_4 = true,
    Target_Mystic_StepOfADozenPaces_5 = true,
    Target_Mystic_StepOfADozenPaces_6 = true,
    Target_Mystic_StepOfADozenPaces_7 = true,
    Shout_Mystic_DefensiveStep = true,
    Target_Mystic_ThereAndBackAgain = true,
    Target_Mystic_BackAgain = true,
    Target_Mystic_Transposition = true,
    Target_Mystic_BalefulTransposition = true,
    Shout_Mystic_PhantomCaravan = true,
    Teleportation_Mystic_PhantomJourney = true,
    Teleportation_Mystic_NomadicGate = true,
}

local progression = "c4598bdb-fc07-40dd-a62c-90cc138bd76f" -- Monk
local source = "Progression1"
local spellUUID = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf"

Ext.Entity.Subscribe("SpellContainer", function(entity)
    for _, entry in pairs(entity.SpellContainer.Spells) do
        if monkSkills[entry.SpellId.OriginatorPrototype] then
            --entry.SpellId.SourceType = source
            entry.SpellId.ProgressionSource = progression
            entry.SpellUUID = spellUUID
        end
    end
end)

-- Prevents actions from being removed from hotbars
Ext.Entity.Subscribe("HotbarContainer", function(entity)
    for _, container in pairs(entity.HotbarContainer.Containers) do
        for _, containerInfo in pairs(container) do
            for _, entry in pairs (containerInfo.Elements) do
                if monkSkills[entry.SpellId.OriginatorPrototype] then
                    entry.SpellId.SourceType = source
                end
            end
        end
    end
end)

Ext.Entity.Subscribe("SpellBook", function(entity)
    for _, spell in pairs(entity.SpellBook.Spells) do
        if monkSkills[spell.Id.OriginatorPrototype] then
            --spell.Id.SourceType = source
            spell.Id.ProgressionSource = progression
            spell.SpellUUID = spellUUID
        end
    end

    for _, entry in pairs(entity.AddedSpells.Spells) do
        if monkSkills[entry.SpellId.OriginatorPrototype] then
            --entry.SpellId.SourceType = source
            entry.SpellId.ProgressionSource = progression
            entry.SpellUUID = spellUUID
        end
    end
end)

Ext.Entity.Subscribe("SpellBookPrepares", function(entity)
    for _, spell in pairs(entity.SpellBookPrepares.PreparedSpells) do
        if monkSkills[spell.OriginatorPrototype] then
            --spell.SourceType = source
            spell.ProgressionSource = progression
        end
    end
end)