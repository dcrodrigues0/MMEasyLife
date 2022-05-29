local hunterAspects = {
    ["Aspect_of_the_Viper"]      = "c003440eb",
    ["Aspect_of_the_Dragonhawk"] = "c00969696"
}

function replaceDashWithSpace(string)
    return (string:gsub("_", " "))
end

function setupAddon(self, event, ...) 
    print("|c0003C426(".."hunterSetup successfully loaded"..")")
    if UnitClass("player") == 'Hunter' then self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED") end -- Registering in my frame this event
end

function receiveRegisteredEvent(self, event, ...)
    changeWindowColorByAspect()
end

function changeWindowColorByAspect()
    for aspect, color in pairs(hunterAspects) do
        if UnitAura("player", replaceDashWithSpace(aspect)) ~= nil then
            changeWindowColor(color)
        end
    end
end

function changeWindowColor(color)
    
end
