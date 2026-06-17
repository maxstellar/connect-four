love.graphics.setBackgroundColor(0.125, 0.125, 0.125)

function love.load()
    -- create board
    board = {}
    for x = 1, 7 do
        board[x] = {}
        for y = 1, 6 do
            board[x][y] = 0
        end
    end

    -- vars
    turn = 1
    winner = 0
end

function draw_game_state()
    for i=0, 6 do
        for j=0, 5 do
            if board[i+1][j+1] == 1 then
                love.graphics.setColor(1, 0, 0)
            elseif board[i+1][j+1] == 2 then
                love.graphics.setColor(1, 1, 0)
            else
                love.graphics.setColor(0.125, 0.125, 0.125)
            end

            love.graphics.circle("fill", 155 + i * 80, 100 + j * 80, 35)
        end
    end
end

function check_win_con(x, y, color)
    local directions = {
        {1, 0},  -- horizontal
        {0, 1},  -- vertical
        {1, 1},  -- diagonal up right
        {1, -1}, -- diagonal up left
    }

    for _, dir in ipairs(directions) do
        local dx, dy = dir[1], dir[2]
        local count = 1

        for i = 1, 3 do
            local nx, ny = x + dx * i, y + dy * i
            if nx >= 1 and nx <= 7 and ny >= 1 and ny <= 6 and board[nx][ny] == color then
                count = count + 1
            else
                break
            end
        end

        for i = 1, 3 do
            local nx, ny = x - dx * i, y - dy * i
            if nx >= 1 and nx <= 7 and ny >= 1 and ny <= 6 and board[nx][ny] == color then
                count = count + 1
            else
                break
            end
        end

        if count >= 4 then
            winner = color
            return
        end
    end
end

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
    love.graphics.rectangle("fill", 100, 50, 600, 500)
    draw_game_state()

    -- display winner
    if winner ~= 0 then
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    end
end

function love.mousepressed(x, y, button)
    if winner ~= 0 then
        return
    end
    if button == 1 then
        -- figure out which column was clicked
        local col = math.floor((x - 155) / 80 + 0.5) + 1

        -- make sure it's in-bounds
        if col >= 1 and col <= 7 then
            for row = 6, 1, -1 do
                if board[col][row] == 0 then
                    board[col][row] = turn
                    check_win_con(col, row, turn)
                    turn = 3 - turn
                    break
                end
            end
        end
    end
end