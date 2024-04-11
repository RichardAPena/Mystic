local monkSkills = {
    -- Target_MainHandAttack = true,
    -- Target_OffhandAttack = true,
    -- Projectile_MainHandAttack = true,
    -- Projectile_OffhandAttack = true,
    -- Target_Mystic_PsionicStrike = true,
    -- Target_Mystic_PsionicStrike_Psychic = true,
    -- Target_Mystic_PsionicStrike_Force = true,
    -- Target_Mystic_PsionicStrike_Bonus = true,
    -- Target_Mystic_PsionicStrike_Bonus_Psychic = true,
    -- Target_Mystic_PsionicStrike_Bonus_Force = true,
    Target_Mystic_GravitationalSlam = true,
    Target_Mystic_GravitationalSlam_1 = true,
    Target_Mystic_GravitationalSlam_2 = true,
    Target_Mystic_GravitationalSlam_3 = true,
    Target_Mystic_GravitationalSlam_4 = true,
    Target_Mystic_GravitationalSlam_5 = true,
    Target_Mystic_GravitationalSlam_6 = true,
    Target_Mystic_GravitationalSlam_7 = true,
    Target_Mystic_DensityShift = true,
    Target_Mystic_DensityShift_Buff = true,
    Target_Mystic_DensityShift_Debuff = true,
    Target_Mystic_CrushingForce = true,
    Target_Mystic_Singularity = true,
    Target_Mystic_SpatialCompression = true,
    Target_Mystic_BorrowedTime = true,
    Target_Mystic_TwistOfFate = true,
    Shout_Mystic_FutureSight = true,
    Target_Mystic_TimeStop = true,
    Target_Mystic_Chronoward = true,
    Target_Mystic_AccelerationZone = true,
    Projectile_Mystic_AstralMote = true,
    Projectile_Mystic_AstralMote_1 = true,
    Projectile_Mystic_AstralMote_2 = true,
    Projectile_Mystic_AstralMote_3 = true,
    Projectile_Mystic_AstralMote_4 = true,
    Projectile_Mystic_AstralMote_5 = true,
    Projectile_Mystic_AstralMote_6 = true,
    Projectile_Mystic_AstralMote_7 = true,
    Shout_Mystic_Moonlight = true,
    Target_Mystic_Sunburst = true,
    Wall_Mystic_StarRail = true,
    Target_Mystic_Starstorm = true,
    Projectile_Mystic_ToxicSpines = true,
    Projectile_Mystic_ToxicSpines_1 = true,
    Projectile_Mystic_ToxicSpines_2 = true,
    Projectile_Mystic_ToxicSpines_3 = true,
    Projectile_Mystic_ToxicSpines_4 = true,
    Projectile_Mystic_ToxicSpines_5 = true,
    Projectile_Mystic_ToxicSpines_6 = true,
    Projectile_Mystic_ToxicSpines_7 = true,
    Projectile_Mystic_ThornyBriars = true,
    Target_Mystic_Regrowth = true,
    Target_Mystic_Brambleskin = true,
    Shout_Mystic_MassEntanglement = true,
    Projectile_Mystic_ShrapnelBlast = true,
    Projectile_Mystic_ShrapnelBlast_1 = true,
    Projectile_Mystic_ShrapnelBlast_2 = true,
    Projectile_Mystic_ShrapnelBlast_3 = true,
    Projectile_Mystic_ShrapnelBlast_4 = true,
    Projectile_Mystic_ShrapnelBlast_5 = true,
    Projectile_Mystic_ShrapnelBlast_6 = true,
    Projectile_Mystic_ShrapnelBlast_7 = true,
    Target_Mystic_SharpenedSteel = true,
    Target_Mystic_Magnetize = true,
    Target_Mystic_ReinforcedPlating = true,
    Shout_Mystic_MagneticStorm = true
}

-- TODO: Add some checks:
-- If the progression source is MYSTIC, change it to MONK
-- If the progression source is WU JEN or IMMORTAL, change it to WAY OF THE FOUR ELEMENTS
-- Check the ORIGINAL spellUUID; may not be required to change
-- Check the ORIGINAL source, if it's ALWAYS Boost then I can change the source to Boost and it may work
-- If it doesn't work, and it's always Boost, I may be screwed? But it may still be salvageable

local progression = "c4598bdb-fc07-40dd-a62c-90cc138bd76f" -- Monk
-- local source = "Progression1"
local source = "Boost"
local spellUUID = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf"

Ext.Entity.Subscribe("SpellContainer", function(entity)
    for _, entry in pairs(entity.SpellContainer.Spells) do
        if monkSkills[entry.SpellId.OriginatorPrototype] then
            -- _P("SpellContainer: entry: OriginatorPrototype: " .. entry.SpellId.OriginatorPrototype)
            -- _P("SpellContainer: entry: SourceType: " .. entry.SpellId.SourceType)
            -- _P("SpellContainer: entry: ProgressionSource: " .. entry.SpellId.ProgressionSource)
            -- _P("SpellContainer: entry: Prototype: " .. entry.SpellId.Prototype)
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


--[[

-- Character must have passive with "DynamicAnimationTag" "c4598bdb-fc07-40dd-a62c-90cc138bd76f"
function MonkAnimations_SetMonkAnimations(object, _, _, _)
    -- Osi.AddBoosts(object, "ActionResource(KiPoint, 10, 0)", "", object)
    -- Osi.ApplyStatus(object, "FOCUSCORE_MONKANIMATION", -1)
    -- Osi.AddSpell(object, "Projectile_RayOfFrost_Monk")

    local progression = "c4598bdb-fc07-40dd-a62c-90cc138bd76f" -- Monk
    local source = "Progression1"
    local spellUUID = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf"

    local entity = Ext.Entity.Get(object)
    if entity == nil then return end
    if entity.HotbarContainer ~= nil then
        for _, container in pairs(entity.HotbarContainer.Containers) do
            for _, subContainer in ipairs(container) do
                for _, spell in ipairs(subContainer.Elements) do
                    if monkSkills[spell.SpellId.OriginatorPrototype] then
                        spell.SpellId.SourceType = source
                        spell.SpellId.ProgressionSource = progression
                        entity:Replicate("HotbarContainer")
                    end
                end
            end
        end
    end

    if entity.SpellBook ~= nil then
        for _, spell in pairs(entity.SpellBook.Spells) do
            if monkSkills[spell.Id.OriginatorPrototype] then
                spell.Id.SourceType = source
                spell.Id.ProgressionSource = progression
                spell.SpellUUID = spellUUID
                entity:Replicate("SpellBook")
            end
        end
    
        for _, spell in pairs(entity.AddedSpells.Spells) do
            if monkSkills[spell.SpellId.OriginatorPrototype] then
                spell.SpellId.SourceType = source
                spell.SpellId.ProgressionSource = progression
                spell.SpellUUID = spellUUID
            end
        end
    end

    if entity.PlayerPrepareSpell ~= nil then
        for _, spell in ipairs(entity.PlayerPrepareSpell.Spells) do
            if monkSkills[spell.OriginatorPrototype] then
                spell.SourceType = source
                spell.ProgressionSource = progression
                entity:Replicate("PlayerPrepareSpell")
            end
        end
    end

    if entity.SpellBookPrepares ~= nil then
        for _, spell in ipairs(entity.SpellBookPrepares.PreparedSpells) do
            if monkSkills[spell.OriginatorPrototype] then
                spell.SourceType = source
                spell.ProgressionSource = progression
                entity:Replicate("SpellBookPrepares")
            end
        end
    end

    if entity.SpellContainer ~= nil then
        for _, spell in ipairs(entity.SpellContainer.Spells) do
            if monkSkills[spell.SpellId.OriginatorPrototype] then
                spell.SpellId.SourceType = source
                spell.SpellId.ProgressionSource = progression
                spell.SpellUUID = spellUUID
                entity:Replicate("SpellContainer")
            end
        end
    end

    Ext.Entity.Subscribe("SpellBook", function()
        for _, spell in pairs(entity.SpellBook.Spells) do
            if monkSkills[spell.Id.OriginatorPrototype] then
                spell.Id.SourceType = source
                spell.Id.ProgressionSource = progression
                spell.SpellUUID = spellUUID
            end
        end

        for _, spell in pairs(entity.AddedSpells.Spells) do
            if monkSkills[spell.SpellId.OriginatorPrototype] then
                spell.SpellId.SourceType = source
                spell.SpellId.ProgressionSource = progression
                spell.SpellUUID = spellUUID
            end
        end
    end, entity)

    Ext.Entity.Subscribe("PlayerPrepareSpell", function()
        for _, spell in ipairs(entity.PlayerPrepareSpell.Spells) do
            if monkSkills[spell.OriginatorPrototype]then
                spell.SourceType = source
                spell.ProgressionSource = progression
            end
        end
    end, entity)

    Ext.Entity.Subscribe("SpellBookPrepares", function()
        for _, spell in ipairs(entity.SpellBookPrepares.PreparedSpells) do
            if monkSkills[spell.OriginatorPrototype] then
                spell.SourceType = source
                spell.ProgressionSource = progression
            end
        end
    end, entity)

    Ext.Entity.Subscribe("SpellContainer", function()
        for _, spell in ipairs(entity.SpellContainer.Spells) do
            if monkSkills[spell.SpellId.OriginatorPrototype] then
                spell.SpellId.SourceType = source
                spell.SpellId.ProgressionSource = progression
                spell.SpellUUID = spellUUID
            end
        end
    end, entity)
end

Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "after", MonkAnimations_SetMonkAnimations)

--]]