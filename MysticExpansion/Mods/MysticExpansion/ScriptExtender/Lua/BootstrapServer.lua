Ext.Require("Server/IntelligenceThrow.lua")
Ext.Require("Server/PsychicDouble.lua")
Ext.Require("Server/SymbioticLink.lua")
Ext.Require("Server/WarAdept.lua")

StatPaths={
    "Public/MysticExpansion/Stats/Generated/Data/Spell_Target.txt",
    "Public/MysticExpansion/Stats/Generated/Data/Spell_Shout.txt",
    "Public/MysticExpansion/Stats/Generated/Data/Status_BOOSTS.txt",
    -- "Public/MysticExpansion/Stats/Generated/Data/FileName4.txt",
    -- "Public/MysticExpansion/Stats/Generated/Data/FileName5.txt",
    -- "Public/MysticExpansion/Stats/Generated/Data/FileName6.txt",
    -- "Public/MysticExpansion/Stats/Generated/Data/FileName7.txt",
    -- "Public/MysticExpansion/Stats/Generated/Data/FileName8.txt",
    -- "Public/MysticExpansion/Stats/Generated/Data/FileName9.txt",
    -- "Public/MysticExpansion/Stats/Generated/Data/FileName10.txt",
}

local function on_reset_completed()
    for _, statPath in ipairs(StatPaths) do
        Ext.Stats.LoadStatsFile(statPath,1)
    end
    _P('Reloading stats!')
end

Ext.Events.ResetCompleted:Subscribe(on_reset_completed)