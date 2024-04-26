local NullUUID = "NULL_00000000-0000-0000-0000-000000000000"

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (object, status, causee, storyActionID)
    --[[


    if status == "MYSTIC_MYSTIC_HAND_INTERACT" and
    Osi.GetCanInteract(object)
    then
        Osi.SetUseRemotely(object, 1)
        Osi.ApplyStatus(causee, "MYSTIC_MYSTIC_HAND_BLOCK_MOVEMENT", 1, 1, causee)
        Osi.SetVarUUID(object, "MysticHand_Causee", causee)

        -- Osi.SetVarUUID(object, "SymbioticLink_Causee", causee)
        -- Osi.SetVarUUID(causee, "SymbioticLink_Target", object)

        -- Osi.Use(causee, object, 1, 0, "caulk and bawl")
        -- Osi.SetUseRemotely(object, 0)
    end
        ]]

        if status == "MYSTIC_MYSTIC_HAND_INTERACT" and
        Osi.GetUseRemotely(object) == 0 then
            Osi.SetUseRemotely(object, 1)
            Osi.ApplyStatus(object, "MYSTIC_MYSTIC_HAND_USE_REMOTELY", 10, 1, causee)
        end

end)


Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function (object, status, causee, storyActionID)
    -- _P("MysticHand: " .. object .. ", " .. status .. ", " .. causee)
    
    -- if status == "MYSTIC_MYSTIC_HAND_INTERACT" and
    -- Osi.GetCanInteract(object)
    -- then
    --     Osi.Use(Osi.GetVarUUID(object, "MysticHand_Causee"), object, 1, 0, "caulk and bawl")
    --     Osi.SetVarUUID(object, "MysticHand_Causee", NullUUID)
    -- end

    if status == "MYSTIC_MYSTIC_HAND_USE_REMOTELY" then
        Osi.SetUseRemotely(object, 0)
    end
end)
