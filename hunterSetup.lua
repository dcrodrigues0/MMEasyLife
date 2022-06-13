local background = CreateFrame("Frame", "background", UIParent)

local msgFrame = CreateFrame("FRAME", nil, UIParent)
msgFrame:SetWidth(1)
msgFrame:SetHeight(1)
msgFrame:SetPoint("CENTER")
msgFrame:SetFrameStrata("TOOLTIP")
msgFrame.text = msgFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
msgFrame.text:SetPoint("CENTER")

local timer = CreateFrame("FRAME");

local hunterAspects = {
    ["Aspect of the Viper"]      = {0,0,1, .2},
    ["Aspect of the Dragonhawk"] = {0,0,0, .2},
    ["Aspect of the Pack"]       = {1,1,1, .2}
}

local eventsToRegister = {
    "UNIT_AURA"
} 

function replaceDashWithSpace(string)
    return (string:gsub("_", " "))
end

function split(string, expression)
    local splittedlist = {}
    for i in string.gmatch(string, "([^"..expression.."]+)") do
        table.insert(splittedlist, i)
     end
     return splittedlist
end

function setupAddon(self, event, ...) 
    print("|c0003C426(".."hunterSetup successfully loaded"..")")
    
    if UnitClass("player") == 'Hunter' then 
        registerNecessaryEvents(self)
    end
end

function registerNecessaryEvents(self)
    for _, event in pairs(eventsToRegister) do
        self:RegisterEvent(event)
    end
end

function receiveRegisteredEvent(self, event, ...)
    
    if event == eventsToRegister[1] then 
        changeWindowColorByActiveAspect() 
        printIfWrongTrackingIsActive()
    end

end

function printIfWrongTrackingIsActive()
    --TODO CREATE THIS FUNCTIONS
    print(UnitCreatureType("target"))
end

function changeWindowColorByActiveAspect()
    for aspect, color in pairs(hunterAspects) do
        if UnitAura("player", aspect) ~= nil then
            changeWindowColor(aspect,color)
            return
        else
            changeWindowColor(aspect,{0,0,0, .0})
        end
    end
end

function changeWindowColor(aspect, color)
    local resolution = getCurrentlyActiveResolution()
    background:SetSize(resolution[1], resolution[2])
    background:SetPoint("CENTER")
    background:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeSize = 1,
    })
    background:SetBackdropColor(color[1], color[2], color[3], color[4])
    showActiveAspect(aspect)
end

function showActiveAspect(aspect)
    --TODO ADD SOME TIMER TO ERASE MESSAGE AFTER SOME SECONDS
    msgFrame.text:SetText(aspect)
end

function getCurrentlyActiveResolution()
    local resolutions = {GetScreenResolutions()}
    for indexResolution, resolution in pairs(resolutions) do
        if indexResolution == GetCurrentResolution() then 
            return split(resolution,"x")
        end
    end
end