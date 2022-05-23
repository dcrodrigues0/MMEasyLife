local hunterAspects = {
    "Aspect of the Viper",
    "Aspect of the Dragonhawk",
    "Aspect of the Beast",
    "Aspect of the Cheetah",
    "Aspect of the Hawk",
    "Aspect of the Monkey",
    "Aspect of the Pack",
    "Aspect of the Wild"}


function setupAddon(self, event, ...) 
    print("|c98FB98ff(".."hunterSetup successfully loaded"..")")
    self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED") -- Registering in my frame this event
end

function filterEvent(self, event, ...)
    print(UnitAura("player",hunterAspects[1]))
    print(UnitChannelInfo("player"))
end


