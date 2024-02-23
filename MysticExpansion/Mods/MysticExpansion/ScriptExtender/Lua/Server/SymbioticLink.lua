Ext.Require("Server/SymbioticLink/SymbioticLink_Whitelist.lua")

local SymbioticLink_NullUUID = "NULL_00000000-0000-0000-0000-000000000000"

local function SymbioticLink_IsNullUUID(uuid)
    return (uuid == nil) or uuid:find('00000000[-]0000[-]0000[-]0000[-]000000000000$')
end

local function isValueInList(list, value)
    for _, item in ipairs(list) do
        if item == value then
            return true
        end
    end
    return false
end

local function SymbioticLink_StatusApplied(object, status, causee, storyActionID)
    -- print("SymbioticLink: StatusApplied: object: " .. object .. " status: " .. status .. " causee: " .. causee .. " storyActionID:" .. storyActionID)

    -- If Symbiotic Link is cast, make pointers between source and target
    if status == "MYSTIC_SYMBIOTIC_LINK" then
        -- print("SymbioticLink: Symbiotic Link cast, linking " .. object .. " and " .. causee)
        Osi.SetVarUUID(object, "SymbioticLink_Causee", causee)
        Osi.SetVarUUID(causee, "SymbioticLink_Target", object)
    end

    local linkedPartner = Osi.GetVarUUID(object, "SymbioticLink_Target")

    -- If you are linked and just received a valid status, apply it to your partner as well
    if isValueInList(SymbioticLinkApplyWhitelist, status)
    or isValueInList(SymbioticLinkApplyWhitelist_Exp, status)
    and not SymbioticLink_IsNullUUID(linkedPartner)
    then
        local statusDuration = Osi.GetStatusCurrentLifetime(object, status) or 1
        Osi.ApplyStatus(linkedPartner, status, statusDuration, 1, object)
    end
end

local function SymbioticLink_StatusRemoved(object, status, causee, applyStoryActionID)
    -- print("SymbioticLink: StatusRemoved: object: " .. object .. " status: " .. status .. " causee: " .. causee .. " applyStoryActionID: " .. applyStoryActionID)

    -- If Symbiotic Link is being removed, set the pointers to null
    if status == "MYSTIC_SYMBIOTIC_LINK_OWNER" then
        -- print("SymbioticLink: Setting SymbioticLink_Target on " .. object .. " to nil")
        Osi.SetVarUUID(object, "SymbioticLink_Target", SymbioticLink_NullUUID)
    elseif status == "MYSTIC_SYMBIOTIC_LINK" then
        -- print("SymbioticLink: Setting SymbioticLink_Causee on " .. object .. " to nil")
        Osi.SetVarUUID(object, "SymbioticLink_Causee", SymbioticLink_NullUUID)

        -- Remove specific statuses when losing Symbiotic Link
        -- for  _, statusName in ipairs(SymbioticLinkRemovedStatuses) do
        --    if statusName == status then
        --     Osi.RemoveStatus(object, statusName)
        --    end
        -- end

        -- for  _, statusName in ipairs(SymbioticLinkRemovedStatuses_Exp) do
        --     if statusName == status then
        --      Osi.RemoveStatus(object, statusName)
        --     end
        -- end
    end

    local linkedPartner = Osi.GetVarUUID(object, "SymbioticLink_Target")

    -- If you are linked and just lost a valid status, your partner loses it as well
    if isValueInList(SymbioticLinkRemoveWhitelist, status)
    or isValueInList(SymbioticLinkRemoveWhitelist_Exp, status)
    and not SymbioticLink_IsNullUUID(linkedPartner)
    then
        -- print("SymbioticLink: " .. object .. " lost status: " .. status .. ", removing it from " .. linkedPartner)
        Osi.RemoveStatus(linkedPartner, status)
    end
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", SymbioticLink_StatusApplied)
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", SymbioticLink_StatusRemoved)