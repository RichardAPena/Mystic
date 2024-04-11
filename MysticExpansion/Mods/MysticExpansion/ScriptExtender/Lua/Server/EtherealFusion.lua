
local NullUUID = "NULL_00000000-0000-0000-0000-000000000000"

local function EtherealFusion_Move(object)

    -- print("MOVING PERSON supposedly")

    -- Whenever a Driver moves, drag the Rider with them
    local ghostRider = Osi.GetVarUUID(object, "EtherealFusion_Rider")

    if ghostRider ~= nil and ghostRider ~= NullUUID then
        Osi.TeleportTo(ghostRider, object, "", 0, 0, 0, 0, 1)
    end

end

local function EtherealFusion_StatusApplied(object, status, causee, _)

    -- print("EtherealFusion: StatusApplied: object: " .. object .. " status: " .. status .. " causee: " .. causee .. " storyActionID:" .. storyActionID)

    if status == "MYSTIC_ETHEREAL_FUSION_TARGET" then
        -- Object is being Ridden by Causee
        Osi.SetVarUUID(object, "EtherealFusion_Rider", causee)

        -- Causee is being Driven by Object
        Osi.SetVarUUID(causee, "EtherealFusion_Driver", object)
    end

    if status == "MYSTIC_ETHEREAL_FUSION" then
        local meleeMainHand = Osi.GetEquippedItem(object, "Melee Main Weapon")
        local meleeOffHand = Osi.GetEquippedItem(object, "Melee Offhand Weapon")
        local rangedMainHand = Osi.GetEquippedItem(object, "Ranged Main Weapon")
        local rangedOffHand = Osi.GetEquippedItem(object, "Ranged Offhand Weapon")

        if meleeMainHand then
            Osi.ApplyStatus(meleeMainHand, "MYSTIC_ETHEREAL_FUSION_FX", -1, 1, object)
        end

        if meleeOffHand then
            Osi.ApplyStatus(meleeOffHand, "MYSTIC_ETHEREAL_FUSION_FX", -1, 1, object)
        end

        if rangedMainHand then
            Osi.ApplyStatus(rangedMainHand, "MYSTIC_ETHEREAL_FUSION_FX", -1, 1, object)
        end

        if rangedOffHand then
            Osi.ApplyStatus(rangedOffHand, "MYSTIC_ETHEREAL_FUSION_FX", -1, 1, object)
        end
    end

    EtherealFusion_Move(object)

end

local function EtherealFusion_StatusRemoved(object, status, causee, _)

    -- print("EtherealFusion: StatusRemoved: object: " .. object .. " status: " .. status .. " causee: " .. causee .. " applyStoryActionID: " .. applyStoryActionID)

    if status == "MYSTIC_ETHEREAL_FUSION_TARGET" or
    status == "MYSTIC_ETHEREAL_FUSION" then

        local ghostRider = Osi.GetVarUUID(object, "EtherealFusion_Rider")
        local ghostDriver = Osi.GetVarUUID(object, "EtherealFusion_Driver")

        Osi.RemoveStatus(object, "MYSTIC_ETHEREAL_FUSION")
        Osi.RemoveStatus(object, "MYSTIC_ETHEREAL_FUSION_TARGET")
        Osi.RemoveStatus(object, "MYSTIC_ETHEREAL_FUSION_TEMPORARY_HP")

        local meleeMainHand = Osi.GetEquippedItem(object, "Melee Main Weapon")
        local meleeOffHand = Osi.GetEquippedItem(object, "Melee Offhand Weapon")
        local rangedMainHand = Osi.GetEquippedItem(object, "Ranged Main Weapon")
        local rangedOffHand = Osi.GetEquippedItem(object, "Ranged Offhand Weapon")

        if meleeMainHand then
            Osi.RemoveStatus(meleeMainHand, "MYSTIC_ETHEREAL_FUSION_FX")
        end

        if meleeOffHand then
            Osi.RemoveStatus(meleeOffHand, "MYSTIC_ETHEREAL_FUSION_FX")
        end

        if rangedMainHand then
            Osi.RemoveStatus(rangedMainHand, "MYSTIC_ETHEREAL_FUSION_FX")
        end

        if rangedOffHand then
            Osi.RemoveStatus(rangedOffHand, "MYSTIC_ETHEREAL_FUSION_FX")
        end

        if ghostRider ~= nil and ghostRider ~= NullUUID then
            Osi.RemoveStatus(ghostRider, "MYSTIC_ETHEREAL_FUSION")
            Osi.RemoveStatus(ghostRider, "MYSTIC_ETHEREAL_FUSION_TARGET")
            Osi.RemoveStatus(ghostRider, "MYSTIC_ETHEREAL_FUSION_TEMPORARY_HP")
        end

        if ghostDriver ~= nil and ghostDriver ~= NullUUID then
            Osi.RemoveStatus(ghostDriver, "MYSTIC_ETHEREAL_FUSION")
            Osi.RemoveStatus(ghostDriver, "MYSTIC_ETHEREAL_FUSION_TARGET")
            Osi.RemoveStatus(ghostDriver, "MYSTIC_ETHEREAL_FUSION_TEMPORARY_HP")
        end

        Osi.SetVarUUID(object, "EtherealFusion_Rider", NullUUID)
        Osi.SetVarUUID(causee, "EtherealFusion_Driver", NullUUID)

    end

    EtherealFusion_Move(object)

end

Ext.Osiris.RegisterListener("ForceMoveEnded", 3, "after", function(_, object, _)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("ForceMoveStarted", 3, "after", function(_, object, _)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("MovedBy", 2, "after", function(object, _)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("MovedFromTo", 4, "after", function(object, _, _, _)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("StartAttackPosition", 6, "after", function(_, _, _, object, _, _)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("Teleported", 9, "after", function(object, _, _, _, _, _, _, _, _)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("EnteredCombat", 2, "after", function (object, _)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("LeftCombat", 2, "after", function (object, _)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("EnteredForceTurnBased", 1, "after", function (object)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("LeftForceTurnBased", 1, "after", function (object)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("TurnStarted", 1, "after", function (object)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("TurnEnded", 1, "after", function (object)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("StartAttack", 4, "after", function (_, object, _, _)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("AttackedBy", 7, "after", function (object, _, _, _, _, _, _)
    EtherealFusion_Move(object)
end)

Ext.Osiris.RegisterListener("CastSpell", 5, "before", function(object, spell, _, _, _)
    EtherealFusion_Move(object)
    if spell == "Target_Mystic_EtherealFusion_Cancel" then
        Osi.RemoveStatus(object, "MYSTIC_ETHEREAL_FUSION")
    end
end)

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", EtherealFusion_StatusApplied)
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", EtherealFusion_StatusRemoved)