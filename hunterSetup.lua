local background = CreateFrame("Frame", "background", UIParent)

local hunterAspects = {
    ["Aspect_of_the_Viper"]      = {0,0,1, .2},
    ["Aspect_of_the_Dragonhawk"] = {0,0,0, .2},
    ["Aspect_of_the_Pack"]       = {1,1,1, .2}
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
            return
        else
            changeWindowColor({0,0,0, .0})
        end
    end
end

function changeWindowColor(color)

    background:SetSize(1920, 1080)
    background:SetPoint("CENTER")

    background:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeSize = 1,
    })
    background:SetBackdropColor(color[1], color[2], color[3], color[4])

end
