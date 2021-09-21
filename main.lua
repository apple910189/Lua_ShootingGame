function love.load()
    target = {}
    target.c = 4
    target.x = 300
    target.y = 300
    target.radius = 50
    score = 0
    timer = 0
    gameState = 1
    gameFont = love.graphics.newFont(40)
    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')
    sprites.target = love.graphics.newImage('sprites/target.png')
    love.mouse.setVisible(false)
end
-- this update function runs 60 times per secon, and dt = 1/60
function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end
    if timer < 0 then
        timer = 0
        gameState = 1  
    end
end

function love.draw()
    love.graphics.draw(sprites.sky,0,0)
    --love.graphics.setColor(1,0,0)
    --love.graphics.circle("fill", target.x, target.y, target.radius)
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: "..score,0,0)
    love.graphics.print("Time: "..math.ceil(timer),300,0)

    if gameState == 1 then
        love.graphics.printf("click anywhere to begin!",0,250, love.graphics.getWidth(),"center")
    end
    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
end

function love.mousepressed( x, y, button, istouch, presses ) -- button == 1 means left click
    if gameState == 2 then
        if distanceBetween(x,y,target.x,target.y) <= target.radius then
            if button == 1 then
                score = score + 1
            elseif button == 2 then
                score = score + 2
                timer = timer - 1
            end
            target.x = math.random(target.radius,love.graphics.getWidth()-target.radius)
            target.y = math.random(target.radius,love.graphics.getHeight()-target.radius)
        else
            score = score - 1
        end
    elseif gameState == 1 then
        if button == 1 then 
            gameState = 2
            timer = 10
            score = 0
        end
    end
end

function distanceBetween(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2) 
end
