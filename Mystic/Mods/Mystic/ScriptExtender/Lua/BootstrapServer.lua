---Make Phantom Knife penetrate 10 AC
-- -@param e EsvLuaBeforeDealDamageEvent
-- local function PhantomKnifePenetrateAC(e)
--     if e.Hit.SpellId == "Target_Mystic_PhantomKnife" then
--         local roll = e.Hit.ConditionRolls[1]
--         -- roll.Difficulty = math.max(0, roll.Difficulty - 10)
--         roll.Difficulty = math.max(0, 10)
--         -- roll.Difficulty = 10
--     end
-- end

-- Ext.Events.BeforeDealDamage:Subscribe(PhantomKnifePenetrateAC)

Ext.Require("Server/MonkAnimations.lua")