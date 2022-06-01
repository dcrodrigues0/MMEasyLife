local background = CreateFrame("Frame", "background", UIParent)

local hunterAspects = {
    ["Aspect_of_the_Viper"]      = {0,0,1, .2},
    ["Aspect_of_the_Dragonhawk"] = {0,0,0, .2},
    ["Aspect_of_the_Pack"]       = {1,1,1, .2}
}

local eventsToRegister = {
    "CURRENT_SPELL_CAST_CHANGED", --TODO Use better event to get when the player change aspect
    "UNIT_SPELLCAST_SENT"
} 

function replaceDashWithSpace(string)
    return (string:gsub("_", " "))
end

function setupAddon(self, event, ...) 
    print("|c0003C426(".."hunterSetup successfully loaded"..")")
    
    if UnitClass("player") == 'Hunter' then 
        registerNecessaryEvents(self)
    end
end

function registerNecessaryEvents(self)
    --TODO there is a bug with this loop and de ocurrence of window colors, resolve it
    for _, event in pairs(eventsToRegister) do
        self:RegisterEvent(event)
    end
end

function receiveRegisteredEvent(self, event, ...)
    if event == eventsToRegister[1] then changeWindowColorByActiveAspect() end
    if event == eventsToRegister[2] then printIfWrongTrackingIsActive() end
    
end

function printIfWrongTrackingIsActive()
    --TODO CREATE THIS FUNCTIONS
    print(UnitCreatureType("target"))
end

function changeWindowColorByActiveAspect()
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
    --TODO GET SCREEN RESOLUTION GetScreenWidth(); TO DEFINE IN SETSIZE
    --TODO IMPROVE THIS "WINDOW CHANGE COLOR" FOR A ANIMATED TEXT IN MIDDLE OF SCREEN
    background:SetSize(1920, 1080)
    background:SetPoint("CENTER")
    background:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeSize = 1,
    })
    background:SetBackdropColor(color[1], color[2], color[3], color[4])
end
