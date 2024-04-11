PersistentVars = {}

local function RefundPsiCost(cost, entity)

    local psiPoints = entity.ActionResources.Resources["9ea5d3a5-b1f5-4f80-a5d5-9f419f8eb456"][1]
    if psiPoints then
        psiPoints.Amount = psiPoints.Amount + cost
        entity:Replicate("ActionResources")
        _P("Refunded psi point cost")
    end

end

local function BottomlessFlask_StatusApplied(object, status, causee, _)

    -- Move recently created entity to inventory
    if status == "MYSTIC_BOTTOMLESS_FLASK_REQUEST" then
        Osi.ToInventory(object, causee, 1, 0, 1)
    end

    -- Check if target is valid
    if status == "MYSTIC_BOTTOMLESS_FLASK"
    and Osi.IsConsumable(object) == 1
    then

        local bottomlessEntity = Ext.Entity.Get(object)
        bottomlessEntity.Value.Value = 0
        bottomlessEntity:Replicate("Value")
        PersistentVars[object] = true

    elseif status == "MYSTIC_BOTTOMLESS_FLASK"
    and Osi.IsConsumable(object) ~= 1
    then
        _P("This isn't a consumable you dummy")
        Osi.RemoveStatus(object, "MYSTIC_BOTTOMLESS_FLASK")
        local caster = Ext.Entity.Get(causee)
        RefundPsiCost(7, caster)
    end

    -- Remove Bottomless Flask status from every item in inventory
    if status == "MYSTIC_BOTTOMLESS_FLASK_REMOVE" then
        if Osi.IsCharacter(object) == 1 then
            local entity = Ext.Entity.Get(object)
            local inventory = entity.InventoryOwner.PrimaryInventory
            local inventoryItems = inventory.InventoryContainer.Items
            for k,v in pairs(inventoryItems) do
                local itemUuid = v.Item.Uuid.EntityUuid
                local itemName = v.Item.ServerItem.Template.Name
                local entry = itemName .. "_" .. itemUuid
                PersistentVars[entry] = nil
                if Osi.HasActiveStatus(itemUuid, "MYSTIC_BOTTOMLESS_FLASK") then
                    Osi.RemoveStatus(itemUuid, "MYSTIC_BOTTOMLESS_FLASK")
                end
            end
        end
    end
end

local function BottomlessFlask_UseStarted(character, item)

    -- _P("BottomlessFlask: UseStarted: " .. character .. ", " .. item)

    if Osi.GetStackAmount(item) == nil then return end

    if  Osi.HasActiveStatus(item, "MYSTIC_BOTTOMLESS_FLASK") == 1 then
        Osi.SetStackAmount(item, Osi.GetStackAmount(item)+1)
    end

end

local function BottomlessFlask_TemplateRemovedFrom(objectTemplate, object2, inventoryHolder)
    -- _P("TemplateRemovedFrom ") --  .. Osi.HasActiveStatus(object2, "MYSTIC_BOTTOMLESS_FLASK")

    if PersistentVars[object2] then
        -- PersistentVars[object2] = nil
        local x, y, z = Osi.GetPosition(inventoryHolder)
        local newPotion = Osi.CreateAt(objectTemplate, x, y, z, 0, 0, "")
        -- local newPotion = Osi.CreateAtObject(objectTemplate, inventoryHolder, 0, 0, "", 0)
        Osi.ApplyStatus(newPotion, "MYSTIC_BOTTOMLESS_FLASK", -1, 1, inventoryHolder)
        Osi.ApplyStatus(newPotion, "MYSTIC_BOTTOMLESS_FLASK_REQUEST", 0, 1, inventoryHolder)
    end
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", BottomlessFlask_StatusApplied)
Ext.Osiris.RegisterListener("UseStarted", 2, "before", BottomlessFlask_UseStarted)
Ext.Osiris.RegisterListener("TemplateRemovedFrom", 3, "before", BottomlessFlask_TemplateRemovedFrom)