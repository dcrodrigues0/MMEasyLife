--TODO transform hunterAspects in a key-value with the respective color of aspect
local hunterAspects = {
    ["Aspect of the Viper"]      = "|c003440eb",
    ["Aspect of the Dragonhawk"] = "|c00969696",
    -- "Aspect of the Beast", --actually idk the utility of show it
    -- "Aspect of the Cheetah", --actually idk the utility of show it
    -- "Aspect of the Hawk", --actually idk the utility of show it
    -- "Aspect of the Monkey", --actually idk the utility of show it
    -- "Aspect of the Pack", --actually idk the utility of show it
    -- "Aspect of the Wild" --actually idk the utility of show it
}


function setupAddon(self, event, ...) 
    print("|c0003C426(".."hunterSetup successfully loaded"..")")
    self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED") -- Registering in my frame this event
end

function receiveRegisteredEvent(self, event, ...)
    local aspect = getActiveAspect()
    print(aspect)
    -- print(UnitAura("player",hunterAspects[1]))
    -- print(UnitAura("player",hunterAspects[2]))
    -- print(UnitChannelInfo("player"))
end

function getActiveAspect()
    local activeAspect = nil
    for key, value in pairs(hunterAspects) do
        if UnitAura("player", key) ~= nil then activeAspect = key end
    end
    return activeAspect
end

function changeWindowColor()
    --TODO implement change window color
end
