-----------------------------------
-- ID: 16497
-- Item: Sleep Dagger
-- Additional Effect: Sleep
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.DARK, 0) <= 0.5) then
        return 0, 0, 0
    else
        local duration = 25
        if (target:getMainLvl() > player:getMainLvl()) then
            duration = duration - (target:getMainLvl() - player:getMainLvl())
        end
        duration = utils.clamp(duration, 1, 25)
        duration = duration * applyResistanceAddEffect(player, target, xi.magic.ele.DARK, 0)
        if (not target:hasStatusEffect(xi.effect.SLEEP_I)) then
            target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration)
        end
        return xi.subEffect.SLEEP, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.SLEEP_I
    end
end

return item_object
