class = require("libs.class")
-- vector = require('libs.vector')
tiny = require('libs.tiny')

function love.load()
    local player = require('entities.player')({x=200, y=200}, {x=40, y=0})
    print(player.to_s())
    
    _G.world = tiny.world(
        player,
        require('systems.movement_system')
    )
end

function love.update(dt)
    _G.world:update(dt)
end

function love.draw()
    love.graphics.print('Hello World!', 400, 300)
end