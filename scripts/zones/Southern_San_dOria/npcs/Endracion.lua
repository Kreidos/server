-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Endracion
-- !pos -110 1 -34 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local currentMission = player:getCurrentMission(SANDORIA)
    local TheCSpringCompleted = player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_CRYSTAL_SPRING)
    local Count = trade:getItemCount()

    if currentMission ~= xi.mission.id.sandoria.NONE then
        if currentMission == xi.mission.id.sandoria.THE_CRYSTAL_SPRING and trade:hasItemQty(4528, 1) and Count == 1 and TheCSpringCompleted == false then -- Trade Crystal Bass
            player:startEvent(1030) -- Dialog During Mission "The Crystal Spring"
        elseif currentMission == xi.mission.id.sandoria.THE_CRYSTAL_SPRING and trade:hasItemQty(4528, 1) and Count == 1 and TheCSpringCompleted then -- Trade Crystal Bass
            player:startEvent(1013) -- Finish Mission "The Crystal Spring" (repeat)
        else
            player:startEvent(1008) -- Wrong Item
        end
    else
        player:startEvent(1010) -- Mission not activated
    end

end

entity.onTrigger = function(player, npc)

    local PresOfPapsqueCompleted = player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE)

    if (player:getNation() ~= xi.nation.SANDORIA) then
        player:startEvent(1011) -- for Non-San d'Orians
    else
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getMissionStatus(player:getNation())
        local pRank = player:getRank(player:getNation())
        local cs, p, offset = getMissionOffset(player, 1, currentMission, missionStatus)

        if currentMission <= xi.mission.id.sandoria.THE_SHADOW_LORD and (cs ~= 0 or offset ~= 0) then
            if (cs == 0) then
                player:showText(npc, ID.text.ORIGINAL_MISSION_OFFSET + offset) -- dialog after accepting mission
            else
                player:startEvent(cs, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8])
            end
        elseif currentMission == xi.mission.id.sandoria.RANPERRE_S_FINAL_REST and player:hasKeyItem(xi.ki.ANCIENT_SANDORIAN_BOOK) then
            player:startEvent(1035)
        elseif currentMission == xi.mission.id.sandoria.RANPERRE_S_FINAL_REST and player:getMissionStatus(player:getNation()) == 4 then
            if player:getLocalVar("RanperresRest") == 1 then -- Requires player to zone.
                player:startEvent(1037)
            else
                player:startEvent(1039)
            end
        elseif currentMission == xi.mission.id.sandoria.RANPERRE_S_FINAL_REST and player:getMissionStatus(player:getNation()) == 7 then
            player:startEvent(1033)
        elseif currentMission ~= xi.mission.id.sandoria.THE_SECRET_WEAPON and pRank == 7 and PresOfPapsqueCompleted == true and getMissionRankPoints(player, 19) and player:getCharVar("SecretWeaponStatus") < 2 then
            player:startEvent(1041)
        elseif currentMission == xi.mission.id.sandoria.THE_SECRET_WEAPON and player:getCharVar("SecretWeaponStatus") == 3 then
            player:startEvent(1043)
        elseif currentMission ~= xi.mission.id.sandoria.NONE then
            player:startEvent(1001) -- Have mission already activated
        else
            local mission_mask, repeat_mask = getMissionMask(player)
            player:startEvent(1009, mission_mask, 0, 0 , 0 , 0 , repeat_mask) -- Mission List
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- printf("onFinishCSID: %u", csid)
    -- printf("onFinishOPTION: %u", option)

    finishMissionTimeline(player, 1, csid, option)
    if csid == 1035 then
        player:delKeyItem(xi.ki.ANCIENT_SANDORIAN_BOOK)
        player:setLocalVar("RanperresRest", 1) -- set to require a zone
        player:setMissionStatus(player:getNation(), 4)
    elseif csid == 1039 then
        player:setMissionStatus(player:getNation(), 5)
    elseif csid == 1033 then
        finishMissionTimeline(player, 2, csid, option)
    elseif csid == 1041 and player:getCharVar("SecretWeaponStatus") == 0 then
        player:setCharVar("SecretWeaponStatus", 1)
    elseif csid == 1043 then
        finishMissionTimeline(player, 2, csid, option)
    end
end

return entity
