
local hunterAspects = {
    ["Aspect of the Viper"]      = "|c003440eb",
    ["Aspect of the Dragonhawk"] = "|c00969696",
    -- "Aspect of the Beast",    --actually idk the utility of show it
    -- "Aspect of the Cheetah",  --actually idk the utility of show it
    -- "Aspect of the Hawk",     --actually idk the utility of show it
    -- "Aspect of the Monkey",   --actually idk the utility of show it
    -- "Aspect of the Pack",     --actually idk the utility of show it
    -- "Aspect of the Wild"      --actually idk the utility of show it
}


function setupAddon(self, event, ...) 
    print("|c0003C426(".."hunterSetup successfully loaded"..")")
    if UnitClass("player") == 'Hunter' then self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED") end -- Registering in my frame this event
end

function receiveRegisteredEvent(self, event, ...)
    local aspect = getActiveAspect()
    changeButtonColor(aspect)
end

function getActiveAspect()
    local activeAspect = nil
    for aspect, color in pairs(hunterAspects) do
        if UnitAura("player", aspect) ~= nil then activeAspect = aspect end
    end
    return activeAspect
end

function changeButtonColor(aspect)
    -- TODO Improve this verification, use constants    
    if aspect == "Aspect of the Viper" then createFrameTexture("Aspect of the Dragonhawk") end
    if aspect == "Aspect of the Dragonhawk" then createFrameTexture("Aspect of the Viper") end
end

function createFrameTexture(text)
    -- TODO Change it for a texture to just indicate buff using
    local btn = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
    btn:SetPoint("TOP")
    btn:SetSize(150, 40)
    btn:SetText(text)
    btn:SetScript("OnClick", function(self, button)
        CastSpellByName(text and "Aspect of the Viper" or "Aspect of the Dragonhawk", true);
	    print(text and "Aspect of the Viper" or "Aspect of the Dragonhawk" ..button)
    end)
end
