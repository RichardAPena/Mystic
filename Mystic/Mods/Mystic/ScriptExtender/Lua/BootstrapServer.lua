Ext.Require("Server/MonkAnimations.lua")
Ext.Require("Server/FreecastPsiPoints.lua")
Ext.Require("Server/MysticHand.lua")

StatPaths = {
    -- "Public/Mystic/Stats/Generated/Data/Spell_Projectile.txt",
    -- "Public/Mystic/Stats/Generated/Data/Spell_Shout.txt",
    -- "Public/Mystic/Stats/Generated/Data/Spell_Target.txt",
    -- "Public/Mystic/Stats/Generated/Data/Status_BOOSTS.txt",
}

local function on_reset_completed()
    for _, statPath in ipairs(StatPaths) do
        Ext.Stats.LoadStatsFile(statPath,1)
    end
    _P('Reloading stats!')
end

Ext.Events.ResetCompleted:Subscribe(on_reset_completed)