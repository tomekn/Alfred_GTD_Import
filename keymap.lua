KeyMap = Class{}

function KeyMap:init()
  self.player = nil
  self.mouse = {
    -- button 1
    {
      is_down = false,
      pressed_at = nil,
      released_at = nil,
      locations = {
        down = {x = nil, y = nil},
        in_betweens = {},
        up = {x = nil, y = nil},
      },
      callback = function(key_status, locations, down_for_seconds)
        local actions = {
          key_pressed = function(locations)
            -- print('mouse1 down')
          end,  
          key_repeat = function(locations)
            local tween = locations.in_betweens[#locations.in_betweens]
            -- print('mouse buton held down at x: '..tween.x..' y: '..tween.y)
          end,
          key_released = function(locations, down_for_seconds)
            -- print('mouse1 was down for '..down_for_seconds..' seconds ('..#(locations.in_betweens)..' frames)')
          end,
        }
        actions[key_status](locations, down_for_seconds)
      end
    },
    -- button 2
    {
      is_down = false,
      pressed_at = nil,
      released_at = nil,
      locations = {
        down = {x = nil, y = nil},
        in_betweens = {},
        up = {x = nil, y = nil},
      },
      callback = function(key_status, locations, down_for_seconds)
        local actions = {
          key_pressed = function(locations)
            -- print('mouse1 down')
          end,  
          key_repeat = function(locations)
            local tween = locations.in_betweens[#locations.in_betweens]
            -- print('mouse buton held down at x: '..tween.x..' y: '..tween.y)
          end,
          key_released = function(locations, down_for_seconds)
            -- print('mouse1 was down for '..down_for_seconds..' seconds ('..#(locations.in_betweens)..' frames)')
          end,
        }
        actions[key_status](locations, down_for_seconds)
      end
    }
  }
end

function KeyMap:set_player(player)
  self.player = player
  self.commands = self:commands()
end

function KeyMap:commands()
  return {
    -- continuous keybindings are meant for actions such as player movement where the
    -- player would move as long as the key is held down.
    -- Event handlers for these use the key_status attibute to handle key up/down properly.
    -- key_status == 'key_pressed' or 'key_released'
    continuous = {
      w = function(key_status)
        beholder.trigger('movable_move', self.player, 'up', key_status)
      end,
      s = function(key_status)
        beholder.trigger('movable_move', self.player, 'down', key_status)
      end,
      a = function(key_status)
        beholder.trigger('movable_move', self.player, 'left', key_status)
      end,
      d = function(key_status)
        beholder.trigger('movable_move', self.player, 'right', key_status)
      end,
    },
    momentary = {

    },
  }
end

function KeyMap:process_key_event(key, key_status)
  if key_status == 'key_pressed' then
    if (self.commands['continuous'][key] ~= nil) then
        self.commands['continuous'][key]('key_pressed')
        return
    end
    if self.commands['momentary'][key] ~= nil then
        self.commands['momentary'][key]()
    end
  else
    if self.commands['continuous'][key] ~= nil then
        self.commands['continuous'][key]('key_released')
    end
  end
end

function KeyMap:process_mouse()
  for index, button in ipairs(self.mouse) do
    if love.mouse.isDown(index) then
      -- handle mouse clicked
      if button.is_down ~= true then
        button.is_down = true
        button.pressed_at = love.timer.getTime()
        button.locations.down.x, button.locations.y = push:toGame(love.mouse.getX(), love.mouse.getY())
        button.callback('key_pressed', button.locations)
      else
        button.locations.in_betweens[#button.locations.in_betweens+1] = {x = love.mouse.getX(), y = love.mouse.getY()}
        button.callback('key_repeat', button.locations)
      end
    else
      -- handle mouse unclicked
      if button.is_down == true then
        button.is_down = false
        button.released_at = love.timer.getTime()
        local pressed_for = (button.released_at - button.pressed_at)
        button.locations.up = {x = love.mouse.getX(), y = love.mouse.getY()}
        button.callback('key_released', button.locations, pressed_for)
        button.released_at = nil
        button.pressed_at = nil
        button.locations.up = {x = nil, y = nil}
        button.locations.down = {x = nil, y = nil}
        button.locations.in_betweens = {}
      end
    end
    if button.is_down == true then
      button.callback('key_repeat', button.locations)
    end
  end
end
