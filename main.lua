function love.load()

end
local circle = { x = 400, y = 300, radius = 50 }
local showCircle = true
local points = 0
local mousex, mousey = 0, 0


function love.update(dt)
    mousex = love.mouse.getX()
    mousey = love.mouse.getY()
    if showCircle and (mousex - circle.x)^2 + (mousey - circle.y)^2 <= circle.radius^2 then
        points = points + 1
        circle.x = math.random(50, 750)
        circle.y = math.random(50, 550)
    end
end

function love.draw()
    if showCircle then
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("fill", circle.x, circle.y, circle.radius)
        love.graphics.setColor(1, 1, 1)
    end
        love.graphics.print("Mouse X: " .. mousex .. " Mouse Y: " .. mousey, 10, 10)
        love.graphics.print("Points: " .. points, 10, 30)
end
