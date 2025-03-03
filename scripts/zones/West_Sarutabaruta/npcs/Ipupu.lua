-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Ipupu
-- Note: Involved in Quest "Glyph Hanger"
-- !pos 251.745 -5.5 35.539 115
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.NOTES_FROM_HARIGAORIGA) then
        player:startEvent(47, 0, xi.ki.NOTES_FROM_HARIGAORIGA)
    else
        player:showText(npc, ID.text.IPUPU_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 47 then
        player:delKeyItem(xi.ki.NOTES_FROM_HARIGAORIGA)
        player:addKeyItem(xi.ki.NOTES_FROM_IPUPU)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.NOTES_FROM_IPUPU)
    end
end

return entity
