function love.load()
debug = true
x = 0
y = 0
points = 0
tsize = 50
tposx = math.random(50, 750)
tposy = math.random(50, 550)
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
    love.graphics.rectangle("fill",x,y,10,10)
    love.graphics.circle("fill", tposx, tposy, tsize)
    if math.sqrt((x - tposx)^2 + (y - tposy)^2) < 50  then
        points = points + 1
        tposx = math.random(50, 750)
        tposy = math.random(50, 550)
    end
    love.graphics.setColor(0, 255, 255)
    -- draw menu using a rectangle
    love.graphics.rectangle("line", 0, 0, 200, 600)
    love.graphics.setColor(255, 255, 255)
    if debug then
        love.graphics.print("Debug Mode: ON", 10, 550)

    end
    -- block target from being drawn over the menu by limiting its position
    if tposx < 200 then 
        tposx = 200
    end
    if tposy < 0 then 
        tposy = 0
    end
    -- draw first upgrade button
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", 10, 100, 180, 50)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Upgrade 1", 20, 110)
    -- make it so if clicked, it decreases the size of the target
    if love.mouse.isDown(1) and x > 10 and x < 190 and y > 100 and y < 150 then
        if tsize > 10 then
            tsize = tsize - 5
            points = points - 1
        end
    end
end