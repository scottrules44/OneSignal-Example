local widget = require("widget")
local json = require("json")
local onesignal = require "plugin.OneSignal"


local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
background:setFillColor(0.1, 0.2, 0.3) -- Dark blue background

-- Title
local title = display.newText({
    text = "OneSignal API Sample",
    x = display.contentCenterX,
    y = 50,
    font = native.systemFontBold,
    fontSize = 24
})
title:setFillColor(1, 1, 1) 
-- Initialize OneSignals
onesignal.init("a97e658a-dfe0-11e4-be57-27b89864d443")

onesignal.addClickListener(function(e)
    print("Got Notification")
    print(json.encode(e.data))
end)

local function onButtonPress(event)
    local id = event.target.id
    print(id)
    if id == "addTag" then
        onesignal.addTag("user_type", "premium")
    elseif id == "removeTag" then
        onesignal.removeTag("user_type")
    elseif id == "getTags" then
        local tags = onesignal.getTags()
        print("Tags: ", json.encode(tags))
    elseif id == "login" then
        onesignal.login("test_user_123")
        print("Login")
    elseif id == "logout" then
        onesignal.logout()
    elseif id == "requestPermission" then
        onesignal.requestPermission(true, function(event)
            print("Permission granted: ", event.accepted)
        end)
    elseif id == "sendOutcome" then
        onesignal.addOutcome("purchase")
    end
end

-- Create buttons
local buttonParams = {
    {id = "addTag", label = "Add Tag", x = display.contentCenterX, y = 100},
    {id = "removeTag", label = "Remove Tag", x = display.contentCenterX, y = 160},
    {id = "getTags", label = "Get Tags", x = display.contentCenterX, y = 220},
    {id = "login", label = "Login", x = display.contentCenterX, y = 280},
    {id = "logout", label = "Logout", x = display.contentCenterX, y = 340},
    {id = "requestPermission", label = "Request Permission", x = display.contentCenterX, y = 400},
    {id = "sendOutcome", label = "Send Outcome", x = display.contentCenterX, y = 460}
}

local function createButton(params)
    local button = display.newText({
        text = params.label,
        x = params.x,
        y = params.y,
        font = native.systemFont,
        fontSize = 18
    })
    button.id = params.id
    button:setFillColor(0.2, 0.6, 0.2)  -- Green button color

    -- Add functionality for buttons (you can replace with your actual logic)
    button:addEventListener("touch", function(event)
        if(event.phase == "ended") then
            print(button.id .. " button tapped!")
            onButtonPress(event)
            -- Handle button action here (e.g., call functions)
        end
    end)

    return button
end
-- Create all buttons
for i = 1, #buttonParams do
    createButton(buttonParams[i])
end
