local background = CreateFrame("Frame", "background", UIParent)

local msgFrame = CreateFrame("FRAME", nil, UIParent)
msgFrame:SetWidth(1)
msgFrame:SetHeight(1)
msgFrame:SetPoint("TOP")
msgFrame:SetFrameStrata("TOOLTIP")
msgFrame.text = msgFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
msgFrame.text:SetTextHeight(15)
msgFrame.text:SetPoint("TOP")

local msgPetInfoFrame = CreateFrame("FRAME", nil, UIParent)
msgPetInfoFrame:SetWidth(1)
msgPetInfoFrame:SetHeight(1)
msgPetInfoFrame:SetPoint("CENTER")
msgPetInfoFrame:SetFrameStrata("TOOLTIP")
msgPetInfoFrame.text = msgPetInfoFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
msgPetInfoFrame.text:SetTextColor(1,0,0,1)
msgPetInfoFrame.text:SetTextHeight(20)
msgPetInfoFrame.text:SetPoint("CENTER")

local hunterAspects = {
    ["Aspect of the Viper"]      = {0,0,1, .2},
    ["Aspect of the Dragonhawk"] = {0,0,0, .0},
    ["Aspect of the Pack"]       = {1,1,1, .2}
}

local hunterTracks = {
    ["Track Beasts"]       = {"Beast",1},
    ["Track Demons"]       = {"Demon",2},
    ["Track Dragonkin"]    = {"Dragonkin",3},
    ["Track Elementals"]   = {"Elemental",4},
    ["Track Giants"]       = {"Giant",5},
    --["Track Hidden"]       {"Hidden",6},
    ["Track Humanoids"]    = {"Humanoid",7},
    ["Track Undead"]       = {"Undead",8},
}

local eventsToRegister = {
    "UNIT_AURA",
    "PLAYER_TARGET_CHANGED"
    --"UNIT_COMBAT"
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
    
    if UnitClass("player") == 'Hunter' and UnitLevel("player") == 80 then 
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
        isPetAlive()
    end
    if event == eventsToRegister[2] then changeToCorrectlyTrack() end   
end

function isPetAlive()
    if(UnitExists("pet") ~= 1 and not IsMounted()) then
        msgPetInfoFrame.text:SetText("NO PET")
    else
        msgPetInfoFrame.text:SetText("")
    end
end

function changeToCorrectlyTrack()
    for track, creatureType in pairs(hunterTracks) do
        if(UnitCreatureType("target") == creatureType[1]) then
            SetTracking(creatureType[2],true);
            break
        end    
    end
end

function changeWindowColorByActiveAspect()
    for aspect, color in pairs(hunterAspects) do
        if UnitAura("player", aspect) ~= nil then
            changeWindowColor(aspect,color)
            return
        else
            changeWindowColor("No aspect",{1,0,0, .1})
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