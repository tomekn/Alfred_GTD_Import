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

require('keymap')
require('map')
require('systems.tile_map_renderer')
require('entities.player')
local keymap = KeyMap()

_G.push = require('libs.push')
local game_scale, render_scale = 2, 2
local gameWidth, gameHeight = 320*game_scale, 180*game_scale--fixed game resolution

local windowWidth, windowHeight = gameWidth*render_scale, gameHeight*render_scale --make the window a bit smaller than the screen itself

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {highdpi = true, fullscreen = false, pixelperfect = true})

push:getCanvasTable('_render').canvas:setFilter('nearest', 'nearest')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    local player = Player({
        debug = true,
        position = vector(64, 64),
        velocity = vector(0,0),
        size = vector(16, 16),
    })

    keymap:set_player(player)

    _G.world = tiny.world(
        require('systems.movement'),
        require('systems.acceleration'),
        require('systems.debug_entity_draw'),
        require('systems.draw_mouse_pointer')
    )

    world:add(player)

    local map = Map('assets.test_map_1')
    local tiles = map:tiles()
    for _, tile in pairs(tiles) do
        world:add(tile)
    end
    _G.tile_rendering_system = require('systems.tile_map_renderer'):load_map(map)

    world:add(tile_rendering_system)
end

function love.update(dt)
    print(love.timer.getFPS())
    if world then
        world:update(dt, tiny.rejectAll('draw'))
    end

    keymap:process_mouse()
end

function love.draw()
    push:start()
    tile_rendering_system:render()
    if world then
        world:update(_, tiny.requireAll('draw'))
    end
    push:finish()
end

function love.keypressed(key, scan_code, is_repeat)
    keymap:process_key_event(key, 'key_pressed')
end

function love.keyreleased(key, scan_code, is_repeat)
    keymap:process_key_event(key, 'key_released')
end
