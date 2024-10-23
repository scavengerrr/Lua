-- Created by Scavengerrr (github.com/scavengerrr)


local DungeonMaster = {}
DungeonMaster.dungeons = {}

-- Create a frame for the UI
local frame = CreateFrame("Frame", "DungeonMasterFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(300, 400)  -- Width, Height
frame:SetPoint("CENTER")  -- Position in the middle of the screen
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

-- Title of the frame
frame.title = frame:CreateFontString(nil, "OVERLAY")
frame.title:SetFontObject("GameFontHighlight")
frame.title:SetPoint("CENTER", frame.TitleBg, "CENTER", 0, 0)
frame.title:SetText("Dungeon Master Tracker")

-- Button to close the UI
local closeButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
closeButton:SetSize(80, 30)  -- Width, Height
closeButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
closeButton:SetText("Close")
closeButton:SetScript("OnClick", function()
    frame:Hide()  -- Hide the UI when the close button is clicked
end)

-- ScrollFrame to hold dungeon data
local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetSize(260, 300)
scrollFrame:SetPoint("TOP", 0, -40)

-- Create a content frame within the scrollable area
local content = CreateFrame("Frame", nil, scrollFrame)
content:SetSize(260, 300)
scrollFrame:SetScrollChild(content)

-- A function to update the UI with dungeon run data
function DungeonMaster:UpdateUI()
    -- Remove old dungeon data (if any)
    if content.dungeonTexts then
        for _, text in pairs(content.dungeonTexts) do
            text:SetText("")
        end
    end

    content.dungeonTexts = {}

    -- Display dungeon runs
    for i, dungeon in ipairs(self.dungeons) do
        local dungeonText = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        dungeonText:SetPoint("TOPLEFT", 10, -30 * i)
        dungeonText:SetText(i .. ". " .. dungeon.dungeon .. " (" .. dungeon.difficulty .. ") - " .. dungeon.time .. " sec")
        table.insert(content.dungeonTexts, dungeonText)
    end
end

-- Command to open the UI via slash command
SLASH_DUNGEONMASTER1 = "/dungeonmaster"
SlashCmdList["DUNGEONMASTER"] = function()
    frame:Show()
    DungeonMaster:UpdateUI()  -- Update the UI with the latest data
end

-- Add dungeon tracking code here
-- (Existing code from before for dungeon tracking, loot, etc.)

