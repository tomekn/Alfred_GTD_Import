if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

_G.Class = require("libs.class")
_G.tiny = require('libs.tiny')
_G.beholder = require('libs.beholder')
_G.sti = require('libs.sti')
_G.gamestate = require('libs.gamestate')

_G.utils = require('utils')

require('entities.player')

function love.load()
    local player = Player({
        debug = true,
        position = {x=64, y=64},
        velocity = {x=0, y=0},
        size = {width=32, height=32},
    })

    _G.world = tiny.world(
        require('systems.movement'),
        require('systems.acceleration'),
        require('systems.keyboard'),
        require('systems.debug_entity_draw')
    )

    player:register_events()
    world:add(player)
end

function love.update(dt)
    if world then
        world:update(dt, tiny.rejectAll('draw'))
    end
end

function love.draw()
    local dt = love.timer.getDelta()
    if world then
        world:update(dt, tiny.requireAll('draw'))
    end
end
