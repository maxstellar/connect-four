love.graphics.setBackgroundColor(0.125, 0.125, 0.125)

function love.draw()

    -- create the background
    for i=0,23 do
        love.graphics.push()
        love.graphics.translate(i*30 - 300, i*30 + 250)
        love.graphics.rotate(-math.pi / 4)
        if i % 2 == 0 then
            love.graphics.setColor(0.125, 0.125, 0.125)
        else
            love.graphics.setColor(0.1411764705882353125, 0.1411764705882353, 0.1411764705882353)
        end
        love.graphics.rectangle("fill", -50, -25, 1000, 50)
        love.graphics.pop()
    end

    -- create the game board
    love.graphics.setColor(0, 0.282, 0.812)
    love.graphics.rectangle("fill", 50, 100, 700, 430)
end