Ext.Require("Server/IntelligenceThrow.lua")
Ext.Require("Server/PsychicDouble.lua")
Ext.Require("Server/SymbioticLink.lua")
Ext.Require("Server/WarAdept.lua")
Ext.Require("Server/MonkAnimations.lua")
Ext.Require("Server/PsionicFists.lua")
Ext.Require("Server/EtherealFusion.lua")
Ext.Require("Server/BottomlessFlask.lua")
Ext.Require("Server/LiquidGold.lua")


StatPaths = {
    -- "Public/MysticExpansion/Stats/Generated/Data/Spell_Target.txt",
    -- "Public/MysticExpansion/Stats/Generated/Data/Status_BOOSTS.txt",
}

local function on_reset_completed()
    for _, statPath in ipairs(StatPaths) do
        Ext.Stats.LoadStatsFile(statPath,1)
    end
    -- _P('Reloading stats!')
end

Ext.Events.ResetCompleted:Subscribe(on_reset_completed)