local keyboard_system = tiny.system({})

local keymap = {
  ["left"] = function(dt)
    beholder.trigger('player_move_left', dt)
  end,
  ["right"] = function(dt)
    beholder.trigger('player_move_right')
  end,
  ["up"] = function(dt)
    beholder.trigger('player_move_up', dt)
  end,
  ["down"] = function(dt)
    beholder.trigger('player_move_down', dt)
  end,
}

function keyboard_system:update(world, dt)
  for key, key_callback in pairs(keymap) do
    if love.keyboard.isDown(key) then
      key_callback(dt)
    end
  end
end

return keyboard_system
