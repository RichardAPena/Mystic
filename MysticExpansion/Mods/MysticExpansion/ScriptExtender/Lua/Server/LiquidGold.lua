local function RefundPsiCost(cost, entity)

    local psiPoints = entity.ActionResources.Resources["9ea5d3a5-b1f5-4f80-a5d5-9f419f8eb456"][1]
    if psiPoints then
        psiPoints.Amount = psiPoints.Amount + cost
        entity:Replicate("ActionResources")
        _P("Refunded psi point cost")
    end

end

local function LiquidGold_StatusApplied(object, status, causee, _)

    -- _P("LiquidGold: StatusApplied: " .. object .. ", " .. status .. ", " .. causee)

    if status == "MYSTIC_LIQUID_GOLD" then
        local itemEntity = Ext.Entity.Get(object)
        local casterEntity = Ext.Entity.Get(causee)
        local itemTemplate = Osi.GetTemplate(object)

        if not itemEntity then
            _P("Object is null!")
            RefundPsiCost(3, casterEntity)
            return
        end

        if not casterEntity then
            _P("Caster is null!")
            return
        end

        -- Must be able to be picked up
        -- Must be moveable
        -- Cannot be a door
        -- Cannot be a story item
        -- Cannot be a ladder
        -- Cannot be reserved for dialog
        -- Cannot be invulnerable
        -- Cannot be a secret door
        -- Cannot be invulnerable2
        -- Cannot be a container
        -- Target cannot be a gold item

        -- _P()
        -- local isGold = string.find(itemTemplate, "1c3c9c74-34a1-4685-989e-410dc080be6f")
        local probablyGold = itemEntity.ServerItem.Template.Id == "1c3c9c74-34a1-4685-989e-410dc080be6f"
        -- _P("IS GOLD?: " .. tostring(isGold))
        -- _P("IS IT REALLY GOLD? " .. tostring(probablyGold))
        -- _D(itemEntity:GetAllComponents())

        if
        itemEntity.ServerItem.CanBeMoved and
        itemEntity.ServerItem.CanBePickedUp and
        not itemEntity.ServerItem.Invulnerable and
        not itemEntity.ServerItem.Invulnerable2 and
        Osi.IsContainer(object) == 0 and
        not itemEntity.ServerItem.IsDoor and
        not itemEntity.ServerItem.IsLadder and
        not itemEntity.ServerItem.IsSecretDoor and
        not itemEntity.ServerItem.ReservedForDialog and
        not itemEntity.ServerItem.StoryItem and
        not probablyGold
        then
            local goldAmount = itemEntity.Value.Value * 3 * Osi.GetStackAmount(object)
            Osi.AddGold(causee, goldAmount)
            Osi.RequestDelete(object)
        else
            _P("Nice try")
            RefundPsiCost(3, casterEntity)
        end

    end

end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", LiquidGold_StatusApplied)