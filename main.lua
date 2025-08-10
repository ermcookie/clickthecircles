-- Global variables
debug = true
x = 0
y = 0
points = 0
tsize = 50
tposx = 0
tposy = 0
numTargets = 1

function love.load()
    -- Initialization if needed
end

function drawTarget()
    for i = 1, numTargets do
        love.graphics.setColor(0, 255, 0)
        love.graphics.circle("fill", tposx, tposy, tsize)
        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("line", tposx, tposy, tsize)
    end
    -- Randomize target position for each target
    tposx = math.random(200, 750)
    tposy = math.random(0, 550)
    -- Ensure the target is not drawn over the menu
    if tposx < 200 then
        tposx = 200
    end
end

function love.update(dt)
    x = love.mouse.getX()
    y = love.mouse.getY()
end

function love.draw()
    if debug then
        love.graphics.print("X: " .. x .. " Y: " .. y, 10, 10)
    end
    love.graphics.print("Points: " .. points, 10, 30)
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", x, y, 10, 10)
    drawTarget(numTargets)
    -- check if the mouse is within the target's radius
    -- if so, increase points and move target to a new random position
    if math.sqrt((x - tposx)^2 + (y - tposy)^2) < tsize then
        points = points + 1
        tposx = math.random(200, 750)
        tposy = math.random(0, 550)
    end
    love.graphics.setColor(0, 255, 255)
    -- draw menu using a rectangle
    love.graphics.rectangle("line", 0, 0, 200, 600)
    love.graphics.setColor(255, 255, 255)
    if debug then
        love.graphics.print("Debug Mode: ON", 10, 550)
    end
    -- block target from being drawn over the menu by limiting its position
    -- draw first upgrade button
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", 10, 100, 180, 50)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("decrease size", 20, 110)
    -- make it so if clicked, it decreases the size of the target
    if love.mouse.isDown(1) and x > 10 and x < 190 and y > 100 and y < 150 and points >= 1 then
        if tsize > 10 then
            tsize = tsize - 1
            points = points - 1
        end
    end
    -- draw second upgrade button
    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", 10, 200, 180, 50)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("increase amount of targets", 20, 210)
    -- make it so if clicked, it increases the amount of targets drawn
    if love.mouse.isDown(1) and x > 10 and x < 190 and y > 200 and y < 250 and points >= 2 then
        numTargets = numTargets + 1
        points = points - 2
    end
end