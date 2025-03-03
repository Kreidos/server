-----------------------------------
-- Area: Windurst-Jeuno_Airship
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.WINDURST_JEUNO_AIRSHIP] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        WILL_REACH_JEUNO        = 7050, -- The airship will reach Jeuno in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (# [minute/minutes] in Earth time).
        WILL_REACH_WINDURST     = 7051, -- The airship will reach Windurst in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (# [minute/minutes] in Earth time).
        IN_JEUNO_MOMENTARILY    = 7052, -- We will be arriving in Jeuno momentarily.
        IN_WINDURST_MOMENTARILY = 7053, -- We will be arriving in Windurst momentarily.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.WINDURST_JEUNO_AIRSHIP]
