if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

_G.Class = require("libs.class")
_G.tiny = require('libs.tiny')
_G.beholder = require('libs.beholder')
_G.sti = require('libs.sti')
_G.gamestate = require('libs.gamestate')
_G.vector = require('libs.vector')

_G.utils = require('utils')
local keymap = require('keymap')

require('entities.player')

function love.load()
    local player = Player({
        debug = true,
        position = vector(64, 64),
        velocity = vector(0,0),
        size = vector(32, 32),
    })

    _G.world = tiny.world(
        require('systems.movement'),
        require('systems.acceleration'),
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

function love.keypressed(key, scan_code, is_repeat)
    if (keymap[key] ~= nil) then
        if keymap[key]['pressed'] ~= nil then
            keymap[key]['pressed']()
        else
            keymap[key]()
        end
    end
end

function love.keyreleased(key, scan_code, is_repeat)
    if keymap[key] then
        if keymap[key]['released'] then
            keymap[key]['released']()
        end
    end
end
