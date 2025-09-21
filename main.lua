-- window title and size
love.window.setTitle("Circle Clicker")
love.window.setMode(800, 600)
-- variables
local circles = {}
local showCircles = true
local showUpgrades = true
local points = 0
local gain = 1
local mousex, mousey = 0, 0
local targetsamount = 1
local baseRadius = 10
local devmode = true
    -- sleep function
function sleep (a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do 
    end 
end
    -- upgrades table
upgrades = {
    { name = "Increase Circle Size", cost = 10, effect = function()
        for _, c in ipairs(circles) do
            c.radius = c.radius + 1
        end
    end },
    { name = "Increase Points Gain", cost = 20, effect = function() gain = gain + 1 end },
    { name = "Super Upgrade", cost = 30, effect = function()
        for _, c in ipairs(circles) do
            c.radius = c.radius + 2
        end
        gain = gain + 2
    end },
    { name = "rebirth", cost = 100, effect = function()
            points = 0
            gain = gain + 1
            baseRadius = baseRadius + 1
            targetsamount = targetsamount + 1
            spawnCircles(targetsamount)
    end },
    
    { name = "Toggle Upgrades", cost = 0, effect = function() showUpgrades = not showUpgrades end },
}
buttons = {
    { x = 650, y = 10, width = 140, height = 40, text = "Upgrade (10 points)" },
    { x = 650, y = 60, width = 140, height = 40, text = "Upgrade2 (20 points)" },
    { x = 650, y = 110, width = 140, height = 40, text = "Upgrade3 (30 points)" },
    { x = 650, y = 200, width = 140, height = 40, text = "Rebirth (100 points)" },
    { x = 650, y = 300, width = 140, height = 40, text = "Toggle Upgrades" },
}
    -- spawn circles function
local function spawnCircles(n)
    circles = {}
    for i = 1, n do
        table.insert(circles, {
            x = math.random(50, 750),
            y = math.random(50, 550),
            radius = baseRadius
        })
    end
end

spawnCircles(targetsamount)
    -- update function ( draws mouse position and checks for clicks on circles and upgrade buttons )
function love.update(dt)
    mousex = love.mouse.getX()
    mousey = love.mouse.getY()
    
    if showCircles then
        for i, c in ipairs(circles) do
            if (mousex - c.x)^2 + (mousey - c.y)^2 <= c.radius^2  and love.mouse.isDown(1) then
                points = points + gain
                sleep(0.2)
                c.x = math.random(50, 750)
                c.y = math.random(50, 550)
            end
        end
    end

    if love.mouse.isDown(1) then
        if mousex >= 650 and mousex <= 790 and mousey >= 10 and mousey <= 50 then
            if points >= upgrades[1].cost then
                sleep(0.2)
                points = points - upgrades[1].cost
                upgrades[1].effect()
            end
        end
        if mousex >= 650 and mousex <= 790 and mousey >= 60 and mousey <= 100 then
            if points >= upgrades[2].cost then
                sleep(0.2)
                points = points - upgrades[2].cost
                upgrades[2].effect()
            end
        end
        if mousex >= 650 and mousex <= 790 and mousey >= 110 and mousey <= 150 then
            if points >= upgrades[3].cost then
                sleep(0.2)
                points = points - upgrades[3].cost
                targetsamount = targetsamount + 1
                upgrades[3].effect()
                spawnCircles(targetsamount)
            end
        end
        if mousex >= 650 and mousex <= 790 and mousey >= 200 and mousey <= 240 then
            if points >= 100 then
                sleep(0.2)
                points = 0
                gain = gain + 1
                baseRadius = baseRadius + 1
                targetsamount = targetsamount + 1
                spawnCircles(targetsamount)
            end
        end
        if mousex >= buttons[5].x and mousex <= 790 and mousey >= buttons[5].y and mousey <= 340 then
            sleep(0.2)
            showUpgrades = not showUpgrades
        end
    end 
    if devmode and love.keyboard.isDown("r") then
        points = 9999
    end
    if devmode and love.keyboard.isDown("t") then
        gain = gain + 1
    end
    if devmode and love.keyboard.isDown("y") then
        baseRadius = baseRadius + 1
        for _, c in ipairs(circles) do
            c.radius = c.radius + 1
        end
    end
end

function love.draw()
    -- draw a small pointer circle at mouse position
    love.graphics.setColor(0, 1, 0)
    love.graphics.circle("line", mousex, mousey, 5)
    love.graphics.setColor(1, 1, 1)
    -- draw upgrade buttons
    if showUpgrades then
    love.graphics.rectangle("line", 650, 10, 140, 40)
    love.graphics.print("Upgrade (10 points)", 660, 20)
    love.graphics.rectangle("line", 650, 60, 140, 40)
    love.graphics.print("Upgrade2 (20 points)", 660, 70)
    love.graphics.rectangle("line", 650, 110, 140, 40)
    love.graphics.print("Upgrade3", 660, 120)
    -- add rebirth menu
    love.graphics.rectangle("line", 650, 200, 140, 40)
    love.graphics.print("Rebirth (100 points)", 660, 210)
    end
    love.graphics.print("Targets: " .. targetsamount, 10, 50)
    love.graphics.print("Radius: " .. (circles[1] and circles[1].radius or baseRadius), 10, 70)
    love.graphics.print("Points Gain: " .. gain, 10, 90)
    -- draw circles
    if showCircles then
        for _, c in ipairs(circles) do
            love.graphics.setColor(1, 0, 0)
            love.graphics.circle("fill", c.x, c.y, c.radius)
            love.graphics.setColor(1, 1, 1)
        end
        if devmode then
        love.graphics.print("Mouse X: " .. mousex .. " Mouse Y: " .. mousey, 10, 10)
        end
        love.graphics.print("Points: " .. points, 10, 30)
    end
    -- add button to hide and show upgrade buttons
    love.graphics.print("Toggle Upgrades", 660, 310)
    love.graphics.rectangle("line", 650, 300, 140, 40)

end