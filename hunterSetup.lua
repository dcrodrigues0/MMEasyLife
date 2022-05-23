--TODO transform hunterAspects in a key-value with the respective color of aspect
local hunterAspects = {
    "Aspect of the Viper",
    "Aspect of the Dragonhawk",
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
    local aspectViper = UnitAura("player",hunterAspects[1])
    local aspectDragonhawk = UnitAura("player",hunterAspects[2])

    if aspectViper ~= nil then return aspectViper end
    if aspectDragonhawk ~= nil then return aspectDragonhawk end
end

function changeWindowColor()
    
end
